import 'dart:collection';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/use_cases/fetch_for_you_post_use_case.dart';
import 'package:akropolis/domain/use_cases/fetch_highlights_post_use_case.dart';
import 'package:akropolis/domain/use_cases/fetch_local_news_post_use_case.dart';
import 'package:flutter/material.dart';

class LocalNewsViewModel extends ChangeNotifier {
  final FetchLocalNewsPostUseCase _fetchLocalNewsPostUseCase;

  LocalNewsViewModel({
    required FetchLocalNewsPostUseCase fetchLocalNewsPostUseCase,
  }) : _fetchLocalNewsPostUseCase = fetchLocalNewsPostUseCase;

  Future<Result<List<NewsPost>?>> fetchLocalPostsNews({
    required int pageSize,
    required bool fromCache,
    required String country,
  }) => _fetchLocalNewsPostUseCase.fetchLocalNewsPostsNews(
        pageSize: pageSize,
        fromCache: fromCache,
        country: country,
      );
}
