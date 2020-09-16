import 'package:equatable/equatable.dart';

class Call extends Equatable {
  static const _idKey = 'id';
  static const _dateKey = 'call_date';
  static const _durationKey = 'atime';
  static const _callerNumberKey = 'caller_num';
  static const _sourceNumberKey = 'src_number';
  static const _callerIdKey = 'callerid';
  static const _originalCallerIdKey = 'orig_callerid';
  static const _destinationNumberKey = 'dst_number';
  static const _directionKey = 'direction';

  final int id;

  /// Always UTC.
  final DateTime date;

  final Duration duration;

  final String callerNumber;
  final String sourceNumber;

  final String callerId;
  final String originalCallerId;

  final String destinationNumber;

  final Direction direction;

  bool get wasMissed =>
      direction == Direction.inbound && duration == Duration.zero;

  Call({
    this.id,
    this.date,
    this.duration,
    this.callerNumber,
    this.sourceNumber,
    this.callerId,
    this.originalCallerId,
    this.destinationNumber,
    this.direction,
  });

  factory Call.fromJson(Map<String, dynamic> json) {
    return Call(
      id: json[_idKey] as int,
      date: DateTime.parse(json[_dateKey] as String),
      duration: Duration(seconds: json[_durationKey] as int),
      callerNumber: json[_callerNumberKey] as String,
      sourceNumber: json[_sourceNumberKey] as String,
      callerId: json[_callerIdKey] as String,
      originalCallerId: json[_originalCallerIdKey] as String,
      destinationNumber: json[_destinationNumberKey] as String,
      direction: _directionFromJson(json[_directionKey] as String),
    );
  }

  Call copyWith({
    int id,
    DateTime date,
    Duration duration,
    String callerNumber,
    String sourceNumber,
    String callerId,
    String originalCallerId,
    String destinationNumber,
    Direction direction,
  }) {
    return Call(
      id: id ?? this.id,
      date: date ?? this.date,
      duration: duration ?? this.duration,
      callerNumber: callerNumber ?? this.callerNumber,
      sourceNumber: sourceNumber ?? this.sourceNumber,
      callerId: callerId ?? this.callerId,
      originalCallerId: originalCallerId ?? this.originalCallerId,
      destinationNumber: destinationNumber ?? this.destinationNumber,
      direction: direction ?? this.direction,
    );
  }

  bool get isInbound => direction == Direction.inbound;

  bool get isOutbound => direction == Direction.outbound;

  @override
  String toString() {
    return '$id: $destinationNumber';
  }

  @override
  List<Object> get props => [id];
}

enum Direction {
  inbound,
  outbound,
}

Direction _directionFromJson(String json) {
  return json == 'outbound' ? Direction.outbound : Direction.inbound;
}
