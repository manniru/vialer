import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StylizedTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData prefixIcon;
  final String labelText;

  StylizedTextField({
    Key key,
    this.labelText,
    this.prefixIcon,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
  }) : super(key: key);

  static const color = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 4,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon, color: color, size: 16),
          labelText: labelText,
          border: inputBorder,
          enabledBorder: inputBorder,
          disabledBorder: inputBorder,
          focusedBorder: inputBorder,
          labelStyle: TextStyle(
            color: color,
          ),
          focusColor: color,
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(0),
          hasFloatingPlaceholder: false,
        ),
        style: TextStyle(
          color: Colors.black,
        ),
        obscureText: obscureText,
        keyboardType: keyboardType,
      ),
    );
  }

  final InputBorder inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(
      style: BorderStyle.none,
      width: 0,
    ),
  );
}