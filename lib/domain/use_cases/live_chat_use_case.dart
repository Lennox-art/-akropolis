import 'dart:async';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/message_repository/message_repository.dart';
import 'package:akropolis/domain/models/thread_model.dart';
import 'package:logging_service/logging_service.dart';


class LiveChatUseCase {
  final MessageRepository _messageRepository;
  late final StreamSubscription<MessageRemote> _onMessageUpdatedStreamSubscription;
  late final StreamController<MessageRemote> _onAMessageUpdatedStream = StreamController.broadcast();
  final Thread _threadModel;
  final LoggingService _log;

  LiveChatUseCase({
    required Thread thread,
    required MessageRepository messageRepository,
    required LoggingService loggingService,
  })  : _threadModel = thread,
        _messageRepository = messageRepository,
        _log = loggingService {
    _initializeChatUseCase();
  }

  Future<void> _initializeChatUseCase() async {
    _log.debug("ChatUseCase : _initializeChatUseCase(${_threadModel.threadRemote.id})");
    _onMessageUpdatedStreamSubscription = _messageRepository.watchThread(threadId: _threadModel.threadRemote.id).listen(_onMessageUpdated);
  }


  /// 1. Fetch messages from [MessageRepository]
  Future<Result<List<MessageRemote>>> fetchMessages({int pageSize= 0, DateTime? lastFetchedCreatedAt,}) async {
    return await _messageRepository.fetchThreadMessages(
      pageSize: pageSize,
      threadId: _threadModel.threadRemote.id,
      lastFetchedCreatedAt: lastFetchedCreatedAt,
    );
  }


  /// 2. Update [messageUpdatedStream] when device a device changes
  Future<void> _onMessageUpdated(MessageRemote messageUpdate) async {
    _log.debug("ChatUseCase : _onMessageUpdated($messageUpdate)");
    _onAMessageUpdatedStream.add(messageUpdate);
  }

  /// 3. Emits a [MessageRemote] on message or device update
  Stream<MessageRemote> get messageUpdatedStream => _onAMessageUpdatedStream.stream;

  void close() {
    _onMessageUpdatedStreamSubscription.cancel();
  }
}

