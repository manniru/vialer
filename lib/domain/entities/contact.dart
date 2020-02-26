import 'dart:typed_data';

import 'item.dart';

class Contact {
  final String initials;
  final String name;
  final Uint8List avatar;
  final List<Item> phoneNumbers;
  final List<Item> emails;

  Contact({
    this.initials,
    this.name,
    this.avatar,
    this.phoneNumbers = const [],
    this.emails = const [],
  });
}