import 'dart:async';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SplashScreenViewModel extends ChangeNotifier {
  final AuthenticationRepository _authenticationRepository;
  final StreamController<bool> _authenticatedResultStreamController = StreamController.broadcast();

  SplashScreenViewModel({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

  Stream<bool> get authenticatedResultStream => _authenticatedResultStreamController.stream;

  Future<void> checkAuthenticationResult() async {
    Result<User> currentUserResult = await _authenticationRepository.getCurrentUser();
    switch (currentUserResult) {
      case Success<User>():
        _authenticatedResultStreamController.add(true);
      case Error<User>():
        _authenticatedResultStreamController.add(false);
    }
  }
}
