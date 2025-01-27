import 'package:akropolis/routes/routes.dart';
import 'package:akropolis/state/authentication/authentication_cubit.dart';
import 'package:akropolis/state/user_cubit/user_cubit.dart';
import 'package:akropolis/theme/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const AkropolisApplication());
}

class AkropolisApplication extends StatelessWidget {
  const AkropolisApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationCubit(),
        ),
        BlocProvider(
          create: (context) => UserCubit(),
        )
      ],
      child: MaterialApp(
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splashScreen.path,
        routes: {
          for (var r in AppRoutes.values) r.path: (_) => r.page,
        },
      ),
    );
  }
}