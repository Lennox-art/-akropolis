import 'package:akropolis/features/authentication/models/authentication_models.dart';
import 'package:akropolis/features/authentication/view_model/authentication_cubit/authentication_cubit.dart';
import 'package:akropolis/utils/constants.dart';
import 'package:akropolis/gen/assets.gen.dart';
import 'package:akropolis/features/on_boarding/view_model/user_cubit/user_cubit.dart';
import 'package:akropolis/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> checkAccountState(BuildContext context) async {

}

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
        User? user = BlocProvider.of<AuthenticationCubit>(context).getCurrentUser();
        if (user == null) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.login.path,
                (_) => false,
          );
          return;
        }

        AppUser? appUser = await BlocProvider.of<UserCubit>(context).getCurrentUser();
        if (!mounted) return;

        if (appUser == null) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.login.path,
                (_) => false,
          );
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
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Assets.splashScreenBg.image(
            height: double.infinity,
            width: double.infinity,
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  appName.toUpperCase(),
                  style: theme.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                Text(
                  appSlogan,
                  style: theme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
