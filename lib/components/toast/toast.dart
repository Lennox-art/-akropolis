import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'toast.freezed.dart';

@freezed
class ToastMessage with _$ToastMessage {
  const factory ToastMessage.error({
    @Default("Error") String title,
    @Default('Something went wrong') String message,
  }) = ToastError;

  const factory ToastMessage.success({
    @Default("Success") String title,
    required String message,
  }) = ToastSuccess;

  const factory ToastMessage.info({
    @Default("Info") String title,
    required String message,
  }) = ToastInfo;
}

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