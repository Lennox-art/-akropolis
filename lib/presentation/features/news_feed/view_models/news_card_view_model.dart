import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/post_repository/post_repository.dart';
import 'package:akropolis/domain/use_cases/fetch_post_comments_use_case.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:flutter/cupertino.dart';

class NewsCardViewModel extends ChangeNotifier {
  final NewsPost _newsPost;
  final NewsChannel _newsChannel;
  final AppUser _appUser;
  final PostRepository _postRepository;
  final FetchPostCommentsUseCase _fetchPostCommentsUseCase;
  int? _commentsCount;
  bool _loadingComments = false;

  NewsCardViewModel({
    required NewsPost newsPost,
    required NewsChannel newsChannel,
    required AppUser appUser,
    required PostRepository postRepository,
    required FetchPostCommentsUseCase fetchPostCommentsUseCase,
  })  : _newsPost = newsPost,
        _appUser = appUser,
        _newsChannel = newsChannel,
        _fetchPostCommentsUseCase = fetchPostCommentsUseCase,
        _postRepository = postRepository {
    _addUserToViewers();
    _getCommentsCount();
  }

  int? get commentsCount => _commentsCount;

  bool get loadingComments => _loadingComments;

  NewsPost get newsPost => _newsPost;

  NewsChannel get newsChannel => _newsChannel;

  AppUser get currentUser => _appUser;

  Future<void> _addUserToViewers() async {
    if (_newsPost.viewers.contains(_appUser.id)) return;

    Result<void> addViewerResult = await _postRepository.addUserToPostViewers(
      postId: _newsPost.id,
      collection: _newsChannel.collection,
      userId: _appUser.id,
    );

    switch (addViewerResult) {
      case Success<void>():
        break;
      case Error<void>():
        break;
    }
  }

  Future<void> _getCommentsCount() async {
    if (_commentsCount != null) return;

    _loadingComments = true;
    notifyListeners();

    try {
      Result<int> countCommentsResult = await _fetchPostCommentsUseCase.countPostComments(
        postId: _newsPost.id,
        postCollection: _newsChannel.collection,
        fromCache: true,
      );

      switch (countCommentsResult) {
        case Success<int>():
          _commentsCount = countCommentsResult.data;
          break;
        case Error<int>():
          break;
      }
    } finally {
      _loadingComments = false;
      notifyListeners();
    }
  }
}
