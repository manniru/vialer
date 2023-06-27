import 'package:vialer/app/util/loggable.dart';
import 'package:vialer/domain/calling/call_through/call_through.dart';
import 'package:vialer/domain/use_case.dart';

import '../../../dependency_locator.dart';
import '../../legacy/storage.dart';
import '../../user/get_logged_in_user.dart';
import '../../user/user.dart';

/// A usecase that wraps the logic of determining whether or not to display the
/// outgoing number prompt for a given user and the number they have dialed.
class ShouldPromptUserForOutgoingNumber extends UseCase with Loggable {
  User get _user => GetLoggedInUserUseCase()();
  late final storageRepository = dependencyLocator<StorageRepository>();

  bool call({required String destination}) {
    if (destination.isInternalNumber) {
      _log('internal number');
      return false;
    }

    if (!_user.permissions.canChangeOutgoingNumber) {
      _log('permissions');
      return false;
    }

    if (_user.client.outgoingNumbers.length < 2) {
      _log('user only has 1 outgoing number');
      return false;
    }

    if (storageRepository.doNotShowOutgoingNumberSelector) {
      _log('user requested to not be asked again');
      return false;
    }

    return true;
  }

  void _log(String reason) => logger.info(
        'Skipping outgoing number prompt due to [$reason].',
      );
}
