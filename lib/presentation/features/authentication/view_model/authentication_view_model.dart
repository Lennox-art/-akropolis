import 'dart:async';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:akropolis/data/repositories/user_repository/user_repository.dart';
import 'package:akropolis/presentation/features/authentication/models/authentication_state.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationViewModel extends ChangeNotifier {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  final StreamController<ToastMessage> _toastStreamController = StreamController.broadcast();
  final StreamController<AuthenticationState> _authenticationStateStreamController = StreamController.broadcast();
  AuthenticationState _state = const NotAuthenticatedState();

  AuthenticationViewModel({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository {
    _initializeViewModel();
  }

  Stream<ToastMessage> get toastStream => _toastStreamController.stream;

  Stream<AuthenticationState> get authenticationStateStream => _authenticationStateStreamController.stream;

  AuthenticationState get state => _state;

  Future<void> _initializeViewModel() async {
    try {
      Result<User> currentUserResult = await _authenticationRepository.getCurrentUser();
      switch (currentUserResult) {
        case Success<User>():
          Result<AppUser?> currentAppUserResult = await _userRepository.findUserById(id: currentUserResult.data.uid);
          switch (currentAppUserResult) {
            case Success<AppUser?>():
              AppUser? currentUser = currentAppUserResult.data;
              if (currentUser == null) {
                _state = PartialSigningUpState(user: currentUserResult.data);
                _toastStreamController.add(const ToastInfo(message: "Account created but missing some data. Please sign up"));
                return;
              }

              bool requiresOnboarding = (currentUser.topics ?? {}).isEmpty;
              _state = AuthenticatedState(requiresOnboarding: requiresOnboarding);
              _toastStreamController.add(ToastSuccess(message: "Welcome ${currentUser.username}"));
              break;
            case Error<AppUser?>():
              _state = const NotAuthenticatedState();
              break;
          }
          break;
        case Error<User>():
          _state = const NotAuthenticatedState();
          break;
      }
    } finally {
      _authenticationStateStreamController.add(_state);
      notifyListeners();
    }
  }

  Future<void> _onSignIn(User user) async {
    Result<AppUser?> currentAppUserResult = await _userRepository.findUserById(id: user.uid);
    switch (currentAppUserResult) {
      case Success<AppUser?>():
        AppUser? currentUser = currentAppUserResult.data;
        if (currentUser == null) {
          _state = PartialSigningUpState(user: user);
          _toastStreamController.add(const ToastInfo(message: "Account created but missing some data. Please sign up"));
          return;
        }

        bool requiresOnboarding = (currentUser.topics ?? {}).isEmpty;
        _state = AuthenticatedState(requiresOnboarding: requiresOnboarding);
        _toastStreamController.add(ToastSuccess(message: "Welcome ${currentUser.username}"));
        break;
      case Error<AppUser?>():
        _state = const NotAuthenticatedState();
        break;
    }
  }

  Future<Result<AppUser>> _onSignUp({
    required User user,
    required String email,
    required String displayName,
    required String username,
    String? profilePictureUrl,
  }) async {
    AppUser newUser = AppUser(
      id: user.uid,
      displayName: displayName,
      username: username,
      email: email,
      profilePicture: profilePictureUrl,
      topics: {},
    );
    return await _userRepository.saveAppUser(
      appUser: newUser,
    );
  }

  Future<void> signUp({
    required String email,
    required String username,
    required String password,
    required String displayName,
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
          Result<AppUser> onSignUpResult = await _onSignUp(
            user: createUserResult.data,
            email: email,
            displayName: displayName,
            username: username,
          );

          switch (onSignUpResult) {
            case Success<AppUser>():
              _state = const AuthenticatedState(requiresOnboarding: true);
              _toastStreamController.add(
                ToastSuccess(message: "User created with email $email"),
              );
              break;
            case Error<AppUser>():
              _state = PartialSigningUpState(user: createUserResult.data);
              break;
          }

          break;

        case Error<User>():
          _state = const NotAuthenticatedState();
          _toastStreamController.add(
            ToastError(message: createUserResult.failure.message),
          );
          break;
      }
    } finally {
      _authenticationStateStreamController.add(_state);
      notifyListeners();
    }
  }

  Future<void> completeSignUp({
    required User user,
    required String username,
    required String displayName,
  }) async {
    if (_state is LoadingAuthenticationState) return;

    _state = const LoadingAuthenticationState();
    notifyListeners();

    try {
      Result<AppUser> onSignUpResult = await _onSignUp(
        user: user,
        email: user.email!,
        displayName: displayName,
        username: username,
      );

      switch (onSignUpResult) {
        case Success<AppUser>():
          _state = const AuthenticatedState(requiresOnboarding: true);
          _toastStreamController.add(
            ToastSuccess(message: "User created with email ${user.email}"),
          );
          break;
        case Error<AppUser>():
          _state = PartialSigningUpState(user: user);
          break;
      }
    } finally {
      _authenticationStateStreamController.add(_state);
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
          Result<AppUser?> currentAppUserResult = await _userRepository.findUserById(id: signInResult.data.uid);
          switch (currentAppUserResult) {
            case Success<AppUser?>():
              AppUser? currentUser = currentAppUserResult.data;
              if (currentUser == null) {
                _state = PartialSigningUpState(user: signInResult.data);
                _toastStreamController.add(const ToastInfo(message: "Account created but missing some data. Please sign up"));
                return;
              }

              bool requiresOnboarding = (currentUser.topics ?? {}).isEmpty;
              _state = AuthenticatedState(requiresOnboarding: requiresOnboarding);
              _toastStreamController.add(ToastSuccess(message: "Welcome ${currentUser.username}"));
              break;
            case Error<AppUser?>():
              _state = const NotAuthenticatedState();
              break;
          }
          break;

        case Error<User>():
          _state = const NotAuthenticatedState();
          _toastStreamController.add(
            ToastError(message: signInResult.failure.message),
          );
          break;
      }
    } finally {
      _authenticationStateStreamController.add(_state);
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
          User signedInUser = signInGoogleResult.data;

          Result<AppUser?> currentAppUserResult = await _userRepository.findUserById(id: signInGoogleResult.data.uid);
          switch (currentAppUserResult) {
            case Success<AppUser?>():
              AppUser? currentUser = currentAppUserResult.data;
              if (currentUser == null) {
                Result<AppUser> onSignUpResult = await _onSignUp(
                  user: signedInUser,
                  email: signedInUser.email!,
                  displayName: signedInUser.displayName!,
                  profilePictureUrl: signedInUser.photoURL,
                  username: signedInUser.displayName!,
                );

                switch (onSignUpResult) {
                  case Success<AppUser>():
                    _state = const AuthenticatedState(requiresOnboarding: true);
                    _toastStreamController.add(
                      ToastSuccess(message: "User created with email ${signedInUser.email}"),
                    );
                    break;
                  case Error<AppUser>():
                    _state = PartialSigningUpState(user: signedInUser);
                    break;
                }

                return;
              }

              _toastStreamController.add(
                ToastSuccess(message: "Signed in with google from ${currentUser.email}"),
              );
              bool requiresOnBoarding = (currentAppUserResult.data?.topics ?? {}).isNotEmpty;
              _state = AuthenticatedState(requiresOnboarding: requiresOnBoarding);

              break;
            case Error<AppUser?>():
              _state = NotAuthenticatedState();
              break;
          }
          break;

        case Error<User>():
          _state = NotAuthenticatedState();
          _toastStreamController.add(
            ToastError(message: signInGoogleResult.failure.message),
          );
          break;
      }
    } finally {
      _authenticationStateStreamController.add(_state);
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
