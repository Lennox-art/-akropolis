import 'dart:async';
import 'dart:collection';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:akropolis/data/repositories/topics_repository/topics_repository.dart';
import 'package:akropolis/data/repositories/user_repository/user_repository.dart';
import 'package:akropolis/presentation/features/on_boarding/models/on_boarding_models.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class OnBoardingViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;
  final TopicRepository _topicRepository;
  final LinkedHashSet<Topic> _topics = LinkedHashSet(equals: (t1, t2) => t1.name == t2.name);

  final StreamController<ToastMessage> _toastStreamController = StreamController.broadcast();
  final StreamController<OnBoardingState> _onBoardingStateStreamController = StreamController.broadcast();
  OnBoardingState _state = const NotOnBoardedBoardingState();
  AppUser? _user;

  OnBoardingViewModel({
    required UserRepository userRepository,
    required AuthenticationRepository authenticationRepository,
    required TopicRepository topicRepository,
  })  : _userRepository = userRepository,
        _topicRepository = topicRepository,
        _authenticationRepository = authenticationRepository {
    _initializeViewModel();
    _getTopics();
  }

  UnmodifiableListView<Topic> get topics => UnmodifiableListView(_topics);

  Stream<ToastMessage> get toastStream => _toastStreamController.stream;

  Stream<OnBoardingState> get onBoardingStateStream => _onBoardingStateStreamController.stream;

  OnBoardingState get onBoardingState => _state;

  Future<void> _initializeViewModel() async {
    if (_state is! NotOnBoardedBoardingState) return;

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
              //Not to be here without an account
              //Fatal error
              _state = const NotOnBoardedBoardingState();

              _toastStreamController.add(
                ToastError(message: currentAppUserState.failure.message),
              );
              break;
          }

        case Error<User>():
          _state = const NotOnBoardedBoardingState();
          _toastStreamController.add(
            ToastError(message: currentUserState.failure.message),
          );
          break;
      }
    } finally {
      _onBoardingStateStreamController.add(_state);
      notifyListeners();
    }
  }

  Future<void> _getTopics() async {
    Result<List<Topic>> topicResult = await _topicRepository.getTopics();
    switch(topicResult) {

      case Success<List<Topic>>():
        _topics.addAll(topicResult.data);
        notifyListeners();
        return;
      case Error<List<Topic>>():
        return;
    }
  }


  Future<void> setTopics({
    required Set<String> topics,
  }) async {
    if (_state is LoadingOnBoardingState || _user == null) return;

    _state = const LoadingOnBoardingState();
    notifyListeners();

    try {
      _user?.topics = topics;

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
      _onBoardingStateStreamController.add(_state);
      notifyListeners();
    }
  }
}
