import 'dart:async';
import 'dart:collection';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/bookmark_repository/bookmark_repository.dart';
import 'package:akropolis/data/repositories/post_repository/post_repository.dart';
import 'package:akropolis/presentation/features/bookmarked/model/bookmarked_state.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/material.dart';

class BookmarkedViewModel extends ChangeNotifier {
  final BookmarkRepository _bookmarkRepository;
  final PostRepository _postRepository;
  final SplayTreeSet<Bookmark> _bookmarkSet = SplayTreeSet();
  final Map<String, NewsPost> _bookmarkPosts = HashMap();
  final StreamController<ToastMessage> _toastStream = StreamController.broadcast();
  final AppUser _currentUser;
  BookmarkedState _bookmarkState = const LoadedBookmarkedState();
  ResolveBookmarkedState _resolveBookmarkState = const LoadedResolveBookmarkedState();

  BookmarkedViewModel({
    required BookmarkRepository bookmarkRepository,
    required PostRepository postRepository,
    required AppUser currentUser,
  })  : _bookmarkRepository = bookmarkRepository,
        _postRepository = postRepository,
        _currentUser = currentUser;

  List<Bookmark> get bookmarkList => UnmodifiableListView(_bookmarkSet);

  Stream<ToastMessage> get toastStream => _toastStream.stream;

  BookmarkedState get state => _bookmarkState;

  ResolveBookmarkedState get resolveBookmarkState => _resolveBookmarkState;

  NewsPost? getPost({required String postId}) => _bookmarkPosts[postId];

  Future<void> loadMoreItems() async {
    if (_bookmarkState is! LoadedBookmarkedState) return;

    try {
      _bookmarkState = const LoadingBookmarkedState();
      notifyListeners();

      Result<List<Bookmark>> bookmarkResult = await _bookmarkRepository.fetchBookmarks(
        userId: _currentUser.id,
        pageSize: 20,
        lastFetchedCreatedAt: _bookmarkSet.lastOrNull?.createdAt,
      );

      switch (bookmarkResult) {
        case Success<List<Bookmark>>():
          _bookmarkSet.addAll(bookmarkResult.data);
          fetchBookmarkPosts();
          break;
        case Error<List<Bookmark>>():
          _toastStream.add(ToastError(message: bookmarkResult.failure.message));
          break;
      }
    } finally {
      _bookmarkState = const LoadedBookmarkedState();
      notifyListeners();
    }
  }

  Future<void> removeBookmark({
    required String postId,
  }) async {
    if (_bookmarkState is! LoadedBookmarkedState) return;

    try {
      _bookmarkState = const LoadingBookmarkedState();
      notifyListeners();

      Result<void> bookmarkResult = await _bookmarkRepository.removeBookmarks(
        userId: _currentUser.id,
        postId: postId,
      );

      switch (bookmarkResult) {
        case Success<void>():
          _bookmarkSet.removeWhere((b) => b.postId == postId);
          break;
        case Error<void>():
          _toastStream.add(ToastError(message: bookmarkResult.failure.message));
          break;
      }
    } finally {
      _bookmarkState = const LoadedBookmarkedState();
      notifyListeners();
    }
  }

  Future<void> fetchBookmarkPosts() async {
    if (_resolveBookmarkState is! LoadedResolveBookmarkedState) return;

    Map<String, NewsChannel> ids = {
      for (var b in _bookmarkSet.where((e) => !_bookmarkPosts.containsKey(e.postId))) b.postId: b.channel,
    };
    if(ids.isEmpty) return;

    try {
      _resolveBookmarkState = const LoadingResolveBookmarkedState();
      notifyListeners();

      Result<List<NewsPost>> postResult = await _postRepository.fetchPostsWithIds(ids: ids);

      switch (postResult) {
        case Success<List<NewsPost>>():
          _bookmarkPosts.addAll({for(var p in postResult.data) p.id : p});
          break;
        case Error<List<NewsPost>>():
          _toastStream.add(ToastError(message: postResult.failure.message));
          break;
      }
    } finally {
      _resolveBookmarkState = const LoadedResolveBookmarkedState();
      notifyListeners();
    }
  }
}
