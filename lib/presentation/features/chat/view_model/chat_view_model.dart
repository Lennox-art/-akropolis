import 'dart:async';
import 'dart:collection';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/message_repository/message_repository.dart';
import 'package:akropolis/domain/models/thread_model.dart';
import 'package:akropolis/domain/use_cases/live_chat_use_case.dart';
import 'package:akropolis/domain/use_cases/send_message_use_case.dart';
import 'package:akropolis/presentation/features/chat/model/chat_models.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/cupertino.dart';

class ChatViewModel extends ChangeNotifier {
  final Thread _thread;
  final String _currentUserId;
  final MessageRepository _messageRepository;
  final LiveChatUseCase _liveChatUseCase;
  late final StreamSubscription<MessageRemote> _onMessageSubscription;
  final StreamController<ToastMessage> _toastMessageStream = StreamController.broadcast();
  final SplayTreeSet<MessageRemote> _chatItemsSet = SplayTreeSet(
    null,
    (a) => true,
  );

  ChatState _chatState = const ChatInitialState();
  ChatState _chatItemsState = const ChatLoadedState();

  ChatViewModel({
    required ChatDto chatDto,
    required SendMessageUseCase sendMessageUseCase,
    required LiveChatUseCase liveChatUseCase,
    required MessageRepository messageRepository,
  })  : _thread = chatDto.thread,
        _liveChatUseCase = liveChatUseCase,
        _messageRepository = messageRepository,
        _currentUserId = chatDto.currentUserId {
    _onMessageSubscription = _liveChatUseCase.messageUpdatedStream.listen((message) {
      _chatItemsSet.add(message);
      notifyListeners();
    });
    fetchMessages();
    initializeViewModel();
  }

  Thread get thread => _thread;

  String get currentUserId => _currentUserId;

  AppUser get otherUser => _thread.participant1.id == _currentUserId ? _thread.participant2 : thread.participant1;

  ChatState get chatState => _chatState;

  ChatState get chatItemsState => _chatItemsState;

  bool get amIInitiator => currentUserId == thread.participant1.id;

  bool get hasThreadBeenAccepted => thread.threadRemote.accepted;

  Stream<ToastMessage> get toastMessageStream => _toastMessageStream.stream;

  UnmodifiableListView<MessageRemote> get messageList => UnmodifiableListView(_chatItemsSet);

  void initializeViewModel() {
    if (_chatState is! ChatInitialState) return;
    try {

      if (thread.threadRemote.accepted) {
        _chatState = const ChatLoadedState();
      } else {
        _chatState = const ChatRequestedState();
      }


    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchMessages() async {
    if (_chatItemsState is ChatLoadingState) return;

    try {
      _chatItemsState = const ChatLoadingState();
      notifyListeners();

      Result<List<MessageRemote>> messagesResult = await _liveChatUseCase.fetchMessages(
        pageSize: 20,
        lastFetchedCreatedAt: _chatItemsSet.lastOrNull?.createdAt,
      );

      switch (messagesResult) {
        case Success<List<MessageRemote>>():
          List<MessageRemote> newItems = messagesResult.data;
          _chatItemsSet.addAll(newItems);
          break;
        case Error<List<MessageRemote>>():
          _toastMessageStream.add(ToastError(message: messagesResult.failure.message));
          break;
      }
    } finally {
      _chatItemsState = const ChatLoadedState();
      notifyListeners();
    }
  }

  Future<void> declineMessageRequest() async {
    if (_chatState is! ChatRequestedState) return;
    if (amIInitiator) return;

    try {
      _chatState = const ChatLoadingState();
      notifyListeners();

      Result<void> declineThreadResult = await _messageRepository.declineThread(
        threadId: _thread.threadRemote.id,
      );

      switch (declineThreadResult) {
        case Success<void>():
          _chatState = const ChatDeclinedState();
          break;
        case Error<void>():
          _chatState = const ChatRequestedState();
          break;
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> acceptMessageRequest() async {
    print("State is $_chatState");
    if (_chatState is! ChatRequestedState) return;
    print("State is requested");
    if (amIInitiator) return;
    print("I'm not initiator");

    try {
      _chatState = const ChatLoadingState();
      notifyListeners();

      Result<void> acceptThreadResult = await _messageRepository.acceptThread(
        threadId: _thread.threadRemote.id,
      );

      switch (acceptThreadResult) {
        case Success<void>():
          _chatState = const ChatLoadedState();
          break;
        case Error<void>():
          _chatState = const ChatRequestedState();
          break;
      }
    } finally {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _onMessageSubscription.cancel();
    super.dispose();
  }
}
