import 'package:akropolis/gen/assets.gen.dart';
import 'package:akropolis/models/models.dart';
import 'package:akropolis/routes/routes.dart';
import 'package:akropolis/state/authentication/authentication_cubit.dart';
import 'package:akropolis/state/user_cubit/user_cubit.dart';
import 'package:akropolis/theme/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        if (!mounted) return;

        User? user =
            BlocProvider.of<AuthenticationCubit>(context).getCurrentUser();
        if (user == null) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoutes.login.path, (_) => false);
          return;
        }

        AppUser? appUser =
            await BlocProvider.of<UserCubit>(context).getCurrentUser();
        if (!mounted) return;

        if (appUser == null) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoutes.login.path, (_) => false);
          return;
        }

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
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Assets.splashScreen.svg(
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
