import 'dart:collection';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/post_repository/post_repository.dart';
import 'package:common_fn/common_fn.dart';

class FetchPostCommentsUseCase {
  final PostRepository _postRepository;
  static final LinkedHashMap<String, List<PostComment>> _cachedPostComments = LinkedHashMap();
  static final LinkedHashMap<String, int> _postCommentsCount = LinkedHashMap();
  static final Map<String, PostComment?> lastFetchedCommentMap = {};

  FetchPostCommentsUseCase({
    required PostRepository postRepository,
  }) : _postRepository = postRepository;

  Future<Result<List<PostComment>?>> fetchPostComments({
    required String postCollection,
    required String postId,
    required int pageSize,
    required bool fromCache,
  }) async {
    if (fromCache && _cachedPostComments.containsKey(postId)) {
      return Result.success(
        data: pageList<PostComment>(
          _cachedPostComments[postId]!.take(pageSize).toList(),
          page: 0,
          pageSize: pageSize,
        ),
      );
    }

    Result<List<PostComment>> fetchPostResult = await _postRepository.fetchPostComments(
      postId: postId,
      collection: postCollection,
      pageSize: pageSize,
    );

    if (fetchPostResult is Success<List<PostComment>> && fetchPostResult.data.isNotEmpty) {
      _cachedPostComments.update(postId, (l) => l + fetchPostResult.data, ifAbsent: () => fetchPostResult.data);
      lastFetchedCommentMap.update(postId, (_) => fetchPostResult.data.last, ifAbsent: ()=> fetchPostResult.data.last);
    }

    return fetchPostResult;
  }

  Future<Result<int>> countPostComments({
    required String postCollection,
    required String postId,
    required bool fromCache,
  }) async {

    if (fromCache && _postCommentsCount.containsKey(postId)) {
      return Result.success(
        data: _postCommentsCount[postId]!,
      );
    }

    Result<int> countPostCommentResult = await _postRepository.countPostComments(
      postId: postId,
      collection: postCollection,
    );

    if (countPostCommentResult is Success<int>) {
      _postCommentsCount.update(postId, (l) => l + countPostCommentResult.data, ifAbsent: () => countPostCommentResult.data);
    }

    return countPostCommentResult;
  }
  

}
