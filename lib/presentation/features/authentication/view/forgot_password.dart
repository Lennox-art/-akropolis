import 'dart:async';

import 'package:akropolis/presentation/features/authentication/models/authentication_state.dart';
import 'package:akropolis/presentation/features/authentication/view_model/authentication_view_model.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({
    required this.authenticationViewModel,
    super.key,
  });

  final AuthenticationViewModel authenticationViewModel;

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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

  void _onStateChange(AuthenticationState state) {}

  @override
  void dispose() {
    toastStreamSubscription.cancel();
    authStateStreamSubscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Forgot Password",
            style: theme.textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          Text(
            "Enter the email associated with your account and we will send an email with instructions to reset your password",
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          ListTile(
            title: const Text("Email"),
            subtitle: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "johndoe@example.abc",
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
                      String email = emailController.text;
                      widget.authenticationViewModel.resetPassword(
                        email: email,
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
                    child: const Text("Reset password"),
                  );
                },
                authenticated: (_) => const Text("Password has been reset"),
              );
            },
          ),
        ],
      ),
    );
  }
}
