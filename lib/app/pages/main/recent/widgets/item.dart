import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../resources/theme.dart';
import '../../../../../domain/entities/call.dart';

import '../../../../resources/localizations.dart';

class RecentCallItem extends StatelessWidget {
  final Call call;
  final VoidCallback onPressed;

  const RecentCallItem({Key key, this.call, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      onTap: onPressed,
      leading: _RecentItemAvatar(call),
      title: Text(call.destinationName),
      subtitle: _RecentItemSubtitle(call),
      trailing: IconButton(
        icon: Icon(
          VialerSans.ellipsis,
          color: context.brandTheme.grey1,
          size: 16,
        ),
        onPressed: () {},
      ),
    );
  }
}

class _RecentItemAvatar extends StatelessWidget {
  final Call call;

  const _RecentItemAvatar(this.call, {Key key}) : super(key: key);

  String get _letters {
    final letters = call.destinationName.split(' ').map(
          (word) => word.substring(0, 1).toUpperCase(),
        );

    if (letters.length == 1) {
      return letters.first;
    } else {
      return letters.first + letters.last;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      alignment: Alignment.center,
      child: CircleAvatar(
        foregroundColor: Colors.white,
        backgroundColor: context.brandTheme.grey3,
        child: call.destinationContactName != null
            ? Text(
                _letters,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )
            : Icon(VialerSans.phone, size: 20),
      ),
    );
  }
}

class _RecentItemSubtitle extends StatelessWidget {
  final Call call;

  const _RecentItemSubtitle(this.call, {Key key}) : super(key: key);

  String _timeAgo(BuildContext context) => timeago.format(
        call.localDate,
        locale: '${VialerLocalizations.of(context).locale.languageCode}_short',
      );

  String _time(BuildContext context) => DateFormat.jm().format(call.localDate);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          call.wasMissed
              ? VialerSans.missedCall
              : call.direction == Direction.outbound
                  ? VialerSans.outgoingCall
                  : VialerSans.incomingCall,
          color: call.wasMissed ? Colors.red : context.brandTheme.green1,
          size: 12,
        ),
        SizedBox(width: 8),
        Text(
          '${_timeAgo(context)}, ${_time(context)}',
          style: TextStyle(color: context.brandTheme.grey4),
        ),
      ],
    );
  }
}

extension CallDestinationName on Call {
  String get destinationName => destinationContactName ?? destinationNumber;
}
