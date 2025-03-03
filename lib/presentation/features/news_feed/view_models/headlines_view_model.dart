import 'dart:collection';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/models/news_card_model.dart';
import 'package:akropolis/domain/use_cases/fetch_for_you_post_use_case.dart';
import 'package:akropolis/domain/use_cases/fetch_highlights_post_use_case.dart';
import 'package:akropolis/domain/use_cases/news_card_use_case.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:flutter/material.dart';

class HeadlinesViewModel extends ChangeNotifier {
  final FetchHeadlinesPostUseCase _fetchHeadlinesPostUseCase;
  final NewsCardUseCase _newsCardUseCase;

  HeadlinesViewModel({
    required FetchHeadlinesPostUseCase fetchHeadlinesPostUseCase,
    required NewsCardUseCase newsCardUseCase,
  })  : _fetchHeadlinesPostUseCase = fetchHeadlinesPostUseCase,
        _newsCardUseCase = newsCardUseCase;

  Future<Result<List<NewsCardPostModel>?>> fetchHeadlinesPostsNews({
    required int pageSize,
    required bool fromCache,
  }) async {
    Result<List<NewsPost>?> newsResults = await _fetchHeadlinesPostUseCase.fetchHeadlinesPostsNews(
      pageSize: pageSize,
      fromCache: fromCache,
    );

    switch (newsResults) {
      case Success<List<NewsPost>?>():
        List<NewsCardPostModel> newsPosts = await _newsCardUseCase.resolveNewsPosts(
          post: newsResults.data ?? [],
          channel: NewsChannel.newsHeadlines,
        );
        return Result.success(data: newsPosts);
      case Error<List<NewsPost>?>():
        return Result.error(failure: newsResults.failure);
    }
  }
}
