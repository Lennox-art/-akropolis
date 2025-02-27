import 'package:akropolis/domain/use_cases/create_user_post_use_case.dart';
import 'package:akropolis/presentation/features/authentication/view/forgot_password.dart';
import 'package:akropolis/presentation/features/authentication/view/login.dart';
import 'package:akropolis/presentation/features/authentication/view/new_password.dart';
import 'package:akropolis/presentation/features/authentication/view/partial_sign_up.dart';
import 'package:akropolis/presentation/features/authentication/view/sign_in.dart';
import 'package:akropolis/presentation/features/authentication/view/sign_up.dart';
import 'package:akropolis/presentation/features/authentication/view_model/authentication_view_model.dart';
import 'package:akropolis/presentation/features/create_post/view_model/create_post_view_model.dart';
import 'package:akropolis/presentation/features/create_post/views/create_post_page.dart';
import 'package:akropolis/presentation/features/create_post/views/edit_video_post_page.dart';
import 'package:akropolis/presentation/features/create_post/views/post_meta_data_page.dart';
import 'package:akropolis/presentation/features/home/view/home_page.dart';
import 'package:akropolis/presentation/features/home/view_model/home_view_model.dart';
import 'package:akropolis/presentation/features/news_feed/view/news_detailed_view.dart';
import 'package:akropolis/presentation/features/news_feed/view/post_reply_screen.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/news_detail_post_view_model.dart';
import 'package:akropolis/presentation/features/on_boarding/view/select_default_preferences.dart';
import 'package:akropolis/presentation/features/on_boarding/view/select_topic.dart';
import 'package:akropolis/presentation/features/on_boarding/view/welcome_screen.dart';
import 'package:akropolis/presentation/features/on_boarding/view_model/on_boarding_view_model.dart';
import 'package:akropolis/presentation/features/splash_screen/view/splash_screen.dart';
import 'package:akropolis/presentation/features/splash_screen/view_model/splash_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

enum AppRoutes {
  splashScreen("/"),
  login("/login"),
  signIn("/signIn"),
  signInWithEmail("/signInEmail"),
  signUp("/signUp"),
  signUpWithEmail("/signUpWithEmail"),
  partialSignUp("/partialSignUp"),
  forgotPassword("/forgotPassword"),
  newPassword("/newPassword"),
  welcome("/welcome"),
  welcomeTopics("/welcomeTopics"),
  welcomePreferences("/welcomePreferences"),
  home("/home"),
  createPost("/createPostPage"),
  videoEditingPage("/videoEditingPage"),
  finalizePost("/finalizePost"),
  newsDetailsPage("/newsDetailsPage"),
  postReplyScreen("/postReplyScreen");

  final String path;

  const AppRoutes(this.path);

  Widget get page => switch (this) {
        AppRoutes.splashScreen => SplashScreen(
            splashScreenViewModel: SplashScreenViewModel(
              userRepository: GetIt.I(),
              authenticationRepository: GetIt.I(),
            ),
          ),
        AppRoutes.login => const LoginScreen(),
        AppRoutes.signIn => SignInScreen(
            authenticationViewModel: AuthenticationViewModel(
              authenticationRepository: GetIt.I(),
              userRepository: GetIt.I(),
            ),
          ),
        AppRoutes.signInWithEmail => SignInWithEmailScreen(
            authenticationViewModel: AuthenticationViewModel(
              authenticationRepository: GetIt.I(),
              userRepository: GetIt.I(),
            ),
          ),
        AppRoutes.signUp => SignUpPage(
            authenticationViewModel: AuthenticationViewModel(
              authenticationRepository: GetIt.I(),
              userRepository: GetIt.I(),
            ),
          ),
        AppRoutes.signUpWithEmail => SignUpWithEmailScreen(
            authenticationViewModel: AuthenticationViewModel(
              authenticationRepository: GetIt.I(),
              userRepository: GetIt.I(),
            ),
          ),
        AppRoutes.partialSignUp => PartialSignUpScreen(
            authenticationViewModel: AuthenticationViewModel(
              authenticationRepository: GetIt.I(),
              userRepository: GetIt.I(),
            ),
          ),
        AppRoutes.forgotPassword => ForgotPasswordScreen(
            authenticationViewModel: AuthenticationViewModel(
              authenticationRepository: GetIt.I(),
              userRepository: GetIt.I(),
            ),
          ),
        AppRoutes.newPassword => const NewPasswordScreen(),
        AppRoutes.welcome => WelcomeScreen(
            onBoardingViewModel: OnBoardingViewModel(
              userRepository: GetIt.I(),
              authenticationRepository: GetIt.I(),
            ),
          ),
        AppRoutes.welcomeTopics => SelectTopicScreen(
            onBoardingViewModel: OnBoardingViewModel(
              userRepository: GetIt.I(),
              authenticationRepository: GetIt.I(),
            ),
          ),
        AppRoutes.welcomePreferences => const SelectDefaultPreferencesScreen(),
        AppRoutes.home => HomePage(
            homeViewModel: HomeViewModel(
              authenticationRepository: GetIt.I(),
              userRepository: GetIt.I(),
            ),
          ),
        AppRoutes.createPost => CreatePostPage(
            //TODO: Create GetIt.I() services
            createPostViewModel: CreatePostViewModel(
              createPostUseCase: CreatePostUseCase(
                userRepository: GetIt.I(),
                authenticationRepository: GetIt.I(),
                postRepository: GetIt.I(),
                localDataStorageService: GetIt.I(),
                remoteFileStorageService: GetIt.I(),
                localFileStorageService: GetIt.I(),
              ),
            ),
          ),
        AppRoutes.videoEditingPage => EditVideoPostPage(
            createPostViewModel: CreatePostViewModel(
              createPostUseCase: CreatePostUseCase(
                userRepository: GetIt.I(),
                authenticationRepository: GetIt.I(),
                postRepository: GetIt.I(),
                localDataStorageService: GetIt.I(),
                remoteFileStorageService: GetIt.I(),
                localFileStorageService: GetIt.I(),
              ),
            ),
          ),
        AppRoutes.finalizePost => PostMetaDataPage(
            createPostViewModel: CreatePostViewModel(
              createPostUseCase: CreatePostUseCase(
                userRepository: GetIt.I(),
                authenticationRepository: GetIt.I(),
                postRepository: GetIt.I(),
                localDataStorageService: GetIt.I(),
                remoteFileStorageService: GetIt.I(),
                localFileStorageService: GetIt.I(),
              ),
            ),
          ),
        AppRoutes.newsDetailsPage => const NewsDetailedViewPage(),
        AppRoutes.postReplyScreen => const PostReplyScreenPage(),
      };
}
