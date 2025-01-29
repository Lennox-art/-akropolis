
import 'package:akropolis/features/authentication/view/forgot_password.dart';
import 'package:akropolis/features/authentication/view/login.dart';
import 'package:akropolis/features/authentication/view/new_password.dart';
import 'package:akropolis/features/authentication/view/sign_in.dart';
import 'package:akropolis/features/authentication/view/sign_up.dart';
import 'package:akropolis/pages/home_page.dart';
import 'package:akropolis/features/on_boarding/presentation/select_default_preferences.dart';
import 'package:akropolis/features/on_boarding/presentation/select_topic.dart';
import 'package:akropolis/features/on_boarding/presentation/welcome_screen.dart';
import 'package:akropolis/pages/splash_screen.dart';
import 'package:flutter/material.dart';

enum AppRoutes {
  splashScreen("/"),
  login("/login"),
  signIn("/signIn"),
  signInWithEmail("/signInEmail"),
  signUp("/signUp"),
  signUpWithEmail("/signUpWithEmail"),
  forgotPassword("/forgotPassword"),
  newPassword("/newPassword"),
  welcome("/welcome"),
  welcomeTopics("/welcomeTopics"),
  welcomePreferences("/welcomePreferences"),
  home("/home");

  final String path;

  const AppRoutes(this.path);

  Widget get page => switch(this) {
    AppRoutes.splashScreen => const SplashScreen(),
    AppRoutes.login => const LoginScreen(),
    AppRoutes.signIn => const SignInScreen(),
    AppRoutes.signInWithEmail => const SignInWithEmailScreen(),
    AppRoutes.signUp => const SignUpPage(),
    AppRoutes.signUpWithEmail => const SignUpWithEmailScreen(),
    AppRoutes.forgotPassword => const ForgotPasswordScreen(),
    AppRoutes.newPassword => const NewPasswordScreen(),
    AppRoutes.welcome => const WelcomeScreen(),
    AppRoutes.welcomeTopics => const SelectTopicScreen(),
    AppRoutes.welcomePreferences => const SelectDefaultPreferencesScreen(),
    AppRoutes.home => const HomePage(),
  };
}