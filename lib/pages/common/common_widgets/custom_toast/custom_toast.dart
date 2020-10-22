import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  CustomToast({
    @required this.message,
  }) : assert(message != null);
  final String message;

  void show() {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black.withOpacity(0.5),
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 16
    );
  }
}
