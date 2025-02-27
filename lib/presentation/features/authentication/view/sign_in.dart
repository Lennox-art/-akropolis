import 'dart:async';

import 'package:akropolis/data/utils/validations.dart';
import 'package:akropolis/domain/gen/assets.gen.dart';
import 'package:akropolis/presentation/features/authentication/models/authentication_state.dart';
import 'package:akropolis/presentation/features/authentication/view_model/authentication_view_model.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';

import 'package:akropolis/presentation/ui/themes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    required this.authenticationViewModel,
    super.key,
  });

  final AuthenticationViewModel authenticationViewModel;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final StreamSubscription<ToastMessage> toastStreamSubscription;
  late final StreamSubscription<AuthenticationState> authStateStreamSubscription;

  @override
  void initState() {
    toastStreamSubscription = widget.authenticationViewModel.toastStream.listen(_onToastMessage);
    authStateStreamSubscription = widget.authenticationViewModel.authenticationStateStream.listen(_onStateChange);
    super.initState();
  }

  void _onToastMessage(ToastMessage toast) {
    toast.show();
  }

  void _onStateChange(AuthenticationState state) {
    // Navigate to home page
    state.mapOrNull(authenticated: (a) {
      AppRoutes nextRoute = a.requiresOnboarding ? AppRoutes.welcome : AppRoutes.home;
      Navigator.of(context).pushNamed(nextRoute.path);
    }, partialSignUp: (p) {
      Navigator.of(context).pushNamed(AppRoutes.partialSignUp.path);
    });
  }

  @override
  void dispose() {
    toastStreamSubscription.cancel();
    authStateStreamSubscription.cancel();
    super.dispose();
  }

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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Hero(
                    tag: "logo",
                    child: Assets.akropolisLogo.svg(
                      height: 150,
                    ),
                  ),
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
                ListenableBuilder(
                  listenable: widget.authenticationViewModel,
                  builder: (_, __) {
                    return widget.authenticationViewModel.state.map(
                      loading: (_) => const InfiniteLoader(),
                      notAuthenticated: (_) => ElevatedButton.icon(
                        icon: Assets.google.svg(),
                        onPressed: () async {
                          widget.authenticationViewModel.signInWithGoogle();
                        },
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
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                          ),
                        ),
                      ),
                      authenticated: (_) => const Text("Welcome"),
                      partialSignUp: (_) => const Text("Incomplete sign up"),
                    );
                  },
                ),
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

class SignInWithEmailScreen extends StatefulWidget {
  const SignInWithEmailScreen({
    required this.authenticationViewModel,
    super.key,
  });

  final AuthenticationViewModel authenticationViewModel;

  @override
  State<SignInWithEmailScreen> createState() => _SignInWithEmailScreenState();
}

class _SignInWithEmailScreenState extends State<SignInWithEmailScreen> {
  late final StreamSubscription<ToastMessage> toastStreamSubscription;
  late final StreamSubscription<AuthenticationState> authStateStreamSubscription;

  @override
  void initState() {
    toastStreamSubscription = widget.authenticationViewModel.toastStream.listen(_onToastMessage);
    authStateStreamSubscription = widget.authenticationViewModel.authenticationStateStream.listen(_onStateChange);
    super.initState();
  }

  void _onToastMessage(ToastMessage toast) {
    toast.show();
  }

  void _onStateChange(AuthenticationState state) {
    // Navigate to home page
    state.mapOrNull(authenticated: (a) {
      AppRoutes nextRoute = a.requiresOnboarding ? AppRoutes.welcome : AppRoutes.home;
      Navigator.of(context).pushNamed(nextRoute.path);
    }, partialSignUp: (p) {
      Navigator.of(context).pushNamed(AppRoutes.partialSignUp.path);
    });
  }

  @override
  void dispose() {
    toastStreamSubscription.cancel();
    authStateStreamSubscription.cancel();
    super.dispose();
  }

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
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Hero(
              tag: "logo",
              child: Assets.akropolisLogo.svg(
                height: 150,
              ),
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
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            obscureText: obscure,
                            maxLength: 16,
                            minLines: 1,
                            decoration: InputDecoration(
                              hintText: "Enter your password",
                              suffixIcon: Visibility(
                                visible: obscure,
                                replacement: IconButton(
                                  onPressed: () {
                                    hidePasswordNotifier.value = !hidePasswordNotifier.value;
                                  },
                                  icon: const Icon(
                                    Icons.visibility_off,
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    hidePasswordNotifier.value = !hidePasswordNotifier.value;
                                  },
                                  icon: const Icon(
                                    Icons.visibility,
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
                          Navigator.of(context).pushNamed(AppRoutes.forgotPassword.path);
                        },
                        child: const Text("Forgot your password ?"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListenableBuilder(
            listenable: widget.authenticationViewModel,
            builder: (_, __) {
              return widget.authenticationViewModel.state.map(
                loading: (_) => const InfiniteLoader(),
                notAuthenticated: (l) {
                  return ElevatedButton(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;

                      String email = emailController.text;
                      String password = passwordController.text;
                      widget.authenticationViewModel.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );

                      /*if (signedInUser == null) return;
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
                      );*/
                    },
                    child: const Text("Sign in"),
                  );
                },
                authenticated: (_) => const Text("Welcome"),
                partialSignUp: (_) => const Text("Incomplete sign up"),
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
