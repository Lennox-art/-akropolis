import 'dart:async';
import 'dart:collection';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:akropolis/data/repositories/user_repository/user_repository.dart';
import 'package:akropolis/presentation/features/on_boarding/models/on_boarding_models.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class OnBoardingViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;
  final StreamController<ToastMessage> _toastStreamController = StreamController.broadcast();
  final StreamController<OnBoardingState> _onBoardingStateStreamController = StreamController.broadcast();
  OnBoardingState _state = const InitialOnBoardingState();
  final UnmodifiableListView<String> _topics = UnmodifiableListView(const [
    'Akropolis',
    'Programming',
    'Life',
    'Technology',
    'Relationship',
    'News',
    'Cryptocurrency',
    'Business',
    'Politics',
    'Startup',
    'Design',
    'Software Development',
    'Building',
    'Artificial Intelligence',
    'Art',
    'Blockchain',
    'Culture',
    'Farming',
    'Music',
    'Car',
    'Kenya',
    'DJ',
    'Mobile Phone',
    'Football',
    'Graph',
    'Productivity',
    'Health',
    'Psychology',
    'Writing',
    'Love',
    'Science',
  ]);
  AppUser? _user;

  OnBoardingViewModel({
    required UserRepository userRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _userRepository = userRepository,
        _authenticationRepository = authenticationRepository {
    _initializeViewModel();
  }

  UnmodifiableListView<String> get topics => _topics;

  Stream<ToastMessage> get toastStream => _toastStreamController.stream;

  Stream<OnBoardingState> get onBoardingStateStream => _onBoardingStateStreamController.stream;

  OnBoardingState get onBoardingState => _state;

  Future<void> _initializeViewModel() async {
    if (_state is! InitialOnBoardingState) return;

    _state = const LoadingOnBoardingState();
    notifyListeners();

    try {
      Result<User> currentUserState = await _authenticationRepository.getCurrentUser();
      switch (currentUserState) {
        case Success<User>():
          Result<AppUser?> currentAppUserState = await _userRepository.findUserById(
            id: currentUserState.data.uid,
          );

          switch (currentAppUserState) {
            case Success<AppUser?>():
              AppUser? currentUser = currentAppUserState.data;
              if (currentUser == null) {
                _state = const NotOnBoardedBoardingState();
                return;
              }

              _user = currentUser;

              if ((currentUser.topics ?? {}).isEmpty) {
                _state = const TopicsOnBoardingState();
                return;
              }

              //TODO: Notifications add
              _state = const ClearedOnBoardingState();

              break;
            case Error<AppUser?>():
              _state = const InitialOnBoardingState();
              _toastStreamController.add(
                ToastError(message: currentAppUserState.failure.message),
              );
              break;
          }

        case Error<User>():
          _state = const InitialOnBoardingState();
          _toastStreamController.add(
            ToastError(message: currentUserState.failure.message),
          );
          break;
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> setTopics({
    required Set<String> topics,
  }) async {
    if (_state is! LoadingOnBoardingState || _user == null) return;

    _state = const LoadingOnBoardingState();
    notifyListeners();

    try {
      _user!.topics = topics;
      Result<void> setTopicsResult = await _userRepository.saveAppUser(
        appUser: _user!,
      );

      switch (setTopicsResult) {
        case Success<void>():

          //TODO: Notifications
          _state = const ClearedOnBoardingState();
          _toastStreamController.add(
            ToastSuccess(message: "${topics.length} topics set"),
          );

          break;
        case Error<void>():
          _state = const TopicsOnBoardingState();
          _toastStreamController.add(
            ToastError(message: setTopicsResult.failure.message),
          );
          break;
      }

    } finally {
      notifyListeners();
    }
  }
}
