import 'dart:async';

import '../../dependency_locator.dart';
import '../repositories/setting.dart';
import '../repositories/logging.dart';
import '../use_case.dart';

class ResetSettingsUseCase extends FutureUseCase<void> {
  final _settingRepository = dependencyLocator<SettingRepository>();
  final _loggingRepository = dependencyLocator<LoggingRepository>();

  @override
  Future<void> call() async {
    await _settingRepository.resetToDefaults();
    await _loggingRepository.enableRemoteLoggingIfSettingEnabled();
  }
}