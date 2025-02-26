import 'dart:collection';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/post_repository/post_repository.dart';
import 'package:common_fn/common_fn.dart';

class FetchLocalNewsPostUseCase {
  final PostRepository _postRepository;
  static final LinkedHashSet<NewsPost> _cachedNews = LinkedHashSet();
  NewsPost? _lastFetchedPost;

  FetchLocalNewsPostUseCase({
    required PostRepository postRepository,
  }) : _postRepository = postRepository;

  Future<Result<List<NewsPost>?>> fetchLocalNewsPostsNews({
    required int pageSize,
    required bool fromCache,
    required String country,
    List<String> keywords = const [],
  }) async {
    if (fromCache && _cachedNews.isNotEmpty) {
      return Result.success(
        data: pageList<NewsPost>(
          _cachedNews.take(pageSize).toList(),
          page: 0,
          pageSize: pageSize,
        ),
      );
    }

    Result<List<NewsPost>> fetchPostResult = await _postRepository.fetchLocalNews(
      pageSize: pageSize,
      country: country,
      keywords: keywords,
    );

    if (fetchPostResult is Success<List<NewsPost>> && fetchPostResult.data.isNotEmpty) {
      _cachedNews.addAll(fetchPostResult.data);
      _lastFetchedPost = fetchPostResult.data.last;
    }

    return fetchPostResult;
  }
}
