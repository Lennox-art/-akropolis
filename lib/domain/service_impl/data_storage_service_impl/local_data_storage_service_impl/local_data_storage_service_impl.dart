import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/local_models/local_models.dart';
import 'package:akropolis/data/services/data_storage_service/local_data_storage_service.dart';
import 'package:exception_base/exception_base.dart';
import 'package:hive/hive.dart';
import 'package:logging_service/logging_service.dart';

class HiveLocalStorageService extends LocalDataStorageService {
  final HiveAesCipher _hiveCypher;
  final LoggingService _log;

  Future<Box<LocalFileCache>> get _lfsCacheBox => Hive.openBox<LocalFileCache>('file_cache', encryptionCipher: _hiveCypher);

  Future<Box<LocalNotification>> get _notificationBox => Hive.openBox<LocalNotification>('notification', encryptionCipher: _hiveCypher);

  HiveLocalStorageService({
    required HiveAesCipher hiveCypher,
    required String? path,
    required LoggingService log,
  })  : _hiveCypher = hiveCypher,
        _log = log {
    _initializeHive(path);
  }

  void _initializeHive(String? path) {
    Hive.init(path);
  }

  /// Function: [findLocalFileCacheByUrl], gets a [LocalFileCache] associated by the provided [url]
  /// Returns: [Result.success], if not found [selectedThumbnail] will be null
  @override
  Future<Result<LocalFileCache?>> findLocalFileCacheByUrl({required String url}) async {
    try {
      _log.debug("HiveLocalStorageService : findLocalFileCacheByUrl(url=$url)");

      var box = await _lfsCacheBox;
      LocalFileCache? localFileCache = box.get(url);
      return Result.success(data: localFileCache);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
          failureType: FailureType.databaseFailure,
        ),
      );
    }
  }

  /// Function: [setFileCache], idempotent that puts into the [_lfsCacheBox] with a key of [LocalFileCache.url] of the given [localFileCache]
  /// Returns: [Result.success], returns the given [localFileCache]. No expected exceptions
  @override
  Future<Result<LocalFileCache>> setFileCache({
    required LocalFileCache localFileCache,
  }) async {
    try {
      _log.debug("HiveLocalStorageService : setFileCache(localFileCache=${localFileCache.url})");
      var box = await _lfsCacheBox;
      await box.put(localFileCache.url, localFileCache);
      return Result.success(data: localFileCache);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
          failureType: FailureType.databaseFailure,
        ),
      );
    }
  }

  @override
  Future<Result<void>> deleteLocalNotification({
    required int notificationId,
  }) async {
    try {
      _log.debug("HiveLocalStorageService : deleteLocalNotification(notificationId=$notificationId)");
      var box = await _notificationBox;
      await box.delete(notificationId);
      return const Result.success(data: null);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
          failureType: FailureType.databaseFailure,
        ),
      );
    }
  }

  @override
  Future<Result<LocalNotification>> saveLocalNotification({
    required LocalNotification notification,
  }) async {
    try {
      _log.debug("HiveLocalStorageService : saveLocalNotification(notification=${notification.id})");
      var box = await _notificationBox;
      await box.put(notification.id, notification);
      return Result.success(data: notification);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
          failureType: FailureType.databaseFailure,
        ),
      );
    }
  }

  @override
  Future<Result<List<LocalNotification>>> fetchNotifications({
    required int page,
    required int pageSize,
  }) async {
    try {
      _log.debug("HiveLocalStorageService : saveLocalNotification(page=$page, pageSize=$page)");
      var box = await _notificationBox;
      List<LocalNotification> list = box.values.take(pageSize).skip(page * pageSize).toList();
      return Result.success(data: list);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
          failureType: FailureType.databaseFailure,
        ),
      );
    }
  }
}
