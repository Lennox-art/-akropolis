import 'package:akropolis/routes/routes.dart';
import 'package:akropolis/theme/themes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AkropolisApplication());
}

class AkropolisApplication extends StatelessWidget {
  const AkropolisApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashScreen.path,
      routes: {
        for (var r in AppRoutes.values) r.path: (_) => r.page,
      },
    );
  }
}
