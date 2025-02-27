import 'dart:async';

import 'package:akropolis/data/utils/validations.dart';
import 'package:akropolis/presentation/features/authentication/models/authentication_state.dart';
import 'package:akropolis/presentation/features/authentication/view_model/authentication_view_model.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/material.dart';

class PartialSignUpScreen extends StatefulWidget {
  const PartialSignUpScreen({required this.authenticationViewModel, super.key});

  final AuthenticationViewModel authenticationViewModel;

  @override
  State<PartialSignUpScreen> createState() => _PartialSignUpScreenState();
}

class _PartialSignUpScreenState extends State<PartialSignUpScreen> {
  late final StreamSubscription<ToastMessage> toastStreamSubscription;
  late final StreamSubscription<AuthenticationState> authStateStreamSubscription;

  @override
  void initState() {
    toastStreamSubscription = widget.authenticationViewModel.toastStream.listen(_onToastMessage);
    authStateStreamSubscription = widget.authenticationViewModel.authenticationStateStream.listen(_onStateChange);
    super.initState();
  }

  @override
  void dispose() {
    toastStreamSubscription.cancel();
    authStateStreamSubscription.cancel();
    super.dispose();
  }

  void _onToastMessage(ToastMessage toast) {
    toast.show();
  }

  void _onStateChange(AuthenticationState state) {
    state.mapOrNull(
      authenticated: (a) {
        AppRoutes nextRoute = a.requiresOnboarding ? AppRoutes.welcome : AppRoutes.home;
        Navigator.of(context).pushNamed(nextRoute.path);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextEditingController displayNameController = TextEditingController();
    TextEditingController usernameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: ListenableBuilder(
        listenable: widget.authenticationViewModel,
        builder: (_, __) {
          return widget.authenticationViewModel.state.mapOrNull(
                loading: (_) => const InfiniteLoader(),
                partialSignUp: (u) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Complete sign up",
                        style: theme.textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "We're missing some details to complete your registration",
                        style: theme.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      ListTile(
                        title: const Text("Display Name"),
                        subtitle: TextFormField(
                          validator: validateDisplayName,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: displayNameController,
                          decoration: const InputDecoration(hintText: "John Doe"),
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
                      ElevatedButton(
                        onPressed: () {
                          String username = usernameController.text;
                          String displayName = displayNameController.text;
                          widget.authenticationViewModel.completeSignUp(user: u.user, username: username, displayName: displayName);
                        },
                        child: const Text("Complete sign up"),
                      ),
                    ],
                  );
                },
              ) ??
              const SizedBox.shrink();
        },
      ),
    );
  }
}