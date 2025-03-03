import 'dart:collection';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/models/news_card_model.dart';
import 'package:akropolis/domain/use_cases/fetch_post_comments_use_case.dart';
import 'package:akropolis/domain/use_cases/get_media_use_case.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';

class NewsCardUseCase {
  final GetMediaUseCase _getMediaUseCase;
  final FetchPostCommentsUseCase _fetchPostCommentsUseCase;
  final SplayTreeMap<NewsPost, NewsCardPostModel> _newsCardPosts = SplayTreeMap<NewsPost, NewsCardPostModel>(
    (a, b) => -a.publishedAt.compareTo(b.publishedAt),
  );

  NewsCardUseCase({
    required GetMediaUseCase getMediaUseCase,
    required FetchPostCommentsUseCase fetchPostCommentsUseCase,
  })  : _getMediaUseCase = getMediaUseCase,
        _fetchPostCommentsUseCase = fetchPostCommentsUseCase;

  Future<List<NewsCardPostModel>> resolveNewsPosts({
    required List<NewsPost> post,
    required NewsChannel channel,
  }) {
    return Future.wait<NewsCardPostModel>(
      post.map(
        (p) => _resolveNewsPost(post: p, channel: channel),
      ),
    );
  }

  Future<NewsCardPostModel> _resolveNewsPost({
    required NewsPost post,
    required NewsChannel channel,
  }) async {
    NewsCardPostModel? existingPost = _newsCardPosts[post];
    if (existingPost != null) return existingPost;

    Result<MapEntry<String, MediaData>> thumbnailResult = await _getMediaUseCase.getMediaFromUrl(
      post.thumbnailUrl,
    );

    Result<int> replyCountResult = await _fetchPostCommentsUseCase.countPostComments(
      postCollection: channel.collection,
      postId: post.id,
      fromCache: false,
    );

    Result<List<PostComment>?> replySummaryResult = await _fetchPostCommentsUseCase.fetchPostComments(
      postCollection: channel.collection,
      pageSize: 6,
      postId: post.id,
      fromCache: false,
    );

    late Result<Map<String, NewsCardCommentModel>> commentsResult;
    switch (replySummaryResult) {
      case Success<List<PostComment>?>():
        List<PostComment> postComments = replySummaryResult.data ?? [];

        List<NewsCardCommentModel> resolvedComments = await Future.wait(
          postComments.map(_resolveNewsPostComment),
        );

        Map<String, NewsCardCommentModel> comments = {for (NewsCardCommentModel c in resolvedComments) c.postComment.id : c};
        commentsResult = Result.success(data: comments);
        break;
      case Error<List<PostComment>?>():
        commentsResult = Result.error(failure: replySummaryResult.failure);
        break;
    }

    NewsCardPostModel newPost = NewsCardPostModel(
      newsPost: post,
      newsChannel: channel,
      thumbnail: thumbnailResult,
      comments: commentsResult,
      replyCountResult: replyCountResult,
    );
    _newsCardPosts.update(newPost.newsPost, (_) => newPost, ifAbsent: () => newPost);
    return newPost;
  }

  Future<List<NewsCardCommentModel>> resolveNewsPostComments(List<PostComment> comments) => Future.wait(
    comments.map(_resolveNewsPostComment),
  );

  Future<NewsCardCommentModel> _resolveNewsPostComment(PostComment comment) async {
    Result<MapEntry<String, MediaData>> thumbnailResult = await _getMediaUseCase.getMediaFromUrl(comment.thumbnailUrl);
    switch (thumbnailResult) {
      case Success<MapEntry<String, MediaData>>():
        return NewsCardCommentModel(
          postComment: comment,
          thumbnail: thumbnailResult,
        );
      case Error<MapEntry<String, MediaData>>():
        return NewsCardCommentModel(
          postComment: comment,
          thumbnail: Result.error(failure: thumbnailResult.failure),
        );
    }
  }

  void reset() {
    _newsCardPosts.clear();
  }

}
