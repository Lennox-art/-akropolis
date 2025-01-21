import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
            "Forgot Password",
            style: theme.textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          Text(
            "Enter the email associated with your account and we will send an email with instructions to reset your password",
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          ListTile(
            title: const Text("Email"),
            subtitle: TextFormField(
              decoration:
              const InputDecoration(hintText: "johndoe@example.abc"),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Reset Password"),
          ),
        ],
      ),
    );
  }
}
