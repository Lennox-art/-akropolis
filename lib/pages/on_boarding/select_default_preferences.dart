import 'dart:io';

import 'package:akropolis/routes/routes.dart';
import 'package:flutter/material.dart';

class SelectDefaultPreferencesScreen extends StatelessWidget {
  const SelectDefaultPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          direction: Axis.vertical,
          children: [

            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Stay up to date",
                    style: theme.textTheme.bodyLarge,
                  ),
                  Text(
                    "Turn on notifications, and we’ll let you know when author post new videos",
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.home.path, (_) => false,
                );
              },
              child: const Text("Enable Notifications"),
            ),

            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.home.path, (_) => false,
                );
              },
              child: const Text("Skip this step"),
            ),

            const SizedBox(
              height: 28.0,
            ),

          ],
        ),
      ),
    );
  }
}