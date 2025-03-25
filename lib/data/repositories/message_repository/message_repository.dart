import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';

abstract class MessageRepository {
  Future<Result<List<ThreadRemote>>> fetchMyThreads({
    required int pageSize,
    required String userId,
    DateTime? lastFetchedCreatedAt,
  });

  Future<Result<ThreadRemote?>> fetchAThread({
    required String threadId,
  });

  Future<Result<ThreadRemote>> createAThread({
    required String participant1,
    required String participant2,
  });

  Future<Result<ThreadRemote?>> fetchThreadWithForParticipants({
    required String participant1,
    required String participant2,
  });

  Future<Result<int>> countMessagesInThread({
    required String threadId,
  });

  Future<Result<List<MessageRemote>>> fetchThreadMessages({
    required int pageSize,
    required String threadId,
    DateTime? lastFetchedCreatedAt,
  });

  Future<Result<MessageRemote>> sendMessage({
    required String threadId,
    required MessageRemote message,
  });


  Stream<MessageRemote> watchThread({
    required String threadId,
  });
}
