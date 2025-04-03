import 'dart:async';
import 'dart:collection';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:akropolis/data/repositories/message_repository/message_repository.dart';
import 'package:akropolis/data/repositories/user_repository/user_repository.dart';
import 'package:akropolis/domain/models/thread_model.dart';
import 'package:akropolis/domain/use_cases/fetch_threads_use_case.dart';
import 'package:akropolis/presentation/features/threads/model/thread_state.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ThreadViewModel extends ChangeNotifier {
  final FetchThreadsUseCase _fetchThreadsUseCase;
  final MessageRepository _messageRepository;
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;
  final StreamController<ToastMessage> _toastStreamController = StreamController.broadcast();
  final SplayTreeSet<Thread> threadItemSet = SplayTreeSet(
    null,
    (a) => true,
  );
  final List<Connect> _connects = [
    Connect(
        imageUrl: "https://neurosciencenews.com/files/2024/03/ai-real-people-image-neurosicence.jpg", name: "Caleb Robert", message: "Say hello "),
    Connect(
        imageUrl:
            "https://images.ladbible.com/resize?type=webp&quality=70&width=3840&fit=contain&gravity=auto&url=https://images.ladbiblegroup.com/v3/assets/bltb5d92757ac1ee045/blt864986663773d3e0/665435935939380b65262cb8/AI-creates-what-the-average-person.png%3Fcrop%3D590%2C590%2Cx0%2Cy0",
        name: "Alejandro Quintanilla",
        message: "Say hello "),
    Connect(
        imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSD0hP5U6Qno-wP8HzGeoMzniMWGLJK-v81ow&s",
        name: "Royals Creptin",
        message: "Say hello "),
  ];
  ThreadsState _state = ThreadsLoadedState();

  late final User _user;
  AppUser? _appUser;

  ThreadViewModel({
    required FetchThreadsUseCase fetchThreadsUseCase,
    required MessageRepository messageRepository,
    required UserRepository userRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _messageRepository = messageRepository,
        _fetchThreadsUseCase = fetchThreadsUseCase,
        _userRepository = userRepository,
        _authenticationRepository = authenticationRepository {
    _initializeViewModel();
  }

  ThreadsState get threadState => _state;

  UnmodifiableListView<Thread> get threadList => UnmodifiableListView(threadItemSet);

  UnmodifiableListView<Connect> get connectList => UnmodifiableListView(_connects);

  Stream<ToastMessage> get stream => _toastStreamController.stream;

  String get currentUserId => _user.uid;
  AppUser? get currentUser => _appUser;

  Future<void> _initializeViewModel() async {
    var currentUserResult = await _authenticationRepository.getCurrentUser();
    switch (currentUserResult) {
      case Success<User>():
        _user = currentUserResult.data;

        var appUserResult = await _userRepository.findUserById(id: _user.uid);
        switch (appUserResult) {
          case Success<AppUser?>():
            _appUser = appUserResult.data;
            loadMoreItems();
            break;
          case Error<AppUser?>():
            break;
        }
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
