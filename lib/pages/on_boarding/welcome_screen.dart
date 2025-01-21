import 'package:akropolis/constants/constants.dart';
import 'package:akropolis/routes/routes.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: null,),
      body: Flex(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        direction: Axis.vertical,
        children: [
          const SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Welcome to your new experience",
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            "Simplifies interaction by focusing on user-created videos rather than endless text threads",
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Image.asset("assets/connection_people.png"),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.welcomeTopics.path);
            },
            child: const Text('Continue'),
          ),

          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}


