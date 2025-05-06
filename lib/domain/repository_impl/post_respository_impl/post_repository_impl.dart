import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/post_repository/post_repository.dart';
import 'package:akropolis/data/services/data_storage_service/remote_data_storage_service.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';

class PostRepositoryImpl extends PostRepository {
  final RemoteDataStorageService _remoteDataStorageService;

  PostRepositoryImpl({
    required RemoteDataStorageService remoteDataStorageService,
  }) : _remoteDataStorageService = remoteDataStorageService;

  @override
  Future<Result<NewsPost>> setPost({
    required NewsPost newsPost,
  }) =>
      _remoteDataStorageService.setUserPost(
        post: newsPost,
      );

  @override
  Future<Result<List<NewsPost>>> fetchHeadlines({
    required int pageSize,
    List<String> keywords = const [],
  }) =>
      _remoteDataStorageService.fetchHeadlines(
        pageSize: pageSize,
        keywords: keywords,
      );

  @override
  Future<Result<List<NewsPost>>> fetchLocalNews({
    required int pageSize,
    required String country,
    List<String> keywords = const [],
  }) =>
      _remoteDataStorageService.fetchLocalNews(
        pageSize: pageSize,
        country: country,
        keywords: keywords,
      );

  @override
  Future<Result<List<NewsPost>>> fetchUserPostsNews({
    required int pageSize,
    List<String> keywords = const [],
  }) =>
      _remoteDataStorageService.fetchUserPostsNews(
        pageSize: pageSize,
        keywords: keywords,
      );

  @override
  Future<Result<List<NewsPost>>> fetchWorldNews({
    required int pageSize,
    required String? country,
    List<String> keywords = const [],
  }) =>
      _remoteDataStorageService.fetchWorldNews(
        pageSize: pageSize,
        country: country,
        keywords: keywords,
      );

  @override
  Future<Result<PostComment>> setPostComment({
    required String collection,
    required PostComment comment,
  }) =>
      _remoteDataStorageService.setPostComment(
        collection: collection,
        comment: comment,
      );

  @override
  Future<Result<List<PostComment>>> fetchPostComments({
    required String postId,
    required String collection,
    required int pageSize,
  }) =>
      _remoteDataStorageService.fetchPostComments(
        collection: collection,
        postId: postId,
        pageSize: pageSize,
      );

  @override
  Future<Result<int>> countPostComments({
    required String postId,
    required String collection,
  }) =>
      _remoteDataStorageService.countPostComments(
        collection: collection,
        postId: postId,
      );

  @override
  Future<Result<void>> addUserToPostViewers({
    required String postId,
    required String collection,
    required String userId,
  }) =>
      _remoteDataStorageService.countPostComments(
        collection: collection,
        postId: postId,
      );

  @override
  Future<Result<void>> addUserToPostCommentEmpathyReaction({
    required String postId,
    required String collection,
    required String commentId,
    required String userId,
  }) =>
      _remoteDataStorageService.addUserToPostCommentEmpathyReaction(
        collection: collection,
        postId: postId,
        commentId: commentId,
        userId: userId,
      );

  @override
  Future<Result<void>> addUserToPostCommentLogicianReaction({
    required String postId,
    required String collection,
    required String commentId,
    required String userId,
  }) =>
      _remoteDataStorageService.addUserToPostCommentLogicianReaction(
        collection: collection,
        postId: postId,
        commentId: commentId,
        userId: userId,
      );

  @override
  Future<Result<void>> addUserToPostEmpathyReaction({
    required String postId,
    required String collection,
    required String userId,
  }) =>
      _remoteDataStorageService.addUserToPostEmpathyReaction(
        collection: collection,
        postId: postId,
        userId: userId,
      );

  @override
  Future<Result<void>> addUserToPostLogicianReaction({
    required String postId,
    required String collection,
    required String userId,
  }) =>
      _remoteDataStorageService.addUserToPostLogicianReaction(
        collection: collection,
        postId: postId,
        userId: userId,
      );

  @override
  Future<Result<int>> countUserPosts({required String userId}) async {
    return _remoteDataStorageService.countUserPosts(userId: userId);
  }

  @override
  Future<Result<List<NewsPost>>> fetchPostsWithIds({
    required Map<String, NewsChannel> ids,
  }) {
    return _remoteDataStorageService.fetchPostsWithIds(ids: ids);
  }

}
