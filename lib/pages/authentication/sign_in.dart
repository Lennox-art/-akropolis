import 'package:akropolis/constants/constants.dart';
import 'package:akropolis/routes/routes.dart';
import 'package:akropolis/theme/themes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              appName.toUpperCase(),
              style: theme.textTheme.titleLarge,
            ),
          ),
          Text(
            appSlogan,
            style: theme.textTheme.headlineSmall,
          ),
          Text(
            "Meaningful Video-Based Engagements",
            style: theme.textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
          Text(
            "Fostering connections through meaningful discussions",
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          ElevatedButton.icon(
            icon: const Icon(FontAwesomeIcons.google),
            onPressed: () {},
            label: const Text("Sign in with Google"),
            style: theme.elevatedButtonTheme.style?.copyWith(
              backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
              side: const WidgetStatePropertyAll(
                BorderSide(
                  width: 1.0,
                  color: secondaryColor,
                ),
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.email_outlined),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.signInWithEmail.path);
            },
            label: const Text("Sign in with Email"),
            style: theme.elevatedButtonTheme.style?.copyWith(
              backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
              side: const WidgetStatePropertyAll(
                BorderSide(
                  width: 1.0,
                  color: secondaryColor,
                ),
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
          ),
          Text.rich(
            TextSpan(
              text: "Don't have an account? ",
              children: [
                TextSpan(
                  text: "Sign up",
                  style: const TextStyle(
                    color: primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pushReplacementNamed(
                        AppRoutes.signUp.path,
                      );
                    },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SignInWithEmailScreen extends StatelessWidget {
  const SignInWithEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              appName.toUpperCase(),
              style: theme.textTheme.titleLarge,
            ),
          ),
          Text(
            "Sign in with email",
            style: theme.textTheme.headlineSmall,
          ),
          ListTile(
            title: const Text("Email"),
            subtitle: TextFormField(
              decoration:
                  const InputDecoration(hintText: "johndoe@example.abc"),
            ),
          ),
          ListTile(
            title: const Text("Password"),
            subtitle: TextFormField(
              decoration:
                  const InputDecoration(hintText: "Enter your password"),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.forgotPassword.path);
              },
              child: const Text("Forgot your password ?"),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.welcome.path);
            },
            child: const Text("Sign in"),
          ),
          Text.rich(
            TextSpan(
              text: "Don't have an account? ",
              children: [
                TextSpan(
                  text: "Sign up",
                  style: const TextStyle(
                    color: primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pushReplacementNamed(
                        AppRoutes.signUp.path,
                      );
                    },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
