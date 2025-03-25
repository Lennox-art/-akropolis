import 'dart:async';
import 'dart:collection';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/models/thread_model.dart';
import 'package:akropolis/domain/use_cases/live_chat_use_case.dart';
import 'package:akropolis/domain/use_cases/send_message_use_case.dart';
import 'package:akropolis/presentation/features/chat/model/chat_models.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/cupertino.dart';

class ChatViewModel extends ChangeNotifier {
  final Thread _thread;
  final String _currentUserId;
  final LiveChatUseCase _liveChatUseCase;
  late final StreamSubscription<MessageRemote> _onMessageSubscription;
  final StreamController<ToastMessage> _toastMessageStream = StreamController.broadcast();
  final SplayTreeSet<MessageRemote> _chatItemsSet = SplayTreeSet(
    null,
    (a) => true,
  );

  ChatState _chatState = ChatState.loaded();
  ChatState _chatItemsState = ChatState.loaded();

  ChatViewModel({
    required ChatDto chatDto,
    required SendMessageUseCase sendMessageUseCase,
    required LiveChatUseCase liveChatUseCase,
  })  : _thread = chatDto.thread,
        _liveChatUseCase = liveChatUseCase,
        _currentUserId = chatDto.currentUserId{
    _onMessageSubscription = _liveChatUseCase.messageUpdatedStream.listen((message) {
      _chatItemsSet.add(message);
      notifyListeners();
    });
    fetchMessages();
  }

  Thread get thread => _thread;

  String get currentUserId => _currentUserId;
  AppUser get otherUser => _thread.participant1.id == _currentUserId ? _thread.participant2 : thread.participant1;

  ChatState get chatState => _chatState;

  ChatState get chatItemsState => _chatItemsState;

  Stream<ToastMessage> get toastMessageStream => _toastMessageStream.stream;

  UnmodifiableListView<MessageRemote> get messageList => UnmodifiableListView(_chatItemsSet);

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

  @override
  void dispose() {
    _onMessageSubscription.cancel();
    super.dispose();
  }
}
