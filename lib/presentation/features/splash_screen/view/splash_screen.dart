import 'dart:async';

import 'package:akropolis/domain/gen/assets.gen.dart';
import 'package:akropolis/presentation/features/splash_screen/models/splash_models.dart';
import 'package:akropolis/presentation/features/splash_screen/view_model/splash_screen_view_model.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    required this.splashScreenViewModel,
    super.key,
  });

  final SplashScreenViewModel splashScreenViewModel;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final StreamSubscription<SplashScreenState> authenticationResultStreamSubscription;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authenticationResultStreamSubscription = widget.splashScreenViewModel.splashScreenStateResult.listen(_onAuthenticationResult);
      widget.splashScreenViewModel.checkAuthenticationResult();
    });
    super.initState();
  }

  @override
  void dispose() {
    authenticationResultStreamSubscription.cancel();
    super.dispose();
  }

  void _onAuthenticationResult(SplashScreenState state) {
    state.map(
      loading: (_) {
        //
      },
      notAuthenticated: (_) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.login.path,
          (_) => false,
        );
      },
      onBoarding: (_) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.welcomeTopics.path,
          (_) => false,
        );
      },
      home: (_) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.home.path,
          (_) => false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Assets.splashScreenBg.image(
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Assets.akropolisLogo.svg(
                    height: 80,
                    width: 80,
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
