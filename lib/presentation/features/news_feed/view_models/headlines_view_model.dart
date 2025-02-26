import 'dart:collection';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/use_cases/fetch_for_you_post_use_case.dart';
import 'package:akropolis/domain/use_cases/fetch_highlights_post_use_case.dart';
import 'package:flutter/material.dart';

class HeadlinesViewModel extends ChangeNotifier {
  final FetchHeadlinesPostUseCase _fetchHeadlinesPostUseCase;

  HeadlinesViewModel({
    required FetchHeadlinesPostUseCase fetchHeadlinesPostUseCase,
  }) : _fetchHeadlinesPostUseCase = fetchHeadlinesPostUseCase;

  Future<Result<List<NewsPost>?>> fetchHeadlinesPostsNews({
    required int pageSize,
    required bool fromCache,
  }) => _fetchHeadlinesPostUseCase.fetchHeadlinesPostsNews(
        pageSize: pageSize,
        fromCache: fromCache,
      );
}
