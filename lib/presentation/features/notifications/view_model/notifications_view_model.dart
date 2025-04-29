import 'dart:async';
import 'dart:collection';
import 'package:collection/collection.dart';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/local_models/local_models.dart';
import 'package:akropolis/data/repositories/notification_repository/notification_repository.dart';
import 'package:akropolis/presentation/features/notifications/model/notifications_state.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationsViewModel extends ChangeNotifier {
  final NotificationRepository _notificationRepository;
  final StreamController<ToastMessage> _toastStreamController = StreamController.broadcast();
  final SplayTreeSet<LocalNotification> _notificationList = SplayTreeSet();
  int _page = 0;
  NotificationsState _state = LoadedNotificationsState();
  final dateFormatter = DateFormat('yyyy-MM-dd');

  NotificationsViewModel({
    required NotificationRepository notificationRepository,
  }) : _notificationRepository = notificationRepository {
    loadMoreItems();
  }

  NotificationsState get state => _state;

  Stream<ToastMessage> get toastStream => _toastStreamController.stream;

  LinkedHashMap<String, List<LocalNotification>> get notificationMap {
    Map<String, List<LocalNotification>> groupedNotifications = groupBy(_notificationList, (n) => dateFormatter.format(n.addedAt));

    final sortedKeys = groupedNotifications.keys.toList()..sort((a, b) => b.compareTo(a));

    return LinkedHashMap<String, List<LocalNotification>>.fromEntries(
      sortedKeys.map((key) => MapEntry(key, groupedNotifications[key]!)),
    );
  }

  Future<void> loadMoreItems() async {
    if (_state is! LoadedNotificationsState) return;

    try {
      _state = const LoadingNotificationsState();
      notifyListeners();

      Result<List<LocalNotification>> fetchNotificationResult = await _notificationRepository.fetchLocalNotifications(
        page: _page,
        pageSize: 20,
      );

      switch (fetchNotificationResult) {
        case Success<List<LocalNotification>>():
          _notificationList.addAll(fetchNotificationResult.data);
          _page++;
          break;
        case Error<List<LocalNotification>>():
          _toastStreamController.add(ToastError(message: fetchNotificationResult.failure.message));
          break;
      }
    } finally {
      _state = const LoadedNotificationsState();
      notifyListeners();
    }
  }
}
