import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../resources/theme.dart';
import '../item.dart';

class RecentCallItem extends StatelessWidget {
  final RecentCall item;

  const RecentCallItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: _RecentItemAvatar(item),
      title: Text(item.name ?? item.phoneNumber),
      subtitle: _RecentItemSubtitle(item),
      trailing: IconButton(
        icon: Icon(
          Icons.more_vert,
          color: VialerColors.grey1,
        ),
        onPressed: () {},
      ),
    );
  }
}

class _RecentItemAvatar extends StatelessWidget {
  final RecentCall recentCall;

  const _RecentItemAvatar(this.recentCall, {Key key}) : super(key: key);

  String get _letters {
    final letters = recentCall.name.split(' ').map(
          (word) => word.substring(0, 1).toUpperCase(),
        );

    return letters.first + letters.last;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      alignment: Alignment.center,
      child: CircleAvatar(
        foregroundColor: Colors.white,
        backgroundColor: VialerColors.grey3,
        child: recentCall.name != null
            ? Text(
                _letters,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )
            : Icon(Icons.call, size: 20),
      ),
    );
  }
}

class _RecentItemSubtitle extends StatelessWidget {
  final RecentCall recentCall;

  const _RecentItemSubtitle(this.recentCall, {Key key}) : super(key: key);

  String _timeAgo(BuildContext context) => timeago.format(recentCall.time);

  String _time(BuildContext context) => DateFormat.jm().format(recentCall.time);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          recentCall.isIncoming ? Icons.call_made : Icons.call_received,
          color: VialerColors.green,
          size: 16,
        ),
        SizedBox(width: 8),
        Text(
          '${_timeAgo(context)}, ${_time(context)}',
          style: TextStyle(color: VialerColors.grey4),
        ),
      ],
    );
  }
}
