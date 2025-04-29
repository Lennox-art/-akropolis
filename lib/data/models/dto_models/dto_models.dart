import 'dart:io';
import 'dart:typed_data';

import 'package:akropolis/data/models/local_models/local_models.dart';
import 'package:exception_base/exception_base.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dto_models.freezed.dart';

// sealed class Result {}
//
// class Success<T> extends Result {
//   final T data;
//   Success(this.data);
// }
//
// class Error extends Result {
//   final AppFailure errorMessage;
//   Error(this.errorMessage);
// }
//

@freezed
sealed class Result<T> with _$Result<T> {
  const factory Result.success({
    required T data,
  }) = Success<T>;

  const factory Result.error({
    required AppFailure failure,
  }) = Error;
}

/// Hash of a sha1 with validation
class Sha1 {
  final String hash;

  Sha1(this.hash) : assert(hash.length == 40);

  String get sub => hash.substring(0, 2);

  String get short => hash.substring(0, 6);
}

///Display progress
class ProgressModel {
  int sent;
  int total;

  ProgressModel({
    required this.sent,
    required this.total,
  }) : assert(total > 0);

  double get percent => (sent * 100) / total;

  @override
  String toString() => "$sent / $total = $percent %";
}

class MediaData {
  final File file;
  final MediaType mediaType;

  MediaData({
    required this.file,
    required this.mediaType,
  });
}

class MediaBlobData {
  final Uint8List blob;
  final MediaType mediaType;

  MediaBlobData({
    required this.blob,
    required this.mediaType,
  });
}

class CacheFileResult {
  final File file;
  final Sha1 sha1;

  CacheFileResult({
    required this.file,
    required this.sha1,
  });
}

enum MediaType {
  image,
  video;

  static Map<String, MediaType> mediaTypeEnumMap = {for (var e in values) e.name: e};
}

