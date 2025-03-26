import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/models/thread_model.dart';
import 'package:akropolis/domain/use_cases/live_chat_use_case.dart';
import 'package:akropolis/domain/use_cases/post_reply_use_case.dart';
import 'package:akropolis/domain/use_cases/send_message_use_case.dart';
import 'package:akropolis/presentation/features/authentication/view/forgot_password.dart';
import 'package:akropolis/presentation/features/authentication/view/login.dart';
import 'package:akropolis/presentation/features/authentication/view/new_password.dart';
import 'package:akropolis/presentation/features/authentication/view/partial_sign_up.dart';
import 'package:akropolis/presentation/features/authentication/view/sign_in.dart';
import 'package:akropolis/presentation/features/authentication/view/sign_up.dart';
import 'package:akropolis/presentation/features/authentication/view_model/authentication_view_model.dart';
import 'package:akropolis/presentation/features/chat/model/chat_models.dart';
import 'package:akropolis/presentation/features/chat/view/chat_screen.dart';
import 'package:akropolis/presentation/features/chat/view_model/chat_view_model.dart';
import 'package:akropolis/presentation/features/create_post/views/create_post_page.dart';
import 'package:akropolis/presentation/features/home/view/home_page.dart';
import 'package:akropolis/presentation/features/home/view_model/home_view_model.dart';
import 'package:akropolis/presentation/features/new_thread/view/new_thread_screen.dart';
import 'package:akropolis/presentation/features/new_video_message/model/new_video_message_model.dart';
import 'package:akropolis/presentation/features/new_video_message/view/new_video_message.dart';
import 'package:akropolis/presentation/features/new_thread/view_model/new_thread_view_model.dart';
import 'package:akropolis/presentation/features/new_video_message/view_model/new_video_message_view_model.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:akropolis/presentation/features/news_feed/view/news_detailed_view.dart';
import 'package:akropolis/presentation/features/news_feed/view/post_comment_detailed_view.dart';
import 'package:akropolis/presentation/features/news_feed/view/post_reply_screen.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/news_detail_post_view_model.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/post_comment_detail_post_view_model.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/reply_post_view_model.dart';
import 'package:akropolis/presentation/features/on_boarding/view/select_default_preferences.dart';
import 'package:akropolis/presentation/features/on_boarding/view/select_topic.dart';
import 'package:akropolis/presentation/features/on_boarding/view/welcome_screen.dart';
import 'package:akropolis/presentation/features/on_boarding/view_model/on_boarding_view_model.dart';
import 'package:akropolis/presentation/features/profile/view/edit_profile_screen.dart';
import 'package:akropolis/presentation/features/profile/view_model/edit_profile_view_model.dart';
import 'package:akropolis/presentation/features/splash_screen/view/splash_screen.dart';
import 'package:akropolis/presentation/features/splash_screen/view_model/splash_screen_view_model.dart';
import 'package:akropolis/presentation/features/topics/view/topics_screen.dart';
import 'package:akropolis/presentation/features/topics/view_model/topics_view_model.dart';
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
  newsDetailsPage("/newsDetailsPage"),
  postReplyScreen("/postReplyScreen"),
  newsCommentDetailsPage("/newsCommentDetailsPage"),
  editProfile("/editProfile"),
  editTopics("/editTopics"),
  newThreadScreen("/newThreadScreen"),
  newVideoMessage("/newVideoMessage"),
  chat("/chat");

  final String path;

  const AppRoutes(this.path);

  Widget page(BuildContext context) => switch (this) {
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
              topicRepository: GetIt.I(),
              userRepository: GetIt.I(),
              authenticationRepository: GetIt.I(),
            ),
          ),
        AppRoutes.welcomeTopics => SelectTopicScreen(
            onBoardingViewModel: OnBoardingViewModel(
              topicRepository: GetIt.I(),
              userRepository: GetIt.I(),
              authenticationRepository: GetIt.I(),
            ),
          ),
        AppRoutes.welcomePreferences => const SelectDefaultPreferencesScreen(),
        AppRoutes.home => HomePage(
            createPostViewModel: GetIt.I(),
            homeViewModel: HomeViewModel(
              authenticationRepository: GetIt.I(),
              userRepository: GetIt.I(),
            ),
          ),
        AppRoutes.createPost => CreatePostPage(
            createPostViewModel: GetIt.I(),
          ),
        AppRoutes.newsDetailsPage => NewsDetailedViewPage(
            newsDetailPostViewModel: NewsDetailPostViewModel(
              newsCardUseCase: GetIt.I(),
              newsPostDto: ModalRoute.of(context)!.settings.arguments as NewsPostDto,
              postRepository: GetIt.I(),
              getMediaUseCase: GetIt.I(),
              fetchPostCommentsUseCase: GetIt.I(),
            ),
          ),
        AppRoutes.postReplyScreen => PostReplyScreenPage(
            replyPostViewModel: ReplyPostViewModel(
              newsPostReplyDto: ModalRoute.of(context)!.settings.arguments as NewsPostReplyDto,
              postReplyUseCase: PostReplyUseCase(
                userRepository: GetIt.I(),
                authenticationRepository: GetIt.I(),
                postRepository: GetIt.I(),
                localDataStorageService: GetIt.I(),
                remoteFileStorageService: GetIt.I(),
                localFileStorageService: GetIt.I(),
              ),
            ),
          ),
        AppRoutes.newsCommentDetailsPage => PostCommentDetailViewPage(
            postCommentDetailViewModel: PostCommentDetailViewModel(
              newsPostCommentDto: ModalRoute.of(context)!.settings.arguments as NewsPostCommentDto,
              postRepository: GetIt.I(),
              getMediaUseCase: GetIt.I(),
              fetchPostCommentsUseCase: GetIt.I(),
            ),
          ),
        AppRoutes.editProfile => EditProfileScreen(
            editProfileViewModel: EditProfileViewModel(
              currentUser: ModalRoute.of(context)!.settings.arguments as AppUser,
              userRepository: GetIt.I(),
              remoteFileStorageService: GetIt.I(),
            ),
          ),
        AppRoutes.editTopics => EditTopicsScreen(
            topicsViewModel: TopicsViewModel(
              userRepository: GetIt.I(),
              authenticationRepository: GetIt.I(),
              topicRepository: GetIt.I(),
            ),
          ),
        AppRoutes.newThreadScreen => NewThreadScreen(
            newThreadViewModel: NewThreadViewModel(
              userRepository: GetIt.I(),
            ),
          ),
        AppRoutes.newVideoMessage => NewVideoMessageScreen(
            newVideoMessageViewModel: NewVideoMessageViewModel(
              sendMessageUseCase: SendMessageUseCase(
                messageRepository: GetIt.I(),
                authenticationRepository: GetIt.I(),
                remoteFileStorageService: GetIt.I(),
                localFileStorageService: GetIt.I(),
                localDataStorageService: GetIt.I(),
              ),
              newVideoMessageData: ModalRoute.of(context)!.settings.arguments as NewVideoMessageData,
            ),
          ),
        AppRoutes.chat => ChatScreen(
            chatViewModel: ChatViewModel(
              chatDto: ModalRoute.of(context)!.settings.arguments as ChatDto,
              messageRepository: GetIt.I(),
              sendMessageUseCase: SendMessageUseCase(
                messageRepository: GetIt.I(),
                authenticationRepository: GetIt.I(),
                remoteFileStorageService: GetIt.I(),
                localFileStorageService: GetIt.I(),
                localDataStorageService: GetIt.I(),
              ),
              liveChatUseCase: LiveChatUseCase(
                thread: (ModalRoute.of(context)!.settings.arguments as ChatDto).thread,
                messageRepository: GetIt.I(),
                loggingService: GetIt.I(),
              ),
            ),
          ),
      };
}

//NewsPostDto newsPostDto = ModalRoute.of(context)!.settings.arguments as NewsPostDto
