import 'dart:async';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:akropolis/presentation/features/authentication/models/authentication_state.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationViewModel extends ChangeNotifier {
  final AuthenticationRepository _authenticationRepository;
  final StreamController<ToastMessage> _toastStreamController = StreamController.broadcast();
  final StreamController<AuthenticationState> _authenticationStateStreamController = StreamController.broadcast();
  AuthenticationState _state = const NotAuthenticatedState();

  AuthenticationViewModel({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository {
    _initializeViewModel();
  }

  Stream<ToastMessage> get toastStream => _toastStreamController.stream;

  Stream<AuthenticationState> get authenticationStateStream => _authenticationStateStreamController.stream;

  AuthenticationState get state => _state;

  Future<void> _initializeViewModel() async {
    try {
      Result<User> currentUserResult = await _authenticationRepository.getCurrentUser();
      switch(currentUserResult) {
        case Success<User>():
          _state = const AuthenticatedState();
        case Error<User>():
          _state = const NotAuthenticatedState();
      }
    } finally {
      notifyListeners();
    }
  }


  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (_state is LoadingAuthenticationState) return;


    //Sure state is not loading
    _state = const LoadingAuthenticationState();

    //UI is showing loading state
    notifyListeners();


    try {
      Result<User> createUserResult = await _authenticationRepository.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );

      switch (createUserResult) {
        case Success<User>():
          _state = const AuthenticatedState();
          _toastStreamController.add(
            ToastSuccess(message: "User created with email ${createUserResult.data.email}"),
          );
          break;

        case Error<User>():
          _state = const NotAuthenticatedState();
          _toastStreamController.add(
            ToastError(message: createUserResult.failure.message),
          );
          break;
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (_state is LoadingAuthenticationState) return;

    _state = const LoadingAuthenticationState();
    notifyListeners();

    try {
      Result<User> signInResult = await _authenticationRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      switch (signInResult) {
        case Success<User>():
          _state = const AuthenticatedState();
          _toastStreamController.add(
            ToastSuccess(message: "Signed in from ${signInResult.data.email}"),
          );
          break;

        case Error<User>():
          _state = const NotAuthenticatedState();
          _toastStreamController.add(
            ToastError(message: signInResult.failure.message),
          );
          break;
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> signInWithGoogle() async {
    if (_state is LoadingAuthenticationState) return;

    _state = const LoadingAuthenticationState();
    notifyListeners();

    try {
      Result<User> signInGoogleResult = await _authenticationRepository.signInWithGoogle();

      switch (signInGoogleResult) {
        case Success<User>():
          _state = const AuthenticatedState();
          _toastStreamController.add(
            ToastSuccess(message: "Signed in with google from ${signInGoogleResult.data.email}"),
          );
          break;

        case Error<User>():
          _state = const NotAuthenticatedState();
          _toastStreamController.add(
            ToastError(message: signInGoogleResult.failure.message),
          );
          break;
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    if (_state is LoadingAuthenticationState) return;

    _state = const LoadingAuthenticationState();
    notifyListeners();

    try {
      Result<void> resetPasswordResult = await _authenticationRepository.resetPassword(email: email);

      switch (resetPasswordResult) {
        case Success<void>():
          _toastStreamController.add(
            const ToastSuccess(message: "Check email for password reset link"),
          );
          break;

        case Error<void>():
          _toastStreamController.add(
            ToastError(message: resetPasswordResult.failure.message),
          );
          break;
      }
    } finally {
      _state = const NotAuthenticatedState();
      notifyListeners();
    }
  }
}
