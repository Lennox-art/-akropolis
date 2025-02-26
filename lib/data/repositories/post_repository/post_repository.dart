import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';

abstract class PostRepository {

  Future<Result<NewsPost>> setPost({
    required NewsPost newsPost,
  });

  Future<Result<PostComment>> setPostComment({
    required String collection,
    required PostComment comment,
  });

  Future<Result<List<NewsPost>>> fetchUserPostsNews({
    required int pageSize,
    List<String> keywords = const [],
  });

  Future<Result<List<NewsPost>>> fetchHeadlines({
    required int pageSize,
    List<String> keywords = const [],
  });

  Future<Result<List<NewsPost>>> fetchLocalNews({
    required int pageSize,
    required String country,
    List<String> keywords = const [],
  });

  Future<Result<List<NewsPost>>> fetchWorldNews({
    required int pageSize,
    required String? country,
    List<String> keywords = const [],
  });

  Future<Result<List<PostComment>>> fetchPostComments({
    required String postId,
    required String collection,
    required int pageSize,
  });



}
