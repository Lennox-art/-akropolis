import 'dart:async';
import 'dart:collection';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/presentation/features/story_viewer/model/story_viewer_model.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:collection/collection.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/user_story_repository/user_story_repository.dart';
import 'package:akropolis/presentation/features/story_viewer/model/story_viewer_state.dart';
import 'package:flutter/material.dart';

class StoryViewerViewModel extends ChangeNotifier {
  final UserStoryRepository _userStoryRepository;
  final StreamController<ToastMessage> _toastStream = StreamController.broadcast();
  final AppUser _currentUser;
  final SplayTreeSet<UserStory> _userStoriesSet = SplayTreeSet();
  final List<String> _users = [];
  late int _initialIndex;
  StoryViewerState _storyViewerState = const LoadedStoryViewerState();

  StoryViewerViewModel({
    required UserStoryRepository userStoryRepository,
    required StoryViewerDto dto,
  })  : _userStoryRepository = userStoryRepository,
        _currentUser = dto.currentUser {
    _userStoriesSet.addAll(dto.initialStories);

    for(String userId in _userStoriesSet.map((e) => e.author.id)) {
      if(_users.contains(userId)) continue;
      _users.add(userId);
    }
    _initialIndex = _users.indexOf(dto.initialStory.author.id);
    loadUserStories();
  }

  int get noOfItems => _users.length;

  List<UserStory> getUserStories(int index) => UnmodifiableListView(_userStoriesSet.where((e)=> e.author.id == _users[index]));

  Stream<ToastMessage> get toastStream => _toastStream.stream;

  int get initialIndex => _initialIndex;

  AppUser get currentUser => _currentUser;

  Future<void> loadUserStories() async {
    print("Loading more stories");
    if (_storyViewerState is LoadingStoryViewerState) return;

    try {
      _storyViewerState = const LoadingStoryViewerState();
      notifyListeners();

      Result<List<UserStory>> userStoryResult = await _userStoryRepository.fetchOtherUserStories(
        pageSize: 10,
        userId: _currentUser.id,
        lastFetchedCreatedAt: _userStoriesSet.lastOrNull?.createdAt,
      );

      switch (userStoryResult) {
        case Success<List<UserStory>>():
          _userStoriesSet.addAll(userStoryResult.data);
          break;
        case Error<List<UserStory>>():
          _toastStream.add(ToastError(message: userStoryResult.failure.message));
          break;
      }
    } finally {
      _storyViewerState = const LoadedStoryViewerState();
      notifyListeners();
    }
  }
}
