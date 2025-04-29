import 'dart:io';
import 'dart:typed_data';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/local_models/local_models.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:network_service/network_service.dart';

abstract class AppNotificationService {

  /// Function: [init] that has already been shown the current device
  /// Returns: [Result.success], when notification has been shown
  Future<Result<void>> init(InitializationSettings settings);

  /// Function: [cancelNotification] cancels a notification that has already been shown the current device
  /// Returns: [Result.success], when notification has been shown
  Future<Result<void>> cancelNotification(
    int notificationId, {
    String? tag,
  });

  /// Function: [cancelAllNotifications] cancels all notification that have already been shown the current device
  /// Returns: [Result.success], when notification has been shown
  Future<Result<void>> cancelAllNotifications();

  /// Function: [_showIosNotification] shows a notification based to ios devices
  /// Returns: [Result.success], when notification has been shown
  Future<Result<void>> showIosNotification({
    required String title,
    required String subTitle,
    required String body,
    required String payload,
    required int notificationId,
    required String groupKey,
    required DarwinNotificationDetails notificationDetails,
  });

  /// Function: [_showAndroidNotification] shows a notification based to android devices
  /// Returns: [Result.success], when notification has been shown
  Future<Result<void>> showAndroidNotification({
    required String title,
    required String subTitle,
    required String body,
    required String payload,
    required int notificationId,
    required String groupKey,
    bool ongoing = false,
    bool chronometerCountDown = false,
    ProgressModel? onProgress,
    required AndroidNotificationDetails notificationDetails,
    AndroidNotificationCategory category = AndroidNotificationCategory.event,
  });
}
