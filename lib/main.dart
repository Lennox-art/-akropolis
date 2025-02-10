import 'package:akropolis/features/authentication/view_model/authentication_cubit/authentication_cubit.dart';
import 'package:akropolis/features/create_post/view_model/create_post_cubit.dart';
import 'package:akropolis/features/news_feed/view_models/headlines_cubit/headlines_news_cubit.dart';
import 'package:akropolis/features/on_boarding/view_model/user_cubit/user_cubit.dart';
import 'package:akropolis/routes/routes.dart';
import 'package:akropolis/theme/themes.dart';
//import 'package:ffmpeg_helper/helpers/ffmpeg_helper_class.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging_service/logging_service.dart';
import 'package:network_service/network_service.dart';

import 'features/news_feed/view_models/for_you_news_cubit/for_you_news_cubit.dart';
import 'features/news_feed/view_models/world_news_cubit/world_news_cubit.dart';
import 'firebase_options.dart';

final GetIt getIt = GetIt.I;
final NetworkService ns = getIt<NetworkService>();
final LoggingService log = getIt<LoggingService>();
final ImagePicker picker = getIt<ImagePicker>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationCubit(),
        ),
        BlocProvider(
          create: (context) => UserCubit(),
        ),
        BlocProvider(
          create: (context) => WorldNewsCubit(),
        ),
        BlocProvider(
          create: (context) => ForYouNewsCubit(),
        ),
        BlocProvider(
          create: (context) => CreatePostCubit(),
        ),
        BlocProvider(
          create: (context) => HeadlinesNewsCubit(),
        ),
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
