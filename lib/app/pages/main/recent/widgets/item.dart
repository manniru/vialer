import 'package:dartx/dartx.dart';
import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../domain/entities/call_record.dart';
import '../../../../../domain/entities/call_record_with_contact.dart';
import '../../../../resources/localizations.dart';
import '../../../../resources/theme.dart';
import '../../../../util/contact.dart';
import '../../util/color.dart';
import '../../widgets/avatar.dart';
import '../../widgets/contact_list/widgets/group_header.dart';
import 'popup_menu.dart';


class RecentCallItem extends StatelessWidget {
  final CallRecordWithContact callRecord;

  /// Also called when whole item is pressed.
  final VoidCallback onCallPressed;
  final VoidCallback onCopyPressed;

  const RecentCallItem({
    Key? key,
    required this.callRecord,
    required this.onCopyPressed,
    required this.onCallPressed,
  }) : super(key: key);

  void _onPopupMenuItemPress(RecentCallMenuAction _action) {
    switch (_action) {
      case RecentCallMenuAction.copy:
        onCopyPressed();
        break;
      case RecentCallMenuAction.call:
        onCallPressed();
        break;
      case RecentCallMenuAction.none:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Avatar(
        name: callRecord.displayLabel,
        backgroundColor: calculateColorForPhoneNumber(
          context,
          callRecord.thirdPartyNumber,
        ),
        showFallback: callRecord.contact?.displayName == null,
        image: callRecord.contact?.avatar,
        fallback: const Icon(VialerSans.phone, size: 20),
      ),
      title: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onCallPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(callRecord.displayLabel),
            const SizedBox(height: 2),
            _RecentItemSubtitle(callRecord),
          ],
        ),
      ),
      // Empty onTap so we still keep the splash behavior
      onTap: () => {},
      trailing: RecentItemPopupMenu(
        callRecord: callRecord,
        onPopupMenuItemPress: _onPopupMenuItemPress,
      ),
    );
  }
}

class _RecentItemSubtitle extends StatelessWidget {
  final CallRecord callRecord;

  const _RecentItemSubtitle(this.callRecord, {Key? key}) : super(key: key);

  String get _time => DateFormat.Hm().format(callRecord.date.toLocal());

  IconData _icon(BuildContext context) {
    if (callRecord.answeredElsewhere) return VialerSans.answeredElsewhere;

    if (callRecord.wasMissed) return VialerSans.missedCall;

    return callRecord.isOutbound
        ? VialerSans.outgoingCall
        : VialerSans.incomingCall;
  }

  Color _iconColor(BuildContext context) {
    if (callRecord.wasMissed) return Colors.red;

    if (callRecord.answeredElsewhere) {
      return context.brand.theme.colors.answeredElsewhere;
    }

    return context.brand.theme.colors.green1;
  }

  String _text(BuildContext context) {
    if (callRecord.wasMissed) return _time;

    final duration = prettyDuration(
      callRecord.duration,
      abbreviated: true,
      delimiter: ' ',
      spacer: '',
    );

    return '$_time, $duration';
  }

  String _createAnsweredElsewhereText() {
    if (callRecord.destination.name == null ||
        callRecord.destination.name!.isEmpty ||
        callRecord.destination.name == callRecord.destination.number) {
      return '${callRecord.destination.number}';
    } else {
      return '${callRecord.destination.name} '
          '(${callRecord.destination.number})';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Icon(
              _icon(context),
              color: _iconColor(context),
              size: 12,
            ),
            const SizedBox(width: 8),
            Text(
              _text(context),
              style: TextStyle(
                color: context.brand.theme.colors.grey4,
                fontSize: 12,
              ),
            ),
          ],
        ),
        if (callRecord.answeredElsewhere)
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              _createAnsweredElsewhereText(),
              style: TextStyle(color: context.brand.theme.colors.grey4),
            ),
          ),
      ],
    );
  }
}

extension CallDestinationLabel on CallRecordWithContact {
  String get displayLabel {
    final contact = this.contact;

    // We always want to prioritize a local contact in the user's phone.
    if (contact != null) return contact.displayName;

    // When a colleague is calling, they may have a display name setup so
    // we will use that. We don't want to use the display name for other calls
    // as dial-plans may set a variable callername, which would mean the
    // recents list doesn't show any relevant information about the caller.
    if (callType == CallType.colleague && thirdPartyName.isNotNullOrEmpty) {
      return thirdPartyName!;
    }

    return thirdPartyNumber;
  }
}

class RecentCallHeader extends StatelessWidget {
  final DateTime date;
  final bool isFirst;
  final Widget child;

  const RecentCallHeader({
    required this.date,
    required this.child,
    this.isFirst = false,
  });

  String _text(
    BuildContext context, {
    required DateTime headerDate,
  }) {
    final today = DateTime.now().toLocal();
    final yesterday = today.subtract(
      const Duration(
        days: 1,
      ),
    );

    if (headerDate.isAtSameDayAs(today)) {
      return context.msg.main.recent.list.headers.today.toUpperCase();
    } else if (headerDate.isAtSameDayAs(yesterday)) {
      return context.msg.main.recent.list.headers.yesterday.toUpperCase();
    }

    return DateFormat('d MMMM y').format(headerDate);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isFirst) const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
            top: isFirst ? 15 : 10,
          ),
          child: GroupHeader(
            group: _text(
              context,
              headerDate: date.toLocal(),
            ),
            padding: const EdgeInsets.all(0),
          ),
        ),
        child,
      ],
    );
  }
}
