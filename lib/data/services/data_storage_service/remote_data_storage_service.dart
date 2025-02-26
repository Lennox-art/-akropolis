import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';

abstract class RemoteDataStorageService {
  /// Function:
  /// Returns:
  /// Possible Failures:
  Future<Result<AppUser?>> findUserById({required String id});

  /// Function:
  /// Returns:
  /// Possible Failures:
  Future<Result<AppUser>> setUser({required AppUser user});

  /// Function:
  /// Returns:
  /// Possible Failures:
  Future<Result<NewsPost>> setUserPost({required NewsPost post});

  /// Function:
  /// Returns:
  /// Possible Failures:
  Future<Result<PostComment>> setPostComment({required String collection, required PostComment comment});

  /// Function:
  /// Returns:
  /// Possible Failures:
  Future<Result<List<NewsPost>>> fetchHeadlines({required int pageSize, required List<String> keywords});

  /// Function:
  /// Returns:
  /// Possible Failures:
  Future<Result<List<NewsPost>>> fetchLocalNews({required int pageSize, required String country, required List<String> keywords});

  /// Function:
  /// Returns:
  /// Possible Failures:
  Future<Result<List<NewsPost>>> fetchUserPostsNews({required int pageSize, required List<String> keywords});

  /// Function:
  /// Returns:
  /// Possible Failures:
  Future<Result<List<NewsPost>>> fetchWorldNews({required int pageSize, String? country, required List<String> keywords});

  /// Function:
  /// Returns:
  /// Possible Failures:
  Future<Result<List<PostComment>>> fetchPostComments({required int pageSize, required String collection, required String postId});
}