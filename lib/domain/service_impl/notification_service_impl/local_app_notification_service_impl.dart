import 'dart:async';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/local_models/local_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/services/notification_service/app_notification_service.dart';
import 'package:akropolis/main.dart';
import 'package:exception_base/exception_base.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/src/platform_specifics/android/enums.dart';

class FlutterLocalNotificationServiceImpl extends AppNotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin;

  FlutterLocalNotificationServiceImpl({
    required FlutterLocalNotificationsPlugin notificationsPlugin,
    required InitializationSettings settings,
  }) : _notificationsPlugin = notificationsPlugin {
    init(settings);
  }

  @override
  Future<Result<void>> cancelNotification(
    int notificationId, {
    String? tag,
  }) async {
    try {
      await _notificationsPlugin.cancel(notificationId, tag: tag);
      return const Success(data: null);
    } catch (e, trace) {
      return Error(
        failure: AppFailure(
          message: "Failed to cancel notification $notificationId",
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<void>> cancelAllNotifications() async {
    try {
      await _notificationsPlugin.cancelAll();
      return const Success(data: null);
    } catch (e, trace) {
      return Error(
        failure: AppFailure(
          message: "Failed to cancel all notifications",
          trace: trace,
        ),
      );
    }
  }

  @override
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
  }) async {
    try {
      await _notificationsPlugin.show(
        notificationId,
        title,
        body,
        NotificationDetails(
          android: notificationDetails,
        ),
        payload: payload,
      );

      return const Success(data: null);
    } catch (e, trace) {
      return Error(
        failure: AppFailure(
          message: "Failed to show android notification",
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<void>> showIosNotification({
    required String title,
    required String subTitle,
    required String body,
    required String payload,
    required int notificationId,
    required String groupKey,
    required DarwinNotificationDetails notificationDetails,
  }) async {
    try {
      await _notificationsPlugin.show(
        notificationId,
        title,
        body,
        NotificationDetails(
          iOS: notificationDetails,
        ),
        payload: payload,
      );
      return const Success(data: null);
    } catch (e, trace) {
      return Error(
        failure: AppFailure(
          message: "Failed to show ios notification",
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<void>> init(InitializationSettings settings) async {
    try {
      bool? initialized = await _notificationsPlugin.initialize(settings);
      if (true == initialized) {
        return const Success(data: null);
      }

      return Error(
        failure: AppFailure(
          message: "Failed to initialize notifications",
          trace: settings,
          failureType: FailureType.illegalStateFailure,
        ),
      );
    } catch (e, trace) {
      return Error(
        failure: AppFailure(
          message: "Failed to initialize settings",
          trace: trace,
        ),
      );
    }
  }
}
