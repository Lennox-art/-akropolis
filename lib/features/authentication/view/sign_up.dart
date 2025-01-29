import 'package:akropolis/features/authentication/models/authentication_models.dart';
import 'package:akropolis/features/authentication/view_model/authentication_cubit/authentication_cubit.dart';
import 'package:akropolis/components/toast/toast.dart';
import 'package:akropolis/utils/constants.dart';
import 'package:akropolis/utils/validations.dart';
import 'package:akropolis/gen/assets.gen.dart';
import 'package:akropolis/features/on_boarding/view_model/user_cubit/user_cubit.dart';
import 'package:akropolis/routes/routes.dart';
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: null,
      ),
      body: Stack(
        children: [
          Assets.signInBg.image(
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          SafeArea(
            child: Flex(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              direction: Axis.vertical,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        appName.toUpperCase(),
                        style: theme.textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      appSlogan,
                      style: theme.textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Text(
                  "Well crafted Video-Based Engagements",
                  style: theme.textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Fostering connections through meaningful discussions",
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                BlocConsumer<AuthenticationCubit, AuthenticationState>(
                  listener: (_, state) {
                    state.mapOrNull(
                      loaded: (l) {
                        l.toast?.show();
                      },
                    );
                  },
                  builder: (_, state) {
                    return state.map(
                      loading: (_) => const CircularProgressIndicator.adaptive(),
                      loaded: (_) => ElevatedButton.icon(
                        icon: Assets.google.svg(),
                        onPressed: () async {
                          User? signedInUser =
                              await BlocProvider.of<AuthenticationCubit>(context)
                                  .signInWithGoogle();
                          if (signedInUser == null) return;
                          if (!context.mounted) return;
            
                          UserCubit userCubit = BlocProvider.of<UserCubit>(context);
                          AppUser? appUser = await userCubit.getCurrentUser();
            
                          if (appUser == null) {
                            await userCubit.saveAppUser(
                              AppUser(
                                id: signedInUser.uid,
                                displayName: signedInUser.displayName ?? '',
                                username: signedInUser.displayName ?? '',
                                email: signedInUser.email!,
                                profilePicture: signedInUser.photoURL,
                                topics: {},
                              ),
                            );
            
                            if (!context.mounted) return;
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRoutes.welcome.path,
                                  (_) => false,
                            );
                            return;
                          }
            
                          if (!context.mounted) return;
                          if (appUser.topics == null || (appUser.topics?.isEmpty ?? true)) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRoutes.welcomeTopics.path,
                                  (_) => false,
                            );
                            return;
                          }
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.home.path,
                                (_) => false,
                          );
                        },
                        label: const Text("Sign up with Google"),
                        style: theme.elevatedButtonTheme.style?.copyWith(
                          backgroundColor: const WidgetStatePropertyAll(
                            Colors.transparent,
                          ),
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
                    );
                  },
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
                    backgroundColor:
                        const WidgetStatePropertyAll(Colors.transparent),
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
    ValueNotifier<bool> hidePasswordNotifier = ValueNotifier(true);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
            child: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        title: const Text("Display Name"),
                        subtitle: TextFormField(
                          validator: validateDisplayName,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: displayNameController,
                          decoration:
                              const InputDecoration(hintText: "John Doe"),
                        ),
                      ),
                      ListTile(
                        title: const Text("Username"),
                        subtitle: TextFormField(
                          controller: usernameController,
                          validator: validateUsername,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            hintText: "@johndoe8734",
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text("Email"),
                        subtitle: TextFormField(
                          controller: emailController,
                          validator: validateEmail,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            hintText: "johndoe@example.abc",
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text("Password"),
                        subtitle: ValueListenableBuilder(
                          valueListenable: hidePasswordNotifier,
                          builder: (_, obscure, __) {
                            return TextFormField(
                              controller: passwordController,
                              validator: validatePassword,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              obscureText: obscure,
                              maxLength: 16,
                              minLines: 1,
                              decoration: InputDecoration(
                                hintText: "Enter your password",
                                suffixIcon: Visibility(
                                  visible: obscure,
                                  replacement: IconButton(
                                    onPressed: () {
                                      hidePasswordNotifier.value =
                                          !hidePasswordNotifier.value;
                                    },
                                    icon: const Icon(
                                      Icons.password_outlined,
                                    ),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      hidePasswordNotifier.value =
                                          !hidePasswordNotifier.value;
                                    },
                                    icon: const Icon(
                                      Icons.remove_red_eye_outlined,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          BlocConsumer<AuthenticationCubit, AuthenticationState>(
            listener: (context, state) {
              state.mapOrNull(
                loaded: (l) {
                  l.toast?.show();
                },
              );
            },
            builder: (context, state) {
              return state.map(
                loading: (_) => const CircularProgressIndicator.adaptive(),
                loaded: (l) {
                  return ElevatedButton(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;

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

                      UserCubit userCubit = BlocProvider.of<UserCubit>(
                        context,
                      );

                      AppUser? appUser = await userCubit.findUserById(
                        newUser.uid,
                      );

                      if (!context.mounted) return;
                      if(appUser != null) {

                        if(appUser.topics == null || (appUser.topics?.isEmpty ?? true)) {
                          Navigator.of(context).pushNamed(
                            AppRoutes.welcomeTopics.path,
                          );
                          return;
                        }


                        Navigator.of(context).pushNamed(
                          AppRoutes.home.path,
                        );
                        return;
                      }

                      AppUser newAppUser = AppUser(
                        id: newUser.uid,
                        displayName: displayName,
                        username: username,
                        email: email,
                        topics: {},
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
