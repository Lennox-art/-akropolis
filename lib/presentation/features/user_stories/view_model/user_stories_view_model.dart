import 'dart:async';
import 'dart:collection';
import 'package:collection/collection.dart';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/user_story_repository/user_story_repository.dart';
import 'package:akropolis/presentation/features/user_stories/model/user_stories_state.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/material.dart';

class UserStoriesViewModel extends ChangeNotifier {
  final UserStoryRepository _userStoryRepository;
  final AppUser _currentUser;
  final StreamController<ToastMessage> _toastStream = StreamController.broadcast();
  final SplayTreeSet<UserStory> _userStoriesSet = SplayTreeSet();
  final SplayTreeSet<UserStory> _myUserStoriesSet = SplayTreeSet();

  UserStoryState _userStoryState = const LoadedUserStoryState();
  MyUserStoryState _myUserStoryState = const LoadedMyUserStoryState();

  UserStoriesViewModel({
    required UserStoryRepository userStoryRepository,
    required AppUser currentUser,
  })  : _userStoryRepository = userStoryRepository,
        _currentUser = currentUser {
    loadMyUserStories();
    loadUserStories();
  }

  LinkedHashMap<String, List<UserStory>> get userStoriesList {
    LinkedHashMap<String, List<UserStory>> linkedHashMap = LinkedHashMap(
      equals: (a, b) => a == b,
    );
    print('${_userStoriesSet.length} other stories');
    linkedHashMap.addAll(groupBy(_userStoriesSet, (s) => s.author.id));
    return linkedHashMap;
  }

  AppUser get currentUser => _currentUser;

  List<UserStory> get myUserStoriesList => UnmodifiableListView(_myUserStoriesSet);

  Stream<ToastMessage> get toastStream => _toastStream.stream;

  UserStoryState get userStoryState => _userStoryState;

  MyUserStoryState get myUserStoryState => _myUserStoryState;

  Future<void> loadMyUserStories() async {
    if (_myUserStoryState is LoadingMyUserStoryState) return;

    try {
      _myUserStoryState = const LoadingMyUserStoryState();
      notifyListeners();

      Result<List<UserStory>> myUserStoryResult = await _userStoryRepository.getCurrentUserStories(
        userId: _currentUser.id,
      );

      switch (myUserStoryResult) {
        case Success<List<UserStory>>():
          _myUserStoriesSet.addAll(myUserStoryResult.data);
          return;
        case Error<List<UserStory>>():
          _toastStream.add(ToastError(message: myUserStoryResult.failure.message));
          return;
      }
    } finally {
      _myUserStoryState = const LoadedMyUserStoryState();
      notifyListeners();
    }
  }

  Future<void> loadUserStories() async {
    if (_userStoryState is LoadingUserStoryState) return;

    try {
      _userStoryState = const LoadingUserStoryState();
      notifyListeners();

      Result<List<UserStory>> userStoryResult = await _userStoryRepository.fetchOtherUserStories(
        pageSize: 10,
        userId: _currentUser.id,
        lastFetchedCreatedAt: _userStoriesSet.lastOrNull?.createdAt,
      );

      print("Other stories result ${userStoryResult}");

      switch (userStoryResult) {
        case Success<List<UserStory>>():
          _userStoriesSet.addAll(userStoryResult.data);
          break;
        case Error<List<UserStory>>():
          _toastStream.add(ToastError(message: userStoryResult.failure.message));
         break;
      }
    } finally {
      _userStoryState = const LoadedUserStoryState();
      notifyListeners();
    }
  }

}
