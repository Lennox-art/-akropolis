import 'dart:collection';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/models/news_card_model.dart';
import 'package:akropolis/domain/use_cases/fetch_for_you_post_use_case.dart';
import 'package:akropolis/domain/use_cases/fetch_highlights_post_use_case.dart';
import 'package:akropolis/domain/use_cases/fetch_local_news_post_use_case.dart';
import 'package:akropolis/domain/use_cases/news_card_use_case.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:flutter/material.dart';

class LocalNewsViewModel extends ChangeNotifier {
  final FetchLocalNewsPostUseCase _fetchLocalNewsPostUseCase;
  final NewsCardUseCase _newsCardUseCase;

  LocalNewsViewModel({
    required FetchLocalNewsPostUseCase fetchLocalNewsPostUseCase,
    required NewsCardUseCase newsCardUseCase,
  })  : _fetchLocalNewsPostUseCase = fetchLocalNewsPostUseCase,
        _newsCardUseCase = newsCardUseCase;

  Future<Result<List<NewsCardPostModel>?>> fetchLocalPostsNews({
    required int pageSize,
    required bool fromCache,
    required String country,
  }) async {
    Result<List<NewsPost>?> newsResults = await _fetchLocalNewsPostUseCase.fetchLocalNewsPostsNews(
      pageSize: pageSize,
      fromCache: fromCache,
      country: country,
    );

    switch (newsResults) {
      case Success<List<NewsPost>?>():
        List<NewsCardPostModel> newsPosts = await _newsCardUseCase.resolveNewsPosts(
          post: newsResults.data ?? [],
          channel: NewsChannel.worldNews,
        );
        return Result.success(data: newsPosts);
      case Error<List<NewsPost>?>():
        return Result.error(failure: newsResults.failure);
    }
  }
}
