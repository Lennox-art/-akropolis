import 'dart:async';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/local_models/local_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/notification_repository/notification_repository.dart';
import 'package:akropolis/data/services/data_storage_service/local_data_storage_service.dart';
import 'package:akropolis/data/services/notification_service/app_notification_service.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ReceiveBackgroundMessageUseCase {
  final NotificationRepository _notificationRepository;
  final FlutterLocalNotificationsPlugin _notificationsPlugin;

  
  ReceiveBackgroundMessageUseCase({
    required FlutterLocalNotificationsPlugin notificationsPlugin,
    required NotificationRepository notificationRepository,
  })  : _notificationRepository = notificationRepository,
        _notificationsPlugin = notificationsPlugin {
    

  }
}
