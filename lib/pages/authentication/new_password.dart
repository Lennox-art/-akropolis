import 'package:akropolis/routes/routes.dart';
import 'package:flutter/material.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "New Password",
            style: theme.textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          Text(
            "Your new password should be different from previously used password",
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          ListTile(
            title: const Text("New Password"),
            subtitle: TextFormField(
              decoration:
                  const InputDecoration(hintText: "Enter your new password"),
            ),
          ),
          ListTile(
            title: const Text("Confirm New Password"),
            subtitle: TextFormField(
              decoration:
                  const InputDecoration(hintText: "Enter your new password"),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.welcome.path,
                (_) => false,
              );
            },
            child: const Text("Create New Password"),
          ),
        ],
      ),
    );
  }
}
