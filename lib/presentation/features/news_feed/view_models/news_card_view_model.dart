import 'dart:async';
import 'dart:collection';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/post_repository/post_repository.dart';
import 'package:akropolis/domain/use_cases/fetch_post_comments_use_case.dart';
import 'package:akropolis/domain/use_cases/get_media_use_case.dart';
import 'package:akropolis/presentation/features/news_feed/models/media_download_state.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:akropolis/presentation/features/news_feed/models/news_card_replies_state.dart';
import 'package:exception_base/exception_base.dart';
import 'package:flutter/cupertino.dart';

class NewsCardViewModel extends ChangeNotifier {
  final NewsPost _newsPost;
  final NewsChannel _newsChannel;
  final AppUser _appUser;
  final PostRepository _postRepository;
  final GetMediaUseCase _getMediaUseCase;
  final FetchPostCommentsUseCase _fetchPostCommentsUseCase;
  NewsCardRepliesState _newsCardState = const InitialNewsCardRepliesState();
  Map<PostComment, MediaDownloadState>? _comments;
  int? _commentsCount;
  bool _loadingComments = false;

  NewsCardViewModel({
    required NewsPost newsPost,
    required NewsChannel newsChannel,
    required AppUser appUser,
    required PostRepository postRepository,
    required FetchPostCommentsUseCase fetchPostCommentsUseCase,
    required GetMediaUseCase getMediaUseCase,
  })  : _newsPost = newsPost,
        _appUser = appUser,
        _newsChannel = newsChannel,
        _fetchPostCommentsUseCase = fetchPostCommentsUseCase,
        _postRepository = postRepository,
        _getMediaUseCase = getMediaUseCase {
    _addUserToViewers();
    _getCommentsCount();
    fetchPostComments();
  }

  int? get commentsCount => _commentsCount;

  bool get loadingComments => _loadingComments;

  NewsPost get newsPost => _newsPost;

  NewsChannel get newsChannel => _newsChannel;

  AppUser get currentUser => _appUser;

  NewsCardRepliesState get newsCardRepliesState => _newsCardState;

  Map<PostComment, MediaDownloadState>? get commentsThumbnails => _comments;

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

  Future<void> fetchPostComments() async {
    if (_newsCardState is! ErrorNewsCardRepliesState && _newsCardState is! InitialNewsCardRepliesState) return;

    _newsCardState = const LoadingNewsCardRepliesState();
    notifyListeners();

    try {
      Result<List<PostComment>?> commentsResult = await _fetchPostCommentsUseCase.fetchPostComments(
        postCollection: _newsChannel.collection,
        postId: _newsPost.id,
        pageSize: 6,
        fromCache: true,
      );

      switch (commentsResult) {
        case Success<List<PostComment>?>():
          _newsCardState = const LoadedNewsCardRepliesState();
          _comments = {};
          _downloadCommentsThumbnails(commentsResult.data ?? []);
          break;
        case Error<List<PostComment>?>():
          _newsCardState = ErrorNewsCardRepliesState(failure: commentsResult.failure);
          break;
      }
    } catch (e, trace) {
      _newsCardState = ErrorNewsCardRepliesState(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    } finally {
      notifyListeners();
    }
  }

  void _downloadCommentsThumbnails(List<PostComment> comments) {
    for (PostComment c in comments) {
      _comments!.update(c, (_) => const InitialMediaState(), ifAbsent: () => const InitialMediaState());
      _getMediaUseCase.getMediaFromUrl(
        c.thumbnailUrl,
        onProgress: (p) {
          _comments!.update(
            c,
            (v) => DownloadingMediaState(progress: p),
            ifAbsent: () => DownloadingMediaState(progress: p),
          );
          notifyListeners();
        },
      ).then(
        (getMediaResult) {
          switch (getMediaResult) {
            case Success<MediaData>():
              _comments!.update(
                c,
                (_) => DownloadedMediaState(media: getMediaResult.data),
                ifAbsent: () => DownloadedMediaState(media: getMediaResult.data),
              );
              notifyListeners();
              break;
            case Error<MediaData>():
              _comments!.update(
                c,
                (_) => ErrorDownloadMediaState(failure: getMediaResult.failure),
                ifAbsent: () => ErrorDownloadMediaState(failure: getMediaResult.failure),
              );
              notifyListeners();
              break;
          }
        },
      );
    }
  }
}
