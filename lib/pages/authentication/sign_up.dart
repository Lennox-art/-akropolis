import 'package:akropolis/constants/constants.dart';
import 'package:akropolis/gen/assets.gen.dart';
import 'package:akropolis/models/models.dart';
import 'package:akropolis/routes/routes.dart';
import 'package:akropolis/state/authentication/authentication_cubit.dart';
import 'package:akropolis/state/user_cubit/user_cubit.dart';
import 'package:akropolis/theme/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: Flex(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        direction: Axis.vertical,
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
            style: theme.textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          Text(
            "Fostering connections through meaningful discussions",
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          ElevatedButton.icon(
            icon: Assets.google.svg(),
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
            icon: const Icon(
              Icons.email_outlined,
              color: iconColor,
            ),
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
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
            child: Text.rich(
              TextSpan(
                text: "Already have an account? ",
                children: [
                  TextSpan(
                    text: "Sign in",
                    style: const TextStyle(
                      color: primaryColor,
                      decorationColor: primaryColor,
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
    TextEditingController displayNameController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: Flex(
        direction: Axis.vertical,
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
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      title: const Text("Display Name"),
                      subtitle: TextFormField(
                        controller: displayNameController,
                        decoration: const InputDecoration(hintText: "John Doe"),
                      ),
                    ),
                    ListTile(
                      title: const Text("Username"),
                      subtitle: TextFormField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                          hintText: "@johndoe8734",
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text("Email"),
                      subtitle: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: "johndoe@example.abc",
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text("Password"),
                      subtitle: TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          hintText: "Enter your password",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              return state.map(
                loading: (_) => const CircularProgressIndicator.adaptive(),
                loaded: (l) {
                  return ElevatedButton(
                    onPressed: () async {
                      String username = usernameController.text;
                      String password = passwordController.text;
                      String displayName = displayNameController.text;
                      String email = emailController.text;

                      AuthenticationCubit authCubit =
                          BlocProvider.of<AuthenticationCubit>(
                        context,
                      );

                      User? newUser =
                          await authCubit.signUpWithEmailAndPassword(
                        email: email,
                        password: password,
                      );

                      if (newUser == null) return;
                      if (!context.mounted) return;

                      AppUser newAppUser = AppUser(
                        id: newUser.uid,
                        displayName: displayName,
                        username: username,
                        email: email,
                        topics: {},
                      );

                      UserCubit userCubit = BlocProvider.of<UserCubit>(
                        context,
                      );

                      await userCubit.saveAppUser(newAppUser);
                      //await showEmailOTPDialog(context);

                      if (!context.mounted) return;

                      newUser = await authCubit.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );

                      if (!context.mounted) return;
                      if (newUser == null) {
                        Navigator.of(context).pushNamed(
                          AppRoutes.signInWithEmail.path,
                        );
                        return;
                      }

                      Navigator.of(context).pushNamed(
                        AppRoutes.welcome.path,
                      );
                    },
                    child: const Text("Create Account"),
                  );
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text.rich(
              style: theme.textTheme.bodySmall,
              TextSpan(
                text:
                    "By clicking “Create Account”, you acknowledge that you have read and understood, and agree to Akropolis’ ",
                children: [
                  TextSpan(
                    text: "Terms & Conditions",
                    style: const TextStyle(
                      color: primaryColor,
                      decorationColor: primaryColor,
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
                      decorationColor: primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
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
      constraints: const BoxConstraints(
        minHeight: 300,
        maxHeight: 500,
      ),
      onClosing: () {},
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Flex(
            mainAxisSize: MainAxisSize.min,
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: Navigator.of(context).pop,
                  icon: const Icon(
                    Icons.cancel_outlined,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Check your inbox",
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              Text(
                "Enter the code that we sent to x to sign up",
                style: theme.textTheme.bodyMedium,
              ),
              Expanded(
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(),
                      ),
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
