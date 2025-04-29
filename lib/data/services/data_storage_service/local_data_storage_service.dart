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
  /// Returns: [Result.success], if not found [selectedThumbnail] will be null
  /// Possible Failures: [FailureType.databaseFailure]
  Future<Result<LocalFileCache?>> findLocalFileCacheByUrl({
    required String url,
  });

  /// Function: [fetchNotifications], fetches [LocalNotification] associated with paging data
  /// Returns: [Result.success], if data has been found
  /// Possible Failures: [FailureType.databaseFailure]
  Future<Result<List<LocalNotification>>> fetchNotifications({
    required int page,
    required int pageSize,
  });

  /// Function: [saveLocalNotification], saves [LocalNotification] associated by a unique notification id [LocalNotification.id]
  /// Returns: [Result.success], if [notification] has been saved
  /// Possible Failures: [FailureType.databaseFailure]
  Future<Result<LocalNotification>> saveLocalNotification({
    required LocalNotification notification,
  });

  /// Function: [deleteLocalNotification], deleted [LocalNotification] associated by a unique notification id [LocalNotification.id]
  /// Returns: [Result.success], if [notification] has been deleted
  /// Possible Failures: [FailureType.databaseFailure]
  Future<Result<void>> deleteLocalNotification({
    required int notificationId,
  });

}