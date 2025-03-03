import 'dart:collection';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/models/news_card_model.dart';
import 'package:akropolis/domain/use_cases/fetch_for_you_post_use_case.dart';
import 'package:akropolis/domain/use_cases/fetch_highlights_post_use_case.dart';
import 'package:akropolis/domain/use_cases/fetch_world_news_post_use_case.dart';
import 'package:akropolis/domain/use_cases/news_card_use_case.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:flutter/material.dart';

class WorldNewsViewModel extends ChangeNotifier {
  final FetchWorldNewsPostUseCase _fetchWorldNewsPostUseCase;
  final NewsCardUseCase _newsCardUseCase;

  WorldNewsViewModel({
    required FetchWorldNewsPostUseCase fetchWorldNewsPostUseCase,
    required NewsCardUseCase newsCardUseCase,
  })  : _fetchWorldNewsPostUseCase = fetchWorldNewsPostUseCase,
        _newsCardUseCase = newsCardUseCase;


  Future<Result<List<NewsCardPostModel>?>> fetchWorldPostsNews({
    required int pageSize,
    required bool fromCache,
    String? country,
  }) async {
    Result<List<NewsPost>?> newsResults = await _fetchWorldNewsPostUseCase.fetchWorldNewsPostsNews(
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
