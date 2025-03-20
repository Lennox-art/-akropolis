import 'dart:async';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:akropolis/data/repositories/post_repository/post_repository.dart';
import 'package:akropolis/data/repositories/user_repository/user_repository.dart';
import 'package:akropolis/presentation/features/profile/model/profile_models.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ProfileViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;
  final PostRepository _postRepository;
  final StreamController<ToastMessage> _toastMessageStream = StreamController.broadcast();
  ProfileState _profileState = const InitialProfileState();
  AppUser? _appUser;
  int? _logicianCount ;
  int? _empathCount;
  int? _postsCount;

  ProfileViewModel({
    required UserRepository userRepository,
    required AuthenticationRepository authenticationRepository,
    required PostRepository postRepository,
  })  : _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        _postRepository = postRepository {
    initializeViewModel();
  }

  AppUser? get appUser => _appUser;

  ProfileState get profileState => _profileState;

  int? get logicianCount => _logicianCount;

  int? get empathCount => _empathCount;

  int? get postsCount => _postsCount;

  Future<void> initializeViewModel() async {
    if (_profileState is! InitialProfileState) return;

    try {
      _profileState = const LoadingProfileState();
      notifyListeners();

      Result<User> currentUserResult = await _authenticationRepository.getCurrentUser();
      switch (currentUserResult) {
        case Success<User>():
          Result<AppUser?> currentAppUserResult = await _userRepository.findUserById(
            id: currentUserResult.data.uid,
          );

          switch (currentAppUserResult) {
            case Success<AppUser?>():
              AppUser? fetchedUser = currentAppUserResult.data;
              if (fetchedUser == null) {
                _profileState = const InitialProfileState();
                return;
              }

              _appUser = fetchedUser;
              _profileState = const LoadedProfileState();
              _fetchCounts();
              break;
            case Error<AppUser?>():
              _profileState = const InitialProfileState();
              _toastMessageStream.add(ToastError(message: currentAppUserResult.failure.message));
              break;
          }
        case Error<User>():
          _profileState = const InitialProfileState();
          _toastMessageStream.add(ToastError(message: currentUserResult.failure.message));
          break;
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> _fetchCounts() async {
    if (_profileState is! LoadedProfileState) return;
    Result<int> countUserPostResult = await _postRepository.countUserPosts(userId: appUser!.id);
    switch (countUserPostResult) {
      case Success<int>():
        _postsCount = countUserPostResult.data;
        notifyListeners();
        break;
      case Error<int>():
        break;
    }
  }
}
