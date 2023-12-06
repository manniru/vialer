import 'dart:async';

import 'package:vialer/domain/user/settings/change_setting.dart';

import '../../../../dependency_locator.dart';
import '../../../call_records/client/purge_local_call_records.dart';
import '../../../voipgrid/user_permissions.dart';
import '../../settings/app_setting.dart';
import '../../user.dart';
import '../user_refresh_task_performer.dart';

typedef Permissions = Set<Permission>;

class RefreshVoipgridUserPermissions extends UserRefreshTaskPerformer {
  const RefreshVoipgridUserPermissions();

  @override
  Future<UserMutator> performUserRefreshTask(User user) async {
    late final List<VoipgridPermission> granted;

    try {
      granted = await dependencyLocator<UserPermissionsRepository>()
          .getGrantedPermissions(
        user: user,
      );
    } on UnableToRetrievePermissionsException {
      // If we are unable to get the current permissions we should just leave
      // the current permission as it is.
      return unmutatedUser;
    }

    final permissions = granted.toUserPermissions();

    return (User user) => _applyPermissionsSideEffects(permissions, user)
        .copyWith(permissions: permissions);
  }

  User _applyPermissionsSideEffects(Permissions permissions, User user) {
    if (permissions.contains(Permission.canSeeClientCalls)) return user;

    unawaited(
      PurgeLocalCallRecordsUseCase()(reason: PurgeReason.permissionFailed),
    );

    var newUser = user;

    // If client calls are enabled, we're going to disable it as the user
    // no longer has permission for it.
    if (user.settings.getOrNull(AppSetting.showClientCalls) == true) {
      ChangeSettingUseCase()(AppSetting.showClientCalls, false);
    }

    return newUser;
  }
}

extension on List<VoipgridPermission> {
  static const _mapping = {
    VoipgridPermission.clientCalls: Permission.canSeeClientCalls,
    VoipgridPermission.changeMobileNumberFallback:
        Permission.canChangeMobileNumberFallback,
    VoipgridPermission.viewVoicemail: Permission.canViewVoicemailAccounts,
    VoipgridPermission.changeVoipAccount: Permission.canChangeOutgoingNumber,
    VoipgridPermission.listUsers: Permission.canViewColleagues,
    VoipgridPermission.listVoipAccounts: Permission.canViewVoipAccounts,
    VoipgridPermission.viewRouting: Permission.canViewDialPlans,
    VoipgridPermission.viewStats: Permission.canViewStats,
    VoipgridPermission.changeOpeningHours: Permission.canChangeOpeningHours,
  };

  Permissions toUserPermissions() {
    var permissions = Permissions.from(
      this
          .where((permission) => _mapping.containsKey(permission))
          .map((permission) => _mapping[permission]!),
    );

    if (contains(VoipgridPermission.viewVoicemail) &&
        contains(VoipgridPermission.temporaryRedirect)) {
      // The only redirect target currently is Voicemail, so if the user
      // cannot view Voicemail they can't use the feature.
      permissions.add(Permission.canChangeTemporaryRedirect);
    }

    return permissions;
  }
}
