import 'dart:async';

import '../../dependency_locator.dart';
import '../entities/setting.dart';
import '../repositories/destination.dart';
import '../repositories/metrics.dart';
import '../repositories/storage.dart';
import '../use_case.dart';
import 'disable_remote_logging.dart';
import 'enable_remote_logging.dart';
import 'get_settings.dart';
import 'register_to_voip_middleware.dart';
import 'start_voip.dart';
import 'unregister_to_voip_middleware.dart';

class ChangeSettingUseCase extends UseCase {
  final _storageRepository = dependencyLocator<StorageRepository>();
  final _destinationRepository = dependencyLocator<DestinationRepository>();
  final _metricsRepository = dependencyLocator<MetricsRepository>();

  final _getSettings = GetSettingsUseCase();
  final _enableRemoteLogging = EnableRemoteLoggingUseCase();
  final _disableRemoteLogging = DisableRemoteLoggingUseCase();
  final _registerToVoipMiddleware = RegisterToVoipMiddlewareUseCase();
  final _unregisterToVoipMiddleware = UnregisterToVoipMiddlewareUseCase();
  final _startVoip = StartVoipUseCase();

  Future<void> call({required Setting setting, bool remote = true}) async {
    if (setting is RemoteLoggingSetting) {
      if (setting.value) {
        await _enableRemoteLogging();
      } else {
        await _disableRemoteLogging();
      }
    } else if (remote && setting is AvailabilitySetting) {
      var availability = setting.value;
      await _destinationRepository.setAvailability(
        selectedDestinationId: availability!.selectedDestinationInfo!.id,
        phoneAccountId: availability.selectedDestinationInfo!.phoneAccountId,
        fixedDestinationId:
            availability.selectedDestinationInfo!.fixedDestinationId,
      );

      availability = await _destinationRepository.getLatestAvailability();
      setting = AvailabilitySetting(availability);
    }

    if (!setting.mutable) {
      throw UnsupportedError(
        'Vialer error: Unsupported operation: '
        'Don\'t save an immutable setting.',
      );
    }

    final settings = await _getSettings();

    final newSettings = List<Setting>.from(settings)
      ..removeWhere((e) => e.runtimeType == setting.runtimeType)
      ..add(setting);

    // We only want to save mutable settings.
    await _storageRepository
        .setSettings(newSettings.where((s) => s.mutable).toList());

    // We do this after writing the setting so setting checks work.
    if (setting is UseVoipSetting && setting.value == true) {
      try {
        await _registerToVoipMiddleware();
        await _startVoip();
        // ignore: avoid_catching_errors
      } on Error {}
    } else if (setting is DndSetting) {
      // This will happen in the background because we do not need to rely
      // on this to have happened when the user changes the setting.
      if (setting.value) {
        _unregisterToVoipMiddleware();
      } else {
        _registerToVoipMiddleware();
      }

      _metricsRepository
          .track('dnd-status-changed', {'enabled': setting.value});
    }
  }
}
