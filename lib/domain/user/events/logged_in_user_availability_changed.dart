import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vialer/domain/relations/user_availability_status.dart';

import '../../event/event_bus.dart';
import '../../relations/colleagues/availability_update.dart';

part 'logged_in_user_availability_changed.freezed.dart';

/// We've received an availability update for the logged-in user.
@freezed
class LoggedInUserAvailabilityChanged
    with _$LoggedInUserAvailabilityChanged
    implements EventBusEvent {
  const factory LoggedInUserAvailabilityChanged({
    required AvailabilityUpdate availability,
    required UserAvailabilityStatus userAvailabilityStatus,
  }) = _LoggedInUserAvailabilityChanged;
}