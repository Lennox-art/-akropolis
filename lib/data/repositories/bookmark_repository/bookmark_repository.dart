import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';

abstract class BookmarkRepository {
  Future<Result<Bookmark>> addBookmarks({
    required String userId,
    required String postId,
    required NewsChannel channel,
  });

  Future<Result<void>> removeBookmarks({
    required String userId,
    required String postId,
  });

  Future<Result<List<Bookmark>>> fetchBookmarks({
    required String userId,
    required int pageSize,
    DateTime? lastFetchedCreatedAt,
  });
}