import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/local_models/local_models.dart';

abstract class LocalDataStorageService {

  /// LocalFileCache
  /// Function: [setFileCache], is idempotent and will save a [localFileCache] by the associated [LocalFileCache.url]
  /// Returns: [Result.success], is always expected to be returned unless otherwise
  /// Possible Failures: [FailureType.databaseFailure]
  Future<Result<LocalFileCache>> setFileCache({
    required LocalFileCache localFileCache,
  });

  /// Function: [findLocalFileCacheByUrl], gets a [LocalFileCache] associated by a url
  /// Returns: [Result.success], if not found [data] will be null
  /// Possible Failures: [FailureType.databaseFailure]
  Future<Result<LocalFileCache?>> findLocalFileCacheByUrl({
    required String url,
  });

}