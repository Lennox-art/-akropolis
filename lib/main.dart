import 'dart:io';
import 'dart:ui';

import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging_service/logging_service.dart';
import 'package:network_service/network_service.dart';
import 'package:path_provider/path_provider.dart';
import 'firebase_options.dart';

final GetIt getIt = GetIt.I;
final NetworkService ns = getIt<NetworkService>();
final LoggingService log = getIt<LoggingService>();
final ImagePicker picker = getIt<ImagePicker>();
late final Directory temporaryDirectory;
final String? deviceCountry = PlatformDispatcher.instance.locale.countryCode;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory docDir = await getApplicationDocumentsDirectory();
  temporaryDirectory = await getTemporaryDirectory();

  //await FFMpegHelper.instance.initialize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  LoggingService log = LoggingServiceImpl(
    level: Level.all,
    debugStyle: const PrintStyle(
      color: CliColor.magenta,
    ),
  );
  getIt.registerSingleton(log);

  NetworkService ns = NetworkServiceImpl(log);
  getIt.registerSingleton(ns);

  final ImagePicker picker = ImagePicker();
  getIt.registerSingleton(picker);


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
