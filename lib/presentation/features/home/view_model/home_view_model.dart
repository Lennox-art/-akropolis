import 'dart:async';
import 'dart:collection';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:akropolis/data/repositories/user_repository/user_repository.dart';
import 'package:akropolis/domain/use_cases/fetch_post_comments_use_case.dart';
import 'package:akropolis/presentation/features/home/models/home_models.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:exception_base/exception_base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class HomeViewModel extends ChangeNotifier {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  final StreamController<ToastMessage> _toastStreamController = StreamController.broadcast();
  final StreamController<HomeState> _onHomeStateStreamController = StreamController.broadcast();

  final List<BottomNavigationTabs> _bottomTabs = BottomNavigationTabs.values;
  BottomNavigationTabs _currentTab = BottomNavigationTabs.search;

  HomeState _homeState = const InitialHomeState();


  HomeViewModel({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository {
    _initializeHomeViewModel();
  }

  HomeState get homeState => _homeState;

  BottomNavigationTabs get currentTab => _currentTab;

  Stream<ToastMessage> get toastStream => _toastStreamController.stream;

  Stream<HomeState> get homeStream => _onHomeStateStreamController.stream;

  UnmodifiableListView<BottomNavigationTabs> get allTabs => UnmodifiableListView(_bottomTabs);

  Future<void> _initializeHomeViewModel() async {
    if (_homeState is! InitialHomeState) return;

    _homeState = const LoadingHomeState();
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
                _homeState = ErrorHomeState(
                  failure: AppFailure(
                    message: "User not found",
                    trace: currentAppUserState,
                    failureType: FailureType.illegalStateFailure,
                  ),
                );
                _toastStreamController.add(
                  const ToastError(message: "Current user data not found"),
                );
                return;
              }

              _homeState = ReadyHomeState(appUser: currentUser);

              break;
            case Error<AppUser?>():
              _homeState = ErrorHomeState(failure: currentAppUserState.failure);
              _toastStreamController.add(
                ToastError(message: currentAppUserState.failure.message),
              );
              break;
          }

        case Error<User>():
          _homeState = ErrorHomeState(failure: currentUserState.failure);
          _toastStreamController.add(
            ToastError(message: currentUserState.failure.message),
          );
          break;
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> logout() async {
    if (_homeState is LoadingHomeState) return;

    _homeState = const LoadingHomeState();
    notifyListeners();

    try {
      Result<void> logoutResult = await _authenticationRepository.logout();

      switch (logoutResult) {
        case Success<void>():
          _homeState = const InitialHomeState();
          _toastStreamController.add(
            const ToastSuccess(message: "Logged out successfully"),
          );
          break;

        case Error<void>():
          _homeState = ErrorHomeState(failure: logoutResult.failure);
          _toastStreamController.add(
            ToastError(message: logoutResult.failure.message),
          );
          break;
      }
    } finally {
      _onHomeStateStreamController.add(_homeState);
      notifyListeners();
    }
  }

  void changeTab(BottomNavigationTabs tab) {
    _currentTab = tab;
    notifyListeners();
  }
}
