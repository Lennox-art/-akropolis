import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/message_repository/message_repository.dart';
import 'package:akropolis/data/services/data_storage_service/remote_data_storage_service.dart';
import 'package:common_fn/common_fn.dart';
import 'package:exception_base/exception_base.dart';

class MessageRepositoryImpl extends MessageRepository {
  final RemoteDataStorageService _remoteDataStorageService;

  MessageRepositoryImpl({
    required RemoteDataStorageService remoteDataStorageService,
  }) : _remoteDataStorageService = remoteDataStorageService;

  @override
  Future<Result<List<ThreadRemote>>> fetchMyThreads({
    required int pageSize,
    required String userId,
    DateTime? lastFetchedCreatedAt,
  }) async {
    return await _remoteDataStorageService.fetchMyThreads(pageSize: pageSize, userId: userId, lastFetchedCreatedAt: lastFetchedCreatedAt);
  }

  @override
  Future<Result<List<MessageRemote>>> fetchThreadMessages({
    required int pageSize,
    required String threadId,
    DateTime? lastFetchedCreatedAt,
  }) async {
    return await _remoteDataStorageService.fetchThreadMessages(
      pageSize: pageSize,
      threadId: threadId,
      lastFetchedCreatedAt: lastFetchedCreatedAt,
    );
  }

  @override
  Future<Result<MessageRemote>> sendMessage({
    required String threadId,
    required MessageRemote message,
  }) async {
  return await _remoteDataStorageService.sendMessage(threadId:threadId, message: message);
  }

  @override
  Future<Result<ThreadRemote>> createAThread({
    required String participant1,
    required String participant2,
  }) async {
    return await _remoteDataStorageService.createAThread(
      thread: ThreadRemote(
        id: generateRandomUuid(),
        participant1: participant1,
        participant2: participant2,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }

  @override
  Future<Result<ThreadRemote?>> fetchAThread({required String threadId}) {
    return _remoteDataStorageService.fetchAThreads(threadId: threadId);
  }
}
