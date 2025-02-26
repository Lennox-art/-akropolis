import 'dart:collection';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/use_cases/fetch_for_you_post_use_case.dart';
import 'package:akropolis/domain/use_cases/fetch_highlights_post_use_case.dart';
import 'package:akropolis/domain/use_cases/fetch_World_news_post_use_case.dart';
import 'package:flutter/material.dart';

class WorldNewsViewModel extends ChangeNotifier {
  final FetchWorldNewsPostUseCase _fetchWorldNewsPostUseCase;

  WorldNewsViewModel({
    required FetchWorldNewsPostUseCase fetchWorldNewsPostUseCase,
  }) : _fetchWorldNewsPostUseCase = fetchWorldNewsPostUseCase;

  Future<Result<List<NewsPost>?>> fetchWorldPostsNews({
    required int pageSize,
    required bool fromCache,
    String? country,
  }) => _fetchWorldNewsPostUseCase.fetchWorldNewsPostsNews(
        pageSize: pageSize,
        fromCache: fromCache,
        country: country,
      );
}
