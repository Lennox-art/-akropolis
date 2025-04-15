import 'dart:collection';

import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/post_repository/post_repository.dart';
import 'package:akropolis/presentation/features/search/model/search_model.dart';
import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  final PostRepository _postRepository;
  final LinkedHashSet<NewsPost> _searchedPosts = LinkedHashSet();
  SearchCategory? _category = SearchCategory.empathetic;
  SearchState _state = const LoadedSearchState();

  SearchViewModel({
    required PostRepository postRepository,
  }) : _postRepository = postRepository;

  SearchCategory? get currentCategory => _category;

  List<SearchCategory> get categories => UnmodifiableListView(SearchCategory.values);

  List<NewsPost> get searchedPosts => UnmodifiableListView(_searchedPosts);

  SearchState get state => _state;

  void selectCategory(SearchCategory category) {
    if (category == _category) return;

    try {
      _state = const LoadingSearchState();
      _category = category;
      _searchedPosts.clear();
      notifyListeners();



      switch (category) {
        case SearchCategory.trending:
          _searchTrending();
          break;
        case SearchCategory.logical:
          _searchLogical();
          break;
        case SearchCategory.empathetic:
          _searchEmpathetic();
          break;
        case SearchCategory.opposingViews:
          _searchOpposingViews();
          break;
      }
    } finally {
      _state = const LoadedSearchState();
      notifyListeners();
    }
  }

  void _searchTrending() {

  }

  void _searchLogical() {}

  void _searchEmpathetic() {}

  void _searchOpposingViews() {}
}
