import 'package:flutter/material.dart';

import 'login.dart';

void main() {
  runApp(const AkropolisApplication());


}

class AkropolisApplication extends StatelessWidget {
  const AkropolisApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
      },
    );
  }
}
