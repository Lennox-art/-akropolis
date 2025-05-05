import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/themes.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  final ValueNotifier<bool> pauseNotification = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView(
        children: [

          const Padding(
            padding: EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              top: 10.0,
            ),
            child: Text(
              'Push notifications',
              style: TextStyle(color: primaryColor),
            ),
          ),

          ListTile(
            title: const Text('Pause All'),
            trailing: ValueListenableBuilder(
              valueListenable: pauseNotification,
              builder: (_, pause, __) {
                return Switch(
                  value: pause,
                  onChanged: (v) {
                    pauseNotification.value = v;
                  },
                );
              }
            ),
          ),

          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.prNotificationSettings.path,
              );
            },
            title: const Text('Post and replies'),
            trailing: const Icon(Icons.chevron_right),
          ),

          const ListTile(
            title: Text('From post'),
            trailing: Icon(Icons.chevron_right),
          ),

        ],
      ),
    );
  }
}
