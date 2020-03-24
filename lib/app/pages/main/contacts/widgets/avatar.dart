import 'package:flutter/material.dart';
import 'package:characters/characters.dart';

import '../../../../resources/theme.dart';
import '../../../../../domain/entities/contact.dart';

class ContactAvatar extends StatelessWidget {
  static const _defaultSize = 36.0;

  final Contact contact;
  final double size;

  const ContactAvatar(
    this.contact, {
    Key key,
    this.size = _defaultSize,
  }) : super(key: key);

  String get _letters {
    final letters = contact.name.split(' ').map(
          (word) => word.characters.first.toUpperCase(),
        );

    return letters.first + letters.last;
  }

  @override
  Widget build(BuildContext context) {
    final hasAvatar = contact.avatar != null && contact.avatar.isNotEmpty;

    return Container(
      width: size,
      alignment: Alignment.center,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: CircleAvatar(
          foregroundColor: Colors.white,
          backgroundColor: context.brandTheme.grey3,
          backgroundImage: hasAvatar ? MemoryImage(contact.avatar) : null,
          child: !hasAvatar
              ? Text(
                  _letters,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16 * (size / _defaultSize),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}