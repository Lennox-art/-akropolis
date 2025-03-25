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
  Future<Result<List<AppUser>>> searchUserByDisplayName({required String displayName});

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

  /// Function:
  /// Returns:
  /// Possible Failures:
  Future<Result<int>> countPostComments({required String collection, required String postId});

  /// Function:
  /// Returns:
  /// Possible Failures:
  Future<Result<void>> addUserToPostViewers({required String postId, required String collection, required String userId});

  /// Function:
  /// Returns:
  /// Possible Failures:
  Future<Result<void>> addUserToPostEmpathyReaction({required String postId, required String collection, required String userId});

  /// Function:
  /// Returns:
  /// Possible Failures:
  Future<Result<void>> addUserToPostLogicianReaction({required String postId, required String collection, required String userId});

  /// Function:
  /// Returns:
  /// Possible Failures:
  Future<Result<void>> addUserToPostCommentEmpathyReaction({
    required String postId,
    required String collection,
    required String commentId,
    required String userId,
  });

  /// Function:
  /// Returns:
  /// Possible Failures:
  Future<Result<void>> addUserToPostCommentLogicianReaction({
    required String postId,
    required String collection,
    required String commentId,
    required String userId,
  });

  Future<Result<int>> countUserPosts({required String userId});

  /// Fetch comments
  Future<Result<List<Topic>>> fetchTopics();

  ///Messages
  Future<Result<ThreadRemote>> createAThread({
    required ThreadRemote thread,
  });

  Future<Result<ThreadRemote?>> fetchAThreads({
    required String threadId,
  });

  Future<Result<List<ThreadRemote>>> fetchMyThreads({
    required int pageSize,
    required String userId,
    DateTime? lastFetchedCreatedAt,
  });

  Future<Result<List<MessageRemote>>> fetchThreadMessages({
    required int pageSize,
    required String threadId,
    DateTime? lastFetchedCreatedAt,
  });

  Future<Result<MessageRemote>> sendMessage({
    required String threadId,
    required MessageRemote message,
  });
}
