import 'package:akropolis/constants/constants.dart';
import 'package:akropolis/routes/routes.dart';
import 'package:akropolis/state/authentication/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthenticationCubit>(context).logout();
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.login.path,
                (_) => false,
              );
            },
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.red,
            ),
          ),
        ],
      ),

    );
  }
}
