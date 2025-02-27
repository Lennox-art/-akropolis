import 'dart:io';
import 'dart:ui';

import 'package:akropolis/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:akropolis/data/repositories/post_repository/post_repository.dart';
import 'package:akropolis/data/repositories/user_repository/user_repository.dart';
import 'package:akropolis/data/services/data_storage_service/local_data_storage_service.dart';
import 'package:akropolis/data/services/data_storage_service/remote_data_storage_service.dart';
import 'package:akropolis/data/services/file_storage_service/local_file_storage_service.dart';
import 'package:akropolis/data/services/file_storage_service/remote_file_storage_service.dart';
import 'package:akropolis/domain/repository_impl/authentication_repository_impl/authentication_repository_impl.dart';
import 'package:akropolis/domain/repository_impl/post_respository_impl/post_repository_impl.dart';
import 'package:akropolis/domain/repository_impl/user_repository_impl/user_repository_impl.dart';
import 'package:akropolis/domain/service_impl/data_storage_service_impl/remote_data_storage_service_impl/firestore_remote_storage_service.dart';
import 'package:akropolis/domain/service_impl/file_storage_service_impl/local_file_storage_service_impl/local_file_system_local_storage_service_impl.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging_service/logging_service.dart';
import 'package:network_service/network_service.dart';
import 'package:path_provider/path_provider.dart';
import 'data/utils/crypto_functions.dart';
import 'domain/service_impl/data_storage_service_impl/local_data_storage_service_impl/local_data_storage_service_impl.dart';
import 'domain/service_impl/file_storage_service_impl/remote_file_storage_service_impl/firebase_cloud_storage_remote_storage_service_impl.dart';
import 'firebase_options.dart';
import 'package:path/path.dart' as path;

final GetIt getIt = GetIt.I;
final NetworkService ns = getIt<NetworkService>();
final LoggingService log = getIt<LoggingService>();
final ImagePicker picker = getIt<ImagePicker>();
late final Directory temporaryDirectory;
final String? deviceCountry = PlatformDispatcher.instance.locale.countryCode;

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

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

  ///Services
  RemoteDataStorageService remoteDataStorageService = FirestoreRemoteStorageService(log: log);
  getIt.registerSingleton(remoteDataStorageService);

  LocalDataStorageService localDataStorageService = HiveLocalStorageService(
    hiveCypher: await getHiveAesCipher("hive_key"),
    path: docDir.path,
    log: log,
  );
  getIt.registerSingleton(localDataStorageService);

  LocalFileStorageService localFileStorageService = LocalFileSystemLocalStorageServiceImpl(
    filePath: path.join(docDir.path, 'files'),
    loggingService: log,
  );
  getIt.registerSingleton(localFileStorageService);

  RemoteFileStorageService remoteFileStorageService = FirebaseCloudStorageRemoteStorageServiceImpl(
    log: log,
  );
  getIt.registerSingleton(remoteFileStorageService);

  ///Repositories
  AuthenticationRepository authenticationRepository = AuthenticationRepositoryImpl();
  getIt.registerSingleton(authenticationRepository);

  UserRepository userRepository = UserRepositoryImpl(
    remoteDataStorageService: remoteDataStorageService,
  );
  getIt.registerSingleton(userRepository);

  PostRepository postRepository = PostRepositoryImpl(
    remoteDataStorageService: remoteDataStorageService,
  );
  getIt.registerSingleton(postRepository);

  runApp(const AkropolisApplication());
  FlutterNativeSplash.remove();
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
