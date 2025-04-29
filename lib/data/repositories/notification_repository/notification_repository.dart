
import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/local_models/local_models.dart';

abstract class NotificationRepository {

  Future<Result<void>> cancelNotification({required int notificationId});

  Future<Result<void>> cancelAllNotifications();

  Future<Result<List<LocalNotification>>> fetchLocalNotifications({
    required int page,
    required int pageSize,
});

  Future<Result<LocalNotification>> createNotification({
    required String title,
    required String subTitle,
    required String body,
    String? payload,
    required String groupKey,
    required NotificationChannel channel,
  });

  Future<Result<void>> showNotification({
    required LocalNotification notification,
    bool ongoing = false,
    bool chronometerCountDown = false,
    ProgressModel? onProgress,
  });
}
