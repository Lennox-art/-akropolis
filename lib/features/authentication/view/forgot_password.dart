import 'package:akropolis/components/loader.dart';
import 'package:akropolis/components/toast/toast.dart';
import 'package:akropolis/features/authentication/view_model/authentication_cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
                loaded: (_) => ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthenticationCubit>(context).resetPassword(
                      email: emailController.text,
                    );
                  },
                  child: const Text("Reset Password"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
