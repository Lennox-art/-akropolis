import 'dart:collection';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/models/news_card_model.dart';
import 'package:akropolis/domain/use_cases/fetch_for_you_post_use_case.dart';
import 'package:akropolis/domain/use_cases/news_card_use_case.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:flutter/material.dart';

class ForYouViewModel extends ChangeNotifier {
  final FetchForYouPostUseCase _fetchForYouPostUseCase;
  final NewsCardUseCase _newsCardUseCase;
  final LinkedHashSet<NewsCardPostModel> _postCache = LinkedHashSet();


  UnmodifiableListView<NewsCardPostModel> get list => UnmodifiableListView(_postCache);

  ForYouViewModel({
    required FetchForYouPostUseCase fetchForYouPostUseCase,
    required NewsCardUseCase newsCardUseCase,
  })  : _fetchForYouPostUseCase = fetchForYouPostUseCase,
        _newsCardUseCase = newsCardUseCase;



  Future<Result<List<NewsCardPostModel>?>> fetchForYouPostsNews({
    required int pageSize,
    required bool fromCache,
  }) async {
    Result<List<NewsPost>?> newsResults = await _fetchForYouPostUseCase.fetchForYouPostsNews(
      pageSize: pageSize,
      fromCache: fromCache,
    );

    switch (newsResults) {
      case Success<List<NewsPost>?>():
        List<NewsCardPostModel> newsPosts = await _newsCardUseCase.resolveNewsPosts(
          post: newsResults.data ?? [],
          channel: NewsChannel.userPosts,
        );
        notifyListeners();
        _postCache.addAll(newsPosts);
        return Result.success(data: newsPosts);
      case Error<List<NewsPost>?>():
        return Result.error(failure: newsResults.failure);
    }
  }
}
