import 'dart:async';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:akropolis/data/repositories/user_repository/user_repository.dart';
import 'package:akropolis/presentation/features/splash_screen/models/splash_models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SplashScreenViewModel extends ChangeNotifier {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  final StreamController<SplashScreenState> _splashScreenStateController = StreamController.broadcast();
  SplashScreenState _splashScreenState = const LoadingSplashScreenState();


  SplashScreenViewModel({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  }) : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository {
    _checkAuthenticationResult();
  }

  Stream<SplashScreenState> get splashScreenStateResult => _splashScreenStateController.stream;
  SplashScreenState get splashScreenState => _splashScreenState;

  Future<void> _checkAuthenticationResult() async {
    try {
      Result<User> currentUserResult = await _authenticationRepository.getCurrentUser();
      switch (currentUserResult) {
        case Success<User>():

          Result<AppUser?> currentAppUserResult = await _userRepository.findUserById(
            id: currentUserResult.data.uid,
          );

          switch(currentAppUserResult) {

            case Success<AppUser?>():
              AppUser? currentUser = currentAppUserResult.data;
              if(currentUser == null) {
                _splashScreenState = const NotAuthenticatedSplashScreenState();
                return;
              }

              bool hasTopics = (currentUser.topics ?? {}).isNotEmpty;
              if(!hasTopics) {
                _splashScreenState = const OnBoardingSplashScreenState();
                return;
              }

              _splashScreenState = const HomeSplashScreenState();

              break;
            case Error<AppUser?>():
              _splashScreenState = const NotAuthenticatedSplashScreenState();
              break;
          }

        case Error<User>():
          _splashScreenState = const NotAuthenticatedSplashScreenState();
          break;
      }
    } finally {
      _splashScreenStateController.add(_splashScreenState);
      notifyListeners();
    }
  }
}
