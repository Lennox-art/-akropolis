import 'dart:io';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/utils/duration_style.dart';
import 'package:akropolis/domain/utils/functions.dart';
import 'package:flutter/foundation.dart';

import 'constants.dart';

String? validateEmail(String? email) {
  // Regular expression for email validation
  final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  if (email == null || email.isEmpty) {
    return "Email cannot be empty.";
  } else if (!emailRegex.hasMatch(email)) {
    return "Invalid email address.";
  }
  return null; // No error
}

String? validatePassword(String? password) {
  if (password == null || password.isEmpty) {
    return "Password cannot be empty";
  }
  if (password.length < 8) {
    return "Password must be at least 8 characters long";
  }
  /*if (!RegExp(r'[A-Z]').hasMatch(password)) {
    return "Password must contain at least one uppercase letter";
  }
  if (!RegExp(r'[a-z]').hasMatch(password)) {
    return "Password must contain at least one lowercase letter";
  }
  if (!RegExp(r'[0-9]').hasMatch(password)) {
    return "Password must contain at least one digit";
  }
  if (!RegExp(r'[!@#\$&*~]').hasMatch(password)) {
    return "Password must contain at least one special character (!@#\$&*~)";
  }*/
  return null; // No errors
}

String? validateUsername(String? username) {
  if (username == null || username.isEmpty) {
    return "Username cannot be empty";
  }
  return null; // No errors
}

String? validateDisplayName(String? displayName) {
  if (displayName == null || displayName.isEmpty) {
    return "Display name cannot be empty";
  }
  return null; // No errors
}

Future<String?> validateVideo(String? videoFilePath) async {
  if (videoFilePath == null) return "Video path";
  if (!File(videoFilePath).existsSync()) return "Video not found";

  Result<Duration> videoDuration = await getVideoDuration(videoFilePath);
  switch (videoDuration) {
    case Success<Duration>():
      if (videoDuration.data.compareTo(maxVideoDuration) > 0) {
        return "Video must not be more than ${maxVideoDuration.format(DurationStyle.FORMAT_MM_SS)}";
      }

      return null;
    case Error<Duration>():
      return videoDuration.failure.message;
  }
}
