import 'dart:io';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/local_models/local_models.dart';
import 'package:akropolis/data/services/data_storage_service/local_data_storage_service.dart';
import 'package:akropolis/data/services/file_storage_service/local_file_storage_service.dart';
import 'package:akropolis/data/services/file_storage_service/remote_file_storage_service.dart';

class GetMediaUseCase {
  final LocalDataStorageService _localDataStorageService;
  final LocalFileStorageService _localFileStorageService;
  final RemoteFileStorageService _remoteFileStorageService;

  GetMediaUseCase({
    required LocalDataStorageService localDataStorageService,
    required LocalFileStorageService localFileStorageService,
    required RemoteFileStorageService remoteFileStorageService,
  })  : _localDataStorageService = localDataStorageService,
        _localFileStorageService = localFileStorageService,
        _remoteFileStorageService = remoteFileStorageService;

  Future<Result<MapEntry<String, MediaData>>> getMediaFromUrl(
    String url, {
    Function(ProgressModel)? onProgress,
  }) async {
    //Check if in local data storage first
    Result<LocalFileCache?> localFileCacheResult = await _localDataStorageService.findLocalFileCacheByUrl(
      url: url,
    );

    if (localFileCacheResult is Success<LocalFileCache?> && localFileCacheResult.data != null) {
      Result<File?> fetchLocalFileResult = await _localFileStorageService.getCachedFileData(
        Sha1(
          localFileCacheResult.data!.sha1,
        ),
      );

      if (fetchLocalFileResult is Success<File?> && fetchLocalFileResult.data != null) {
        return Result.success(data: MapEntry(url, MediaData(file: fetchLocalFileResult.data!, mediaType: localFileCacheResult.data!.mediaType)));
      }
    }

    //Get from remote storage
    Result<MediaBlobData> fetchRemoteFileResult = await _remoteFileStorageService.downloadBlob(
      url,
      onProgress: onProgress,
    );

    switch (fetchRemoteFileResult) {
      case Success<MediaBlobData>():
        //Cache new data to files
        Result<CacheFileResult> cacheFileResult = await _localFileStorageService.cacheLocalFileData(
          fetchRemoteFileResult.data.blob,
        );

        switch (cacheFileResult) {
          case Success<CacheFileResult>():
            Result<LocalFileCache> cacheLocalFileResult = await _localDataStorageService.setFileCache(
              localFileCache: LocalFileCache(
                sha1: cacheFileResult.data.sha1.hash,
                url: url,
                mediaType: fetchRemoteFileResult.data.mediaType,
              ),
            );

            switch (cacheLocalFileResult) {
              case Success<LocalFileCache>():
                print("Successfully cached file ${cacheLocalFileResult.data.sha1}");
                break;
              case Error<LocalFileCache>():
                print("Failed to cache file ${cacheLocalFileResult.failure.message}");
                break;
            }

            return Result.success(
              data: MapEntry(
                url,
                MediaData(file: cacheFileResult.data.file, mediaType: fetchRemoteFileResult.data.mediaType),
              ),
            );
          case Error<CacheFileResult>():
            return Result.error(failure: cacheFileResult.failure);
        }

      case Error<MediaBlobData>():
        return Result.error(failure: fetchRemoteFileResult.failure);
    }
  }
}
