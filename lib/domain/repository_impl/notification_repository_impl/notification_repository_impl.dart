import 'dart:async';
import 'dart:math';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/local_models/local_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/notification_repository/notification_repository.dart';
import 'package:akropolis/data/services/data_storage_service/local_data_storage_service.dart';
import 'package:akropolis/data/services/notification_service/app_notification_service.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:exception_base/exception_base.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final AppNotificationService _localAppNotificationService;
  final LocalDataStorageService _localDataStorageService;
  final TargetPlatform _targetPlatform;
  static late final StreamSubscription<RemoteMessage> _onBackgroundMessageSubscription;
  static late final StreamSubscription<NotificationResponse> _onNotificationResponseSubscription;
  static final StreamController<NotificationResponse> onClickNotificationStreamController = StreamController.broadcast();
  static final StreamController<RemoteMessage> onBackgroundMessageController = StreamController.broadcast();


  NotificationRepositoryImpl({
    required AppNotificationService localAppNotificationService,
    required LocalDataStorageService localDataStorageService,
    required TargetPlatform targetPlatform,
  })  : _localAppNotificationService = localAppNotificationService,
        _targetPlatform = targetPlatform,
        _localDataStorageService = localDataStorageService {
    _onNotificationResponseSubscription = onClickNotificationStreamController.stream.listen(
          (data) {
        navigatorKey.currentState?.pushNamed(
          AppRoutes.notifications.path,
          arguments: data,
        );
      },
    );

    _onBackgroundMessageSubscription = onBackgroundMessageController.stream.listen((rm) async {
      FirebaseApiNotification f = FirebaseApiNotification.fromJson(rm.data);

      Result<LocalNotification> createdNotification = await createNotification(
        title: f.title,
        body: f.message ?? '',
        payload: f.notificationData,
        subTitle: f.subtitle ?? '',
        groupKey: f.groupKey ?? '',
        //TODO: adapt channel
        channel: NotificationChannel.info,
      );

      switch (createdNotification) {
        case Success<LocalNotification>():
          Result<void> shownNotification = await showNotification(
            notification: createdNotification.data,
          );

          switch (shownNotification) {
            case Success<void>():
              debugPrint("Notification has been shown");
              break;

            case Error<void>():
              debugPrint(shownNotification.failure.message);
              break;
          }

        case Error<LocalNotification>():
          debugPrint(createdNotification.failure.message);
          break;
      }
    });
  }


  @override
  Future<Result<void>> cancelNotification({required int notificationId}) async {
    try {
      return await _localAppNotificationService.cancelNotification(notificationId);
    } catch (e, trace) {
      return Error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<void>> cancelAllNotifications() async {
    try {
      return await _localAppNotificationService.cancelAllNotifications();
    } catch (e, trace) {
      return Error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<LocalNotification>> createNotification({
    required String title,
    required String subTitle,
    required String body,
    String? payload,
    required String groupKey,
    required NotificationChannel channel,
  }) async {
    try {
      return await _localDataStorageService.saveLocalNotification(
        notification: LocalNotification(
          id: Random().nextInt(200000),
          title: title,
          subTitle: subTitle,
          payload: payload,
          body: body,
          groupKey: groupKey,
          channel: channel,
          addedAt: DateTime.now(),
        ),
      );
    } catch (e, trace) {
      return Error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<List<LocalNotification>>> fetchLocalNotifications({
    required int page,
    required int pageSize,
  }) async {
    try {
      return await _localDataStorageService.fetchNotifications(
        page: page,
        pageSize: pageSize,
      );
    } catch (e, trace) {
      return Error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<void>> showNotification({
    required LocalNotification notification,
    bool ongoing = false,
    bool chronometerCountDown = false,
    ProgressModel? onProgress,
  }) async {
    try {
      NotificationChannel channel = notification.channel;
      switch (_targetPlatform) {
        case TargetPlatform.android:
          Result<void> showAndroidNotificationResult = await _localAppNotificationService.showAndroidNotification(
            title: notification.title,
            subTitle: notification.subTitle,
            body: notification.body,
            payload: notification.payload ?? '',
            notificationId: notification.id,
            groupKey: notification.groupKey,
            notificationDetails: AndroidNotificationDetails(
              channel.channelId,
              channel.channelName,
              channelDescription: channel.channelDescription,
              icon: channel.icon,
              importance: channel.importance,
              priority: channel.priority,
              styleInformation: const DefaultStyleInformation(true, true),
              groupKey: notification.groupKey,
              setAsGroupSummary: true,
              groupAlertBehavior: GroupAlertBehavior.summary,
              ongoing: ongoing,
              subText: notification.subTitle,
              enableLights: true,
              channelShowBadge: true,
              usesChronometer: onProgress != null,
              progress: onProgress?.sent ?? 0,
              maxProgress: onProgress?.total ?? 0,
              chronometerCountDown: chronometerCountDown,
              visibility: channel.visibility,
              audioAttributesUsage: AudioAttributesUsage.notificationRingtone,
            ),
          );

          switch (showAndroidNotificationResult) {
            case Success<void>():
              return const Success(data: null);
            case Error<void>():
              return Error(failure: showAndroidNotificationResult.failure);
          }
        case TargetPlatform.iOS:
          Result<void> showIosNotificationResult = await _localAppNotificationService.showIosNotification(
            title: notification.title,
            subTitle: notification.subTitle,
            body: notification.body,
            payload: notification.payload ?? '',
            notificationId: notification.id,
            groupKey: notification.groupKey,
            notificationDetails: DarwinNotificationDetails(
              presentAlert: true,
              presentBanner: true,
              presentBadge: true,
              presentSound: true,
              subtitle: notification.subTitle,
              interruptionLevel: channel.interruption,
              categoryIdentifier: notification.groupKey,
            ),
          );
          switch (showIosNotificationResult) {
            case Success<void>():
              return const Success(data: null);
            case Error<void>():
              return Error(failure: showIosNotificationResult.failure);
          }
        default:
          debugPrint("Unsupported platform $_targetPlatform");
          return Error(
            failure: AppFailure(
              message: "Unsupported platform $_targetPlatform",
              trace: _targetPlatform,
              failureType: FailureType.illegalStateFailure,
            ),
          );
      }
    } catch (e, trace) {
      return Error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }
}
