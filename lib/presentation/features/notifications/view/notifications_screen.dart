import 'dart:async';

import 'package:akropolis/data/models/local_models/local_models.dart';
import 'package:akropolis/presentation/features/notifications/model/notifications_state.dart';
import 'package:akropolis/presentation/features/notifications/view_model/notifications_view_model.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({
    required this.notificationsViewModel,
    super.key,
  });

  final NotificationsViewModel notificationsViewModel;

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

  late final StreamSubscription<ToastMessage> toastSubscription;

  @override
  void initState() {
    toastSubscription = widget.notificationsViewModel.toastStream.listen((toast) => toast.show());
    super.initState();
  }

  @override
  void dispose() {
    toastSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
      ),
      body: ListenableBuilder(
        listenable: widget.notificationsViewModel,
        builder: (_, __) {
          NotificationsState notificationsState = widget.notificationsViewModel.state;
          List<MapEntry<String, List<LocalNotification>>> notificationMap = widget.notificationsViewModel.notificationMap.entries.toList();
          return Visibility(
            visible: notificationMap.isNotEmpty,
            replacement: const Center(
              child: Text("You do not have notification yet"),
            ),
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                bool isLoading = notificationsState is LoadingNotificationsState;
                bool isAtEndOfList = scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent;
            
                print("isLoading $isLoading : isAtEndOfList $isAtEndOfList");
            
                if (!isLoading && isAtEndOfList) {
                  widget.notificationsViewModel.loadMoreItems();
                }
            
                return true;
              },
              child: ListView.builder(
                itemCount: notificationMap.length + (notificationsState is LoadingNotificationsState ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= notificationMap.length) {
                    return const InfiniteLoader();
                  }
            
                  String date = notificationMap[index].key;
                  List<LocalNotification> notifications = notificationMap[index].value;
            
                  return ExpansionTile(
                    title: Text(date),
                    children: notifications.map((n) => NotificationTile(notification: n)).toList(),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  const NotificationTile({required this.notification, super.key});

  final LocalNotification notification;

  @override
  Widget build(BuildContext context) {
    return ListTile();
  }
}
