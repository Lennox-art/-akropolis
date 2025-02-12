import 'package:akropolis/utils/constants.dart';
import 'package:akropolis/gen/assets.gen.dart';
import 'package:akropolis/routes/routes.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Assets.background.provider(),
                // Add your image to the assets folder
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                direction: Axis.vertical,
                children: [
                  const SizedBox(height: 20,),

                  Assets.akropolisLogo.svg(
                    height: 150,
                  ),

                   const Expanded(
                    child: SizedBox.expand(),
                  ),

                  Text(
                    'Welcome to a new beginning',
                    style: theme.textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Akropolis connects people through video, fostering meaningful and vibrant social interactions.',
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(

                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.signIn.path);
                    },
                    child: const Text('Login'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.signUp.path);
                    },
                    child: const Text(
                      'Sign Up',
                    ),
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


