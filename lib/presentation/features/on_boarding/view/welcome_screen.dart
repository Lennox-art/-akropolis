import 'dart:async';

import 'package:akropolis/presentation/features/on_boarding/models/on_boarding_models.dart';
import 'package:akropolis/presentation/features/on_boarding/view_model/on_boarding_view_model.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({
    required this.onBoardingViewModel,
    super.key,
  });

  final OnBoardingViewModel onBoardingViewModel;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late final StreamSubscription<ToastMessage> toastStreamSubscription;
  late final StreamSubscription<OnBoardingState> onBoardingStreamSubscription;

  @override
  void initState() {
    toastStreamSubscription = widget.onBoardingViewModel.toastStream.listen(_onToastMessage);
    onBoardingStreamSubscription = widget.onBoardingViewModel.onBoardingStateStream.listen(_onStateChange);
    super.initState();
  }

  void _onToastMessage(ToastMessage toast) {
    toast.show();
  }

  void _onStateChange(OnBoardingState state) {
    state.mapOrNull(
      topics: (_) => Navigator.of(context).pushNamed(AppRoutes.welcomeTopics.path),
      notifications: (_) => Navigator.of(context).pushNamed(AppRoutes.welcomePreferences.path),
      cleared: (_) => Navigator.of(context).pushNamed(AppRoutes.home.path),
    );
  }

  @override
  void dispose() {
    toastStreamSubscription.cancel();
    onBoardingStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: ListenableBuilder(
        listenable: widget.onBoardingViewModel,
        builder: (_, __) {

          if(widget.onBoardingViewModel.onBoardingState is LoadingOnBoardingState) {
            return const InfiniteLoader();
          }

          return Flex(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            direction: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Welcome to your new experience",
                  style: theme.textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                "Simplifies interaction by focusing on user-created videos rather than endless text threads",
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/connection_people.png"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.welcomeTopics.path,
                  );
                },
                child: const Text('Continue'),
              ),
            ],
          );
        }
      ),
    );
  }
}
