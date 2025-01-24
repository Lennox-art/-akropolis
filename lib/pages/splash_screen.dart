import 'package:akropolis/gen/assets.gen.dart';
import 'package:akropolis/routes/routes.dart';
import 'package:akropolis/state/authentication/authentication_cubit.dart';
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
      () {
        if (!mounted) return;
        User? user = BlocProvider.of<AuthenticationCubit>(context).getCurrentUser();
        AppRoutes nextRoute = user == null ? AppRoutes.login : AppRoutes.home;
        Navigator.of(context).pushNamedAndRemoveUntil(nextRoute.path, (_) => false);
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