/*
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mplatform/mplatform.dart';
import 'package:network_service/network_service.dart';
import 'package:niwekee_prototype_mobile/data/models/local_models/local_models.dart';
import 'package:niwekee_prototype_mobile/data/models/remote_models/remote_models.dart';
import 'package:niwekee_prototype_mobile/data/utils/components/components.dart';
import 'package:niwekee_prototype_mobile/main.dart';
import 'package:niwekee_prototype_mobile/niwekee/routes/routes.dart';

Future<NotificationEntity> onBackgroundMessage(RemoteMessage rm) async {
  print("Remote message ${rm.toMap().toString()}");

  Map<String, dynamic> dataMap = rm.data;
  RemoteNotification? remoteNotification = rm.notification;

  FirebaseApiNotification notification = FirebaseApiNotification.fromJson(dataMap);
  NotificationEntity n = NotificationEntity.fromFirebaseApiNotification(
    notification,
    createdAt: rm.sentTime,
    messageId: rm.messageId,
  );

  log.d("Notification received");

  //TODO add notification
  // return await getIt<LocalDatabaseService>().addNotification(n);
  throw Exception("Bado");
}

Future<void> onDidReceiveNotificationResponse(NotificationResponse response) async {
  NotificationService.onClickNotification.add(response);
}

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static final StreamKit<NotificationResponse> onClickNotification = StreamKit.create(
    onListen: (data) {
      navigatorKey.currentState?.pushNamed(
        AppRoutes.notifications.path,
        // todo arguments: data,
      );
    },
  );
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<bool?> init() async {
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings("@mipmap/ic_launcher");
    final DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {
        print("Local Notification received $id");
      },
    );

    final InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    return await _notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  Future<void> initFirebase() async {
    //Notifications
    NotificationSettings notificationSettings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      sound: true,
      provisional: true,
    );

    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

    _firebaseMessaging.getInitialMessage().then((remoteMessage) async {
      navigatorKey.currentState?.pushNamed(
        AppRoutes.notifications.path,
        arguments: remoteMessage,
      );
    });

    FirebaseMessaging.onMessage.listen(
      (remoteMessage) async {
        print("onMessage Received");
        var n = await onBackgroundMessage(remoteMessage);
        showNotification(n);
        print("Notification shown");
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (remoteMessage) async {
        print("onMessageOpenedApp Received");
        var n = await onBackgroundMessage(remoteMessage);
        showNotification(n);
        print("Notification received opened app");
      },
    );
  }

  Future<String?> get apnsToken async => await _firebaseMessaging.getAPNSToken();

  Future<String?> get obtainFirebaseMessagingToken async {
    try {
      //await apnsToken;
      //todo ios apn tokens
      if (Platform.isIOS) return null;
      //TODO: Remove duration
      return await _firebaseMessaging.getToken().timeout(Duration(seconds: 4));
    } catch (e) {
      log.e(e);
      return null;
    }
  }

  Future<void> showNotification(NotificationEntity n) async {
    switch (Mplatform.current) {
      case Mplatform.android:
        await showAndroidNotification(
          title: n.title,
          subTitle: n.subtitle ?? '',
          body: n.message ?? '',
          payload: jsonEncode(n.customData),
          notificationId: n.notificationId,
          groupKey: n.groupKey ?? '',
          channel: NotificationChannel.urgent,
        );
        break;
      case Mplatform.ios:
        await _showIosNotification(
          title: n.title,
          subTitle: n.subtitle ?? '',
          body: n.message ?? '',
          payload: jsonEncode(n.customData),
          notificationId: n.notificationId,
          groupKey: n.groupKey ?? '',
          channel: NotificationChannel.urgent,
        );
        break;
      case _:
        break;
    }
  }

  Future<void> showAndroidNotification({
    required String title,
    required String subTitle,
    required String body,
    required String payload,
    required int notificationId,
    required String groupKey,
    bool ongoing = false,
    bool chronometerCountDown = false,
    UploadProgress? onProgress,
    required NotificationChannel channel,
    AndroidNotificationCategory category = AndroidNotificationCategory.event,
  }) async {
    NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        channel.channelId,
        channel.channelName,
        channelDescription: channel.channelDescription,
        icon: channel.icon,
        importance: channel.importance,
        priority: channel.priority,
        styleInformation: AndroidNotificationStyle(),
        groupKey: groupKey,
        setAsGroupSummary: true,
        groupAlertBehavior: GroupAlertBehavior.summary,
        ongoing: ongoing,
        subText: subTitle,
        enableLights: true,
        channelShowBadge: true,
        category: category,
        usesChronometer: onProgress != null,
        progress: onProgress?.sent ?? 0,
        maxProgress: onProgress?.total ?? 0,
        chronometerCountDown: chronometerCountDown,
        visibility: channel.visibility,
        audioAttributesUsage: AudioAttributesUsage.notificationRingtone,
      ),
    );
    await _notificationsPlugin.show(
      notificationId,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  Future<void> _showIosNotification({
    required String title,
    required String subTitle,
    required String body,
    required String payload,
    required int notificationId,
    required String groupKey,
    required NotificationChannel channel,
  }) async {
    NotificationDetails notificationDetails = NotificationDetails(
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBanner: true,
        presentBadge: true,
        presentSound: true,
        subtitle: subTitle,
        interruptionLevel: channel.interruption,
        categoryIdentifier: groupKey,
      ),
    );
    await _notificationsPlugin.show(
      notificationId,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  Future<void> cancelNotification(
    int notificationId, {
    String? tag,
  }) async {
    await _notificationsPlugin.cancel(notificationId, tag: tag);
  }

  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }
}
*/

enum NotificationChannel {
  urgent(
    channelId: "ak-urgent-2131",
    channelName: "Urgent",
    channelDescription: "For timely notifications",
  ),
  info(
    channelId: "ak-info-2947",
    channelName: "Informational",
    channelDescription: "For informative notifications",
  ),
  private(
    channelId: "ak-private-4922",
    channelName: "Private",
    channelDescription: "For private notifications",
  );

  final String channelId;
  final String channelName;
  final String channelDescription;

  const NotificationChannel({
    required this.channelId,
    required this.channelName,
    required this.channelDescription,
  });

  String get icon => "@mipmap/ic_launcher";
}

extension NotificationChannelX on NotificationChannel {
  Importance get importance => switch (this) {
        NotificationChannel.urgent => Importance.max,
        NotificationChannel.info => Importance.defaultImportance,
        NotificationChannel.private => Importance.high,
      };

  InterruptionLevel get interruption => switch (this) {
        NotificationChannel.urgent => InterruptionLevel.critical,
        NotificationChannel.info => InterruptionLevel.timeSensitive,
        NotificationChannel.private => InterruptionLevel.active,
      };

  Priority get priority => switch (this) {
        NotificationChannel.urgent => Priority.max,
        NotificationChannel.info => Priority.defaultPriority,
        NotificationChannel.private => Priority.high,
      };

  NotificationVisibility get visibility => switch (this) {
        NotificationChannel.urgent => NotificationVisibility.private,
        NotificationChannel.info => NotificationVisibility.public,
        NotificationChannel.private => NotificationVisibility.secret,
      };
}
