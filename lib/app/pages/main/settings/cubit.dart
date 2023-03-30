import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../dependency_locator.dart';
import '../../../../domain/authentication/logout.dart';
import '../../../../domain/calling/voip/perform_echo_cancellation_calibration.dart';
import '../../../../domain/event/event_bus.dart';
import '../../../../domain/feedback/send_saved_logs_to_remote.dart';
import '../../../../domain/legacy/storage.dart';
import '../../../../domain/onboarding/request_permission.dart';
import '../../../../domain/openings_hours_basic/should_show_opening_hours_basic.dart';
import '../../../../domain/user/connectivity/connectivity_type.dart';
import '../../../../domain/user/connectivity/get_current_connectivity_status.dart';
import '../../../../domain/user/events/logged_in_user_was_refreshed.dart';
import '../../../../domain/user/get_build_info.dart';
import '../../../../domain/user/get_logged_in_user.dart';
import '../../../../domain/user/get_permission_status.dart';
import '../../../../domain/user/permissions/permission.dart';
import '../../../../domain/user/permissions/permission_status.dart';
import '../../../../domain/user/refresh_user.dart';
import '../../../../domain/user/settings/call_setting.dart';
import '../../../../domain/user/settings/change_settings.dart';
import '../../../../domain/user/settings/settings.dart';
import '../../../../domain/user/user.dart';
import '../../../../domain/voipgrid/user_voip_config.dart';
import '../../../util/loggable.dart';
import 'state.dart';

export 'state.dart';

class SettingsCubit extends Cubit<SettingsState> with Loggable {
  final _changeSettings = ChangeSettingsUseCase();
  final _getBuildInfo = GetBuildInfoUseCase();
  final _sendSavedLogsToRemote = SendSavedLogsToRemoteUseCase();
  final _getPermissionStatus = GetPermissionStatusUseCase();
  final _requestPermission = RequestPermissionUseCase();
  final _logout = Logout();
  final _performEchoCancellationCalibration =
      PerformEchoCancellationCalibrationUseCase();
  final _getUser = GetLoggedInUserUseCase();
  final _shouldShowOpeningHoursBasic = ShouldShowOpeningHoursBasic();

  final _refreshUser = RefreshUser();
  final _getConnectivity = GetCurrentConnectivityTypeUseCase();

  final _storageRepository = dependencyLocator<StorageRepository>();
  final _eventBus = dependencyLocator<EventBusObserver>();

  final List<_SettingChangeRequest> _changesBeingProcessed = [];

  SettingsCubit() : super(SettingsState(user: GetLoggedInUserUseCase()())) {
    _emitUpdatedState();
    _eventBus.on<LoggedInUserWasRefreshed>(
      (event) => _emitUpdatedState(user: event.user),
    );
  }

  bool get _isUpdatingRemote => _changesBeingProcessed
      .where((request) => !request.hasTimedOut)
      .isNotEmpty;

  Future<void> _emitUpdatedState({
    User? user,
  }) async {
    // We don't want to emit any refresh changes while we're in the progress
    // of changing remote settings.
    if (_isUpdatingRemote) return;

    user = user ?? _getUser();

    emit(
      SettingsState(
        user: user,
        buildInfo: await _getBuildInfo(),
        isVoipAllowed: user.voip.isAllowedCalling,
        hasIgnoreBatteryOptimizationsPermission: await _getPermissionStatus(
          permission: Permission.ignoreBatteryOptimizations,
        ).then(
          (status) => status == PermissionStatus.granted,
        ),
        userNumber: _storageRepository.userNumber,
        availableDestinations: _storageRepository.availableDestinations,
        isApplyingChanges: _isUpdatingRemote,
      ),
    );
  }

  static const _remoteSettings = [
    CallSetting.destination,
    CallSetting.mobileNumber,
    CallSetting.outgoingNumber,
    CallSetting.useMobileNumberAsFallback,
  ];

  /// Returns `true` if [key] refers to a remote setting and we have an
  /// internet connection, or if [key] does not refer to a remote setting.
  Future<bool> canChangeRemoteSetting<T extends Object>(
    SettingKey<T> key,
  ) async =>
      !_remoteSettings.contains(key) ||
      await _getConnectivity().then((c) => c.isConnected);

  Future<void> changeSetting<T extends Object>(
    SettingKey<T> key,
    T value,
  ) async {
    // Immediately emit a copy of the state with the changed setting for extra
    // smoothness.
    final newSettings = Settings({key: value});

    // We're going to track any requests to update remote and then make sure
    // we don't update the settings page while that's happening. This also
    // allows us to prevent input until changes have finished.
    final _changeRequest = _SettingChangeRequest();
    _changesBeingProcessed.add(_changeRequest);
    emit(state.withChanged(newSettings, isApplyingChanges: true));
    await _changeSettings(newSettings);
    _changesBeingProcessed.remove(_changeRequest);
    _emitUpdatedState();
  }

  Future<void> refreshAvailability() async {
    logger.info('Refreshing availability');
    await _refreshUser(tasksToRun: [UserRefreshTask.availability]);
    await _emitUpdatedState();
  }

  Future<void> requestBatteryPermission() => _requestPermission(
        permission: Permission.ignoreBatteryOptimizations,
      );

  Future<void> sendSavedLogsToRemote() => _sendSavedLogsToRemote();

  Future<void> refresh() => _emitUpdatedState();

  bool get shouldShowOpeningHoursBasic => _shouldShowOpeningHoursBasic();

  Future<void> logout() async {
    logger.info('Logging out');
    await _logout();
    logger.info('Logged out');
  }

  Future<void> performEchoCancellationCalibration() =>
      _performEchoCancellationCalibration();
}

class _SettingChangeRequest {
  final DateTime time = DateTime.now();

  /// An arbitrary time before we determine that our setting change request
  /// has timed out. Note that this does not indicate a timeout of the HTTP
  /// request which will still count as completed.
  bool get hasTimedOut =>
      time.isBefore(DateTime.now().subtract(const Duration(seconds: 15)));
}
