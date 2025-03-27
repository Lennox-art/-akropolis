import 'dart:io';
import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/local_models/local_models.dart';
import 'package:akropolis/data/services/file_storage_service/remote_file_storage_service.dart';
import 'package:akropolis/data/utils/crypto_functions.dart';
import 'package:dio/dio.dart';
import 'package:exception_base/exception_base.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import 'package:logging_service/logging_service.dart';

class FirebaseCloudStorageRemoteStorageServiceImpl extends RemoteFileStorageService {
  final Reference blobDumpReference = FirebaseStorage.instance.ref().child("dump");
  final LoggingService _log;

  FirebaseCloudStorageRemoteStorageServiceImpl({required LoggingService log}) : _log = log;

  /// Function: [uploadBlob] a function that will upload a [blob] to the remote server if it doesn't exist
  /// Returns: [Result.success], with a [Sha1] of the [blob] unless otherwise
  /// Possible Failures: [FailureType.networkClientFailure], [FailureType.networkServerFailure]
  @override
  Future<Result<LocalFileCache>> uploadBlob(
      MediaBlobData blob, {
    Function(ProgressModel progress)? onProgress,
  }) async {
    try {

      _log.debug("FirebaseCloudStorageRemoteStorageServiceImpl : uploadBlob(blob=${blob.blob.length}, mediaType=${blob.mediaType})");

      Sha1 sha1 = await compute<Uint8List, Sha1>(computeSha1Hash, blob.blob);

      Reference blobRef = blobDumpReference.child(sha1.short).child(sha1.hash);
      Result<String?> existingFileResult = await _doesFileExist(blobRef);

      switch (existingFileResult) {
        case Success<String?>():
          String? downloadUrl = existingFileResult.data;
          bool exists = downloadUrl != null;
          if (exists) {
            return Result.success(
              data: LocalFileCache(sha1: sha1.hash, url: downloadUrl, mediaType: blob.mediaType),
            );
          }
          break;
        case Error<String?>():
          break;
      }

      UploadTask uploadBlobTask = blobRef.putData(blob.blob);

      await for (TaskSnapshot snapshot in uploadBlobTask.snapshotEvents) {
        if (snapshot.totalBytes == 0) continue;

        final ProgressModel progress = ProgressModel(sent: snapshot.bytesTransferred, total: snapshot.totalBytes);
        onProgress?.call(progress);
        _log.info("Transferred ${snapshot.bytesTransferred} out of ${snapshot.totalBytes} complete.");

        switch (snapshot.state) {
          case TaskState.running:
            _log.info("${sha1.hash} upload is ${progress.percent.toInt()}% complete.");
            break;
          case TaskState.paused:
            _log.info("Upload paused for ${sha1.hash}");
            break;
          case TaskState.canceled:
            return Result.error(
              failure: AppFailure(
                message: "Upload cancelled at ${progress.percent.toInt()}% completion",
                trace: snapshot,
              ),
            );
          case TaskState.error:
            return Result.error(
              failure: AppFailure(
                message: "Error uploading at ${progress.percent.toInt()}% completion",
                trace: snapshot,
              ),
            );
          case TaskState.success:
            String downloadUrl = await snapshot.ref.getDownloadURL();
            return Result.success(
              data: LocalFileCache(
                sha1: sha1.hash,
                url: downloadUrl,
                mediaType: blob.mediaType,
              ),
            );
        }
      }

      return Result.error(
        failure: AppFailure(
          message: "Upload incomplete",
          trace: uploadBlobTask,
        ),
      );
    } on SocketException catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.message,
          failureType: FailureType.networkClientFailure,
          trace: trace,
        ),
      );
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  /// Function: [downloadBlob] a function that will download the [Uint8List] from the remote server
  /// Returns: [Result.success],if the blob is found, if not found returns [Result.error] with [FailureType.networkServerFailure]
  /// Possible Failures: [FailureType.networkClientFailure], [FailureType.networkServerFailure]
  @override
  Future<Result<MediaBlobData>> downloadBlob(String url, {Function(ProgressModel progress)? onProgress}) async {
    try {
      _log.debug("FirebaseCloudStorageRemoteStorageServiceImpl : downloadBlob(url=$url)");

      Result<MediaType> mediaTypeUrlResult = await getMediaTypeFromUrl(url);
      switch (mediaTypeUrlResult) {
        case Success<MediaType>():
          Dio dio = Dio();
          Response<List<int>> response = await dio.get<List<int>>(
            url,
            options: Options(responseType: ResponseType.bytes),
            onReceiveProgress: (count, total) => onProgress?.call(
              ProgressModel(sent: count, total: total),
            ),
          );

          Uint8List bytes = Uint8List.fromList(response.data!);
          return Result.success(
            data: MediaBlobData(
              blob: bytes,
              mediaType: mediaTypeUrlResult.data,
            ),
          );
        case Error<MediaType>():
          return Result.error(failure: mediaTypeUrlResult.failure);
      }
    } on DioException catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.message ?? e.type.name,
          failureType: FailureType.networkClientFailure,
          trace: trace,
        ),
      );
    } on SocketException catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.message,
          failureType: FailureType.networkClientFailure,
          trace: trace,
        ),
      );
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  ///Function: [doesFileExist] checks if a file already exists
  /// Returns: [Result.success],if the file is found, if not found returns [Result.error] with [FailureType.networkServerFailure]
  /// Possible Failures: [FailureType.networkClientFailure], [FailureType.networkServerFailure]
  Future<Result<String?>> _doesFileExist(Reference ref) async {
    try {
      String downloadUrl = await ref.getDownloadURL(); // Try to fetch metadata
      return Result.success(data: downloadUrl); // If successful, file exists
    } on SocketException catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.message,
          failureType: FailureType.networkClientFailure,
          trace: trace,
        ),
      );
    } catch (e, trace) {
      if (e is FirebaseException) {
        if (e.code == 'object-not-found') {
          return const Result.success(data: null);
        } else {
          return Result.error(
            failure: AppFailure(
              message: e.message ?? e.code,
              trace: e.stackTrace,
            ),
          );
        }
      }
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  Future<Result<MediaType>> getMediaTypeFromUrl(String url) async {
    // 1. Make a HEAD request if extension is missing
    try {
      Response response = await Dio().head(url);
      String? contentType = response.headers.value('content-type');

      if (contentType == null) {
        return Result.error(
          failure: AppFailure(
            message: "Content type not found",
            failureType: FailureType.networkClientFailure,
            trace: response,
          ),
        );
      }

      if (contentType.startsWith('image/')) {
        return const Result.success(
          data: MediaType.image,
        );
      }
      if (contentType.startsWith('video/')) {
        return const Result.success(data: MediaType.video);
      }

      return Result.error(
        failure: AppFailure(
          message: "Unsupported content type",
          failureType: FailureType.networkClientFailure,
          trace: response,
        ),
      );
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }
}
