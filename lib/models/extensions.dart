
import 'package:akropolis/models/models.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension ShowToastX on ToastMessage {
  show() {
    Color backgroundColor = map(
      error: (_) => Colors.red,
      success: (_) => Colors.green,
      info: (_) => Colors.blue,
    );

    Color textColor = map(
      error: (_) => Colors.white,
      success: (_) => Colors.black,
      info: (_) => Colors.white,
    );

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }
}
