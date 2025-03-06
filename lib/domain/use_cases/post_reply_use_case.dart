import 'dart:typed_data';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/local_models/local_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:akropolis/data/repositories/post_repository/post_repository.dart';
import 'package:akropolis/data/repositories/user_repository/user_repository.dart';
import 'package:akropolis/data/services/data_storage_service/local_data_storage_service.dart';
import 'package:akropolis/data/services/data_storage_service/remote_data_storage_service.dart';
import 'package:akropolis/data/services/file_storage_service/local_file_storage_service.dart';
import 'package:akropolis/data/services/file_storage_service/remote_file_storage_service.dart';
import 'package:common_fn/common_fn.dart';
import 'package:exception_base/exception_base.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostReplyUseCase {
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;
  final PostRepository _postRepository;
  final LocalDataStorageService _localDataStorageService;
  final RemoteFileStorageService _remoteFileStorageService;
  final LocalFileStorageService _localFileStorageService;

  PostReplyUseCase({
    required UserRepository userRepository,
    required AuthenticationRepository authenticationRepository,
    required PostRepository postRepository,
    required LocalDataStorageService localDataStorageService,
    required RemoteFileStorageService remoteFileStorageService,
    required LocalFileStorageService localFileStorageService,
  })  : _postRepository = postRepository,
        _localDataStorageService = localDataStorageService,
        _remoteFileStorageService = remoteFileStorageService,
        _localFileStorageService = localFileStorageService,
        _authenticationRepository = authenticationRepository,
        _userRepository = userRepository;

  Future<Result<PostComment>> post({
    required String collection,
    required String postId,
    required Uint8List thumbnailData,
    required Uint8List videoData,
    dynamic Function(ProgressModel)? onProgress,
  }) async {
    Result<User> currentUserResult = await _authenticationRepository.getCurrentUser();
    late User user;
    switch (currentUserResult) {
      case Success<User>():
        user = currentUserResult.data;
        break;
      case Error<User>():
        return Result.error(failure: currentUserResult.failure);
    }

    Result<AppUser?> currentAppUserResult = await _userRepository.findUserById(id: user.uid);
    late AppUser appUser;
    switch (currentAppUserResult) {
      case Success<AppUser?>():
        AppUser? resultUser = currentAppUserResult.data;
        if (resultUser == null) return Result.error(failure: AppFailure(message: "Current user not found"));
        appUser = resultUser;
        break;

      case Error<AppUser?>():
        return Result.error(failure: currentAppUserResult.failure);
    }

    //Upload thumbnail
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

    //Upload post finally
    return await _postRepository.setPostComment(
      collection: collection,
      comment: PostComment(
        id: generateRandomUuid(),
        thumbnailUrl: thumbnailUrl,
        postUrl: videoUrl,
        postId: postId,
        author: Author(
          id: user.uid,
          name: appUser.displayName,
          type: AuthorType.user,
        ),
        commentedAt: DateTime.now(),
        reaction: PostReaction(
          log: {},
          emp: {},
        ),
      ),
    );
  }
}
