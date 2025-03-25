import 'dart:collection';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:akropolis/data/repositories/topics_repository/topics_repository.dart';
import 'package:akropolis/data/repositories/user_repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class TopicsViewModel extends ChangeNotifier {
  final TopicRepository _topicRepository;
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  AppUser? _currentUser;
  final LinkedHashSet<Topic> _topics = LinkedHashSet(equals: (t1, t2) => t1.name == t2.name);
  final LinkedHashSet<Topic> _selectedTopics = LinkedHashSet(equals: (t1, t2) => t1.name == t2.name);


  TopicsViewModel({
    required TopicRepository topicRepository,
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _topicRepository = topicRepository,
        _authenticationRepository = authenticationRepository,
        _userRepository = userRepository {
    _initializeViewModel();
    _getOriginalTopics();
  }

  UnmodifiableListView<Topic> get topics => UnmodifiableListView(_topics);

  UnmodifiableListView<Topic> get selectedTopics => UnmodifiableListView(_selectedTopics);

  Future<void> _initializeViewModel() async {
    Result<List<Topic>> topicResult = await _topicRepository.getTopics();
    switch (topicResult) {
      case Success<List<Topic>>():
        _topics.addAll(topicResult.data);
        notifyListeners();

        return;
      case Error<List<Topic>>():
        return;
    }
  }

  Future<void> _getOriginalTopics() async {
    if (_currentUser != null) return;
    Result<User> userResult = await _authenticationRepository.getCurrentUser();
    switch (userResult) {
      case Success<User>():
        Result<AppUser?> appUserResult = await _userRepository.findUserById(id: userResult.data.uid);
        switch (appUserResult) {
          case Success<AppUser?>():
            _currentUser = appUserResult.data;
            _selectedTopics.addAll(_currentUser?.topics?.map((t) => Topic(name: t)).toSet() ?? {});
            notifyListeners();
            break;
          case Error<AppUser?>():
            break;
        }
        break;
      case Error<User>():
        break;
    }
  }

  void updateList(List<Topic> selectedUpdated) {
    _selectedTopics.clear();
    _selectedTopics.addAll(selectedUpdated);
    notifyListeners();
  }

  Future<void> updateTopics() async {

    Result<AppUser> updateTopicsResult = await _userRepository.saveAppUser(
      appUser: _currentUser!
        ..topics = _selectedTopics.map((t) => t.name).toSet(),
    );

    switch(updateTopicsResult) {
      case Success<AppUser>():
        _currentUser = updateTopicsResult.data;
        _selectedTopics.clear();
        _selectedTopics.addAll(_currentUser?.topics?.map((t) => Topic(name: t)).toSet() ?? {});
        notifyListeners();
        break;
      case Error<AppUser>():
        break;
    }
  }

}
