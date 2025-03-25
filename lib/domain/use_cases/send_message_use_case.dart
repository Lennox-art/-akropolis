import 'dart:typed_data';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/local_models/local_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:akropolis/data/repositories/message_repository/message_repository.dart';
import 'package:akropolis/data/services/data_storage_service/local_data_storage_service.dart';
import 'package:akropolis/data/services/file_storage_service/local_file_storage_service.dart';
import 'package:akropolis/data/services/file_storage_service/remote_file_storage_service.dart';
import 'package:common_fn/common_fn.dart';
import 'package:exception_base/exception_base.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SendMessageUseCase {
  final MessageRepository _messageRepository;
  final AuthenticationRepository _authenticationRepository;
  final RemoteFileStorageService _remoteFileStorageService;
  final LocalFileStorageService _localFileStorageService;
  final LocalDataStorageService _localDataStorageService;

  SendMessageUseCase({
    required MessageRepository messageRepository,
    required AuthenticationRepository authenticationRepository,
    required RemoteFileStorageService remoteFileStorageService,
    required LocalFileStorageService localFileStorageService,
    required LocalDataStorageService localDataStorageService,
  })  : _messageRepository = messageRepository,
        _authenticationRepository = authenticationRepository,
        _remoteFileStorageService = remoteFileStorageService,
        _localFileStorageService = localFileStorageService,
        _localDataStorageService = localDataStorageService;

  Future<Result<void>> sendMessage({
    String? threadId,
    required String sendToUserId,
    required Uint8List thumbnailData,
    required Uint8List videoData,
    dynamic Function(ProgressModel)? onProgress,
  }) async {
    Result<User> currentUser = await _authenticationRepository.getCurrentUser();
    if (currentUser is Error<User>) {
      return Result.error(
        failure: currentUser.failure,
      );
    }

    User user = (currentUser as Success<User>).data;
    late Result<ThreadRemote?> threadRemoteResult;

    if (threadId != null) {
      threadRemoteResult = await _messageRepository.fetchAThread(threadId: threadId);
    } else {
      Result<ThreadRemote?> existingThread = await _messageRepository.fetchThreadWithForParticipants(
        participant1: user.uid,
        participant2: sendToUserId,
      );

      switch (existingThread) {
        case Success<ThreadRemote?>():
          ThreadRemote? existingRemoteThread = existingThread.data;
          if (existingRemoteThread != null) {
            threadRemoteResult = existingThread;
            break;
          }

          threadRemoteResult = await _messageRepository.createAThread(
            participant1: user.uid,
            participant2: sendToUserId,
          );
          break;

        case Error<ThreadRemote?>():
          return Result.error(failure: existingThread.failure);
      }
    }

    switch (threadRemoteResult) {
      case Success<ThreadRemote?>():
        ThreadRemote? thread = threadRemoteResult.data;
        if (thread == null) {
          return Result.error(
            failure: AppFailure(
              message: "Thread not found",
              trace: threadRemoteResult,
              failureType: FailureType.illegalStateFailure,
            ),
          );
        }
        if (!thread.accepted) {
          Result<int> messageCountResult = await _messageRepository.countMessagesInThread(threadId: thread.id);
          switch (messageCountResult) {
            case Success<int>():
              if (messageCountResult.data > 0) {
                return Result.error(
                  failure: AppFailure(
                    message: "Conversation pending",
                    trace: threadRemoteResult,
                    failureType: FailureType.illegalStateFailure,
                  ),
                );
              }
            case Error<int>():
              return Result.error(failure: messageCountResult.failure);
          }
        }

        final Result<LocalFileCache> uploadThumbnailResult = await _remoteFileStorageService.uploadBlob(
          MediaBlobData(blob: thumbnailData, mediaType: MediaType.image),
          onProgress: onProgress,
        );

        late String thumbnailUrl;
        switch (uploadThumbnailResult) {
          case Success<LocalFileCache>():
            thumbnailUrl = uploadThumbnailResult.data.url;
            //Finish thumbnail cache asynchronously
            _localFileStorageService.cacheLocalFileData(thumbnailData).then(
              (cacheResult) {
                if (cacheResult is Success<Sha1>) {
                  _localDataStorageService.setFileCache(localFileCache: uploadThumbnailResult.data);
                }
              },
            );

            break;
          case Error<LocalFileCache>():
            return Result.error(failure: uploadThumbnailResult.failure);
        }

        //Upload video
        final Result<LocalFileCache> uploadVideoResult = await _remoteFileStorageService.uploadBlob(
          MediaBlobData(blob: videoData, mediaType: MediaType.video),
          onProgress: onProgress,
        );

        late String videoUrl;
        switch (uploadVideoResult) {
          case Success<LocalFileCache>():
            videoUrl = uploadVideoResult.data.url;
            //Finish video cache asynchronously
            _localFileStorageService.cacheLocalFileData(videoData).then(
              (cacheResult) {
                if (cacheResult is Success<Sha1>) {
                  _localDataStorageService.setFileCache(localFileCache: uploadVideoResult.data);
                }
              },
            );

            break;
          case Error<LocalFileCache>():
            return Result.error(failure: uploadVideoResult.failure);
        }

        //Finish video cache at any time
        _localFileStorageService.cacheLocalFileData(videoData);

        return await _messageRepository.sendMessage(
          threadId: thread.id,
          message: MessageRemote(
            id: generateRandomUuid(),
            sendByUserId: user.uid,
            sendToUserId: sendToUserId,
            thumbnailUrl: thumbnailUrl,
            videoUrl: videoUrl,
            createdAt: DateTime.now(),
            mediaType: MediaType.video,
          ),
        );
      case Error<ThreadRemote?>():
        return Result.error(failure: threadRemoteResult.failure);
    }
  }
}
