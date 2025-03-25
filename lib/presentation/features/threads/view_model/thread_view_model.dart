import 'dart:async';
import 'dart:collection';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:akropolis/data/repositories/message_repository/message_repository.dart';
import 'package:akropolis/domain/models/thread_model.dart';
import 'package:akropolis/domain/use_cases/fetch_threads_use_case.dart';
import 'package:akropolis/presentation/features/threads/model/thread_state.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ThreadViewModel extends ChangeNotifier {
  final FetchThreadsUseCase _fetchThreadsUseCase;
  final MessageRepository _messageRepository;
  final AuthenticationRepository _authenticationRepository;
  final StreamController<ToastMessage> _toastStreamController = StreamController.broadcast();
  final SplayTreeSet<Thread> threadItemSet = SplayTreeSet(
    null,
    (a) => true,
  );

  ThreadsState _state = ThreadsLoadedState();

  late final User _user;

  ThreadViewModel({
    required FetchThreadsUseCase fetchThreadsUseCase,
    required MessageRepository messageRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _messageRepository = messageRepository,
        _fetchThreadsUseCase = fetchThreadsUseCase,
        _authenticationRepository = authenticationRepository {
    _initializeViewModel();
  }

  ThreadsState get threadState => _state;

  UnmodifiableListView<Thread> get threadList => UnmodifiableListView(threadItemSet);

  Stream<ToastMessage> get stream => _toastStreamController.stream;
  String get currentUserId => _user.uid;

  Future<void> _initializeViewModel() async {
    var currentUserResult = await _authenticationRepository.getCurrentUser();
    switch (currentUserResult) {
      case Success<User>():
        _user = currentUserResult.data;
        loadMoreItems();
        break;
      case Error<User>():
        break;
    }
  }

  Future<void> loadMoreItems() async {
    print("Loading messages");
    Result<List<Thread>> threadRemote = await _fetchThreadsUseCase.fetchThreads(
      pageSize: 10,
      userId: _user.uid,
      lastFetchedCreatedAt: threadItemSet.lastOrNull?.threadRemote.createdAt,
    );

    switch (threadRemote) {
      case Success<List<Thread>>():
        threadItemSet.addAll(threadRemote.data);
        notifyListeners();
        break;
      case Error<List<Thread>>():
        break;
    }
  }
}
