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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:akropolis/components/loader.dart';


class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
                      ),
                    ),
                    Text(
                      appSlogan,
                      style: theme.textTheme.headlineSmall,
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
                }, builder: (_, state) {
                  return state.map(
                    loading: (_) => const InfiniteLoader(),
                    loaded: (_) => ElevatedButton.icon(
                      icon: Assets.google.svg(),
                      onPressed: () async {
                        User? signedInUser =
                            await BlocProvider.of<AuthenticationCubit>(context)
                                .signInWithGoogle();
                        if (signedInUser == null) return;
                        if (!context.mounted) return;

                        UserCubit userCubit = BlocProvider.of<UserCubit>(context);
                        AppUser? appUser = await userCubit.findUserById(
                          signedInUser.uid,
                        );

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
                        if(appUser.topics == null || (appUser.topics?.isEmpty ?? true)) {
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
                      label: const Text("Sign in with Google"),
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
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
                      ),
                    ),
                  );
                }),
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.email_outlined,
                    color: iconColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.signInWithEmail.path);
                  },
                  label: const Text("Sign in with Email"),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      children: [
                        TextSpan(
                          text: "Sign up",
                          style: const TextStyle(
                            color: primaryColor,
                            decorationColor: primaryColor,
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
                ),
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
    final ThemeData theme = Theme.of(context);

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
            "Sign in with email",
            style: theme.textTheme.headlineSmall,
          ),
          Expanded(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.forgotPassword.path);
                        },
                        child: const Text("Forgot your password ?"),
                      ),
                    ),
                  ],
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
                loading: (_) => const InfiniteLoader(),
                loaded: (l) {
                  return ElevatedButton(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;

                      String email = emailController.text;
                      String password = passwordController.text;

                      AuthenticationCubit authCubit =
                          BlocProvider.of<AuthenticationCubit>(context);

                      User? signedInUser =
                          await authCubit.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );

                      if (signedInUser == null) return;
                      if (!context.mounted) return;

                      UserCubit userCubit = BlocProvider.of<UserCubit>(context);
                      AppUser? appUser = await userCubit.findUserById(
                        signedInUser.uid,
                      );

                      if (appUser == null) return;
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
                    child: const Text("Sign in"),
                  );
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text.rich(
              TextSpan(
                text: "Don't have an account? ",
                children: [
                  TextSpan(
                    text: "Sign up",
                    style: const TextStyle(
                      color: primaryColor,
                      decorationColor: primaryColor,
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
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
