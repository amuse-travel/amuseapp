import 'package:flutter/material.dart';

InputDecoration underlineTextFieldDecoration({String hintText}) {
  return InputDecoration(
    hintText: hintText,
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        width: 0.8,
        color: Colors.grey,
      ),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        width: 0.8,
      ),
    ),
  );
}
