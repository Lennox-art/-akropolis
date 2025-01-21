import 'package:akropolis/constants/constants.dart';
import 'package:akropolis/routes/routes.dart';
import 'package:akropolis/theme/themes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
            label: const Text("Sign up with Google"),
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
              Navigator.of(context).pushNamed(AppRoutes.signUpWithEmail.path);
            },
            label: const Text("Sign up with Email"),
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
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Text.rich(
            TextSpan(
              text: "Already have an account? ",
              children: [
                TextSpan(
                  text: "Sign in",
                  style: const TextStyle(
                    color: primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pushReplacementNamed(
                        AppRoutes.signIn.path,
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

class SignUpWithEmailScreen extends StatelessWidget {
  const SignUpWithEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: SingleChildScrollView(
        child: Column(
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
              "Sign up with email",
              style: theme.textTheme.headlineSmall,
            ),
            ListTile(
              title: const Text("Display Name"),
              subtitle: TextFormField(
                decoration: const InputDecoration(hintText: "John Doe"),
              ),
            ),
            ListTile(
              title: const Text("Username"),
              subtitle: TextFormField(
                decoration: const InputDecoration(hintText: "@johndoe8734"),
              ),
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

            ElevatedButton(
              onPressed: () async {
                await showEmailOTPDialog(context);
                if(!context.mounted) return;

                Navigator.of(context).pushNamed(AppRoutes.newPassword.path);
              },
              child: const Text("Create Account"),
            ),
            Text.rich(
              TextSpan(
                text:
                    "By clicking “Create Account”, you acknowledge that you have read and understood, and agree to Akropolis’",
                children: [
                  TextSpan(
                    text: "Terms & Conditions",
                    style: const TextStyle(
                      color: primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  const TextSpan(
                    text: " and ",
                  ),
                  TextSpan(
                    text: "Privacy Policy",
                    style: const TextStyle(
                      color: primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmailOTPBottomSheet extends StatelessWidget {
  const EmailOTPBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BottomSheet(
      onClosing: () {},
      builder: (_) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Check your inbox",
                style: theme.textTheme.headlineSmall,
              ),
              Text(
                "Enter the code that was sent to x to sign up",
                style: theme.textTheme.bodyMedium,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormField(),
                    ),
                    Expanded(
                      child: TextFormField(),
                    ),
                    Expanded(
                      child: TextFormField(),
                    ),
                    Expanded(
                      child: TextFormField(),
                    ),
                    Expanded(
                      child: TextFormField(),
                    ),
                    Expanded(
                      child: TextFormField(),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Sign Up"),
              ),
              TextButton(
                onPressed: () {},
                child: Text("Resend Code (60)"),
              ),
            ],
          ),
        );
      },
    );
  }
}

Future<T?> showEmailOTPDialog<T>(BuildContext context) {
  return showModalBottomSheet<T>(
    isScrollControlled: true,
    isDismissible: false,
    context: context,
    builder: (c) => const EmailOTPBottomSheet(),
  );
}
