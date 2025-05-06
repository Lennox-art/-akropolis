import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/bookmark_repository/bookmark_repository.dart';
import 'package:akropolis/data/services/data_storage_service/remote_data_storage_service.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:exception_base/exception_base.dart';

class BookmarkRepositoryImpl extends BookmarkRepository {
  final RemoteDataStorageService _remoteDataStorageService;

  BookmarkRepositoryImpl({
    required RemoteDataStorageService remoteDataStorageService,
  }) : _remoteDataStorageService = remoteDataStorageService;

  @override
  Future<Result<Bookmark>> addBookmarks({
    required String userId,
    required String postId,
    required NewsChannel channel,
  }) async {
    try {
      return await _remoteDataStorageService.addBookmarks(
        userId: userId,
        postId: postId,
        channel: channel,
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

  @override
  Future<Result<List<Bookmark>>> fetchBookmarks({
    required String userId,
    required int pageSize,
    DateTime? lastFetchedCreatedAt,
  }) async {
    try {
      return await _remoteDataStorageService.fetchBookmarks(
        userId: userId,
        pageSize: pageSize,
        lastFetchedCreatedAt: lastFetchedCreatedAt,
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

  @override
  Future<Result<void>> removeBookmarks({
    required String userId,
    required String postId,
  }) async {
    try {
      return await _remoteDataStorageService.removeBookmarks(
        userId: userId,
        postId: postId,
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
