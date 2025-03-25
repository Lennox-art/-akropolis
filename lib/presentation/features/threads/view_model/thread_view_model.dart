import 'dart:async';
import 'dart:collection';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:akropolis/data/repositories/message_repository/message_repository.dart';
import 'package:akropolis/presentation/features/threads/model/thread_state.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ThreadViewModel extends ChangeNotifier {
  final MessageRepository _messageRepository;
  final AuthenticationRepository _authenticationRepository;
  final StreamController<ToastMessage> _toastStreamController = StreamController.broadcast();
  final SplayTreeSet<ThreadRemote> threadItemSet = SplayTreeSet(
    null,
    (a) => true,
  );

  ThreadsState _state = ThreadsLoadedState();

  late final User _user;

  ThreadViewModel({
    required MessageRepository messageRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _messageRepository = messageRepository,
        _authenticationRepository = authenticationRepository {
    _initializeViewModel();
  }

  ThreadsState get threadState => _state;

  UnmodifiableListView<ThreadRemote> get threadList => UnmodifiableListView(threadItemSet);

  Stream<ToastMessage> get stream => _toastStreamController.stream;

  Future<void> _initializeViewModel() async {
    var currentUserResult = await _authenticationRepository.getCurrentUser();
    switch (currentUserResult) {
      case Success<User>():
        _user = currentUserResult.data;
        break;
      case Error<User>():
        break;
    }
  }

  Future<void> loadMoreItems() async {
    Result<List<ThreadRemote>> threadRemote = await _messageRepository.fetchMyThreads(
      pageSize: 10,
      userId: _user.uid,
      lastFetchedCreatedAt: threadItemSet.lastOrNull?.createdAt,
    );

    switch (threadRemote) {
      case Success<List<ThreadRemote>>():
        threadItemSet.addAll(threadRemote.data);
        notifyListeners();
        break;
      case Error<List<ThreadRemote>>():
        break;
    }
  }
}
