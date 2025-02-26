import 'dart:collection';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/use_cases/fetch_for_you_post_use_case.dart';
import 'package:flutter/material.dart';

class ForYouViewModel extends ChangeNotifier {
  final FetchForYouPostUseCase _fetchForYouPostUseCase;

  ForYouViewModel({
    required FetchForYouPostUseCase fetchForYouPostUseCase,
  }) : _fetchForYouPostUseCase = fetchForYouPostUseCase;

  Future<Result<List<NewsPost>?>> fetchForYouPostsNews({
    required int pageSize,
    required bool fromCache,
  }) =>
      _fetchForYouPostUseCase.fetchForYouPostsNews(pageSize: pageSize, fromCache: fromCache);
}
