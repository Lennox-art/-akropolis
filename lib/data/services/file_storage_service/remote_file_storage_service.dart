import 'dart:typed_data';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/local_models/local_models.dart';


abstract class RemoteFileStorageService {
  /// Function: [uploadBlob] a function that will upload a [blob] to the remote server if it doesn't exist
  /// Returns: [Result.success], with a [Sha1] of the [blob] unless otherwise
  /// Possible Failures: [FailureType.networkClientFailure], [FailureType.networkServerFailure],
  Future<Result<LocalFileCache>> uploadBlob(
    Uint8List blob, {
    Function(ProgressModel progress)? onProgress,
  });

  /// Function: [downloadBlob] a function that will download the [Uint8List] from the remote server
  /// Returns: [Result.success],if the blob is found, if not found returns [Result.error] with [FailureType.networkServerFailure]
  /// Possible Failures: [FailureType.networkClientFailure], [FailureType.networkServerFailure]
  Future<Result<Uint8List>> downloadBlob(String url, {Function(ProgressModel progress)? onProgress,});
}
