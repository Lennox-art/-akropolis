import 'package:akropolis/constants/constants.dart';
import 'package:akropolis/routes/routes.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Flex(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        direction: Axis.vertical,
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Welcome to your new experience",
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            "Simplifies interaction by focusing on user-created videos rather than endless text threads",
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/connection_people.png"),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.welcomeTopics.path);
            },
            child: const Text('Continue'),
          ),

        ],
      ),
    );
  }
}


