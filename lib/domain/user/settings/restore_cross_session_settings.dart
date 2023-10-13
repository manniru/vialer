// ignore_for_file: unnecessary_cast

import 'package:vialer/app/util/loggable.dart';
import 'package:vialer/domain/use_case.dart';
import 'package:vialer/domain/user/settings/change_setting.dart';
import 'package:vialer/domain/user/settings/settings.dart';

import '../user.dart';
import 'clear_and_preserve_cross_session_settings.dart';

/// Restores any settings that were preserved via
/// `PreserveCrossSessionSettings`. This will apply these as new settings and
/// will therefore run all associated listeners.
class RestoreCrossSessionSettings extends UseCase with Loggable {
  Future<void> call(User user) async {
    // These settings have been stored but we need to make sure to apply their
    // side-effects again when restoring them.
    for (final key in preserve.where(
      (key) => user.settings.has(key as SettingKey<Object>),
    )) {
      await ChangeSettingUseCase()(
        key as SettingKey<Object>,
        user.settings.get(key as SettingKey<Object>),
        force: true,
      );
    }
  }
}
