import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/use_cases/fetch_post_comments_use_case.dart';
import 'package:akropolis/domain/use_cases/get_media_use_case.dart';
import 'package:akropolis/domain/use_cases/post_reply_use_case.dart';
import 'package:akropolis/domain/utils/functions.dart';
import 'package:akropolis/presentation/features/create_post/models/create_post_models.dart';
import 'package:akropolis/presentation/features/news_feed/models/media_download_state.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' as io;

class NewsDetailPostViewModel extends ChangeNotifier {
  late final NewsPost newsPost;
  late final NewsChannel newsChannel;
  late final AppUser currentUser;
  final GetMediaUseCase _getMediaUseCase;
  final FetchPostCommentsUseCase _fetchPostCommentsUseCase;
  final StreamController<ToastMessage> _toastMessageStream = StreamController.broadcast();
  final StreamController<CreatePostState> _createPostStream = StreamController.broadcast();
  final StreamController<PostComment> _postCommentStream = StreamController.broadcast();
  MediaDownloadState _thumbnailMediaState = const InitialMediaState();
  MediaDownloadState _postMediaState = const InitialMediaState();
  int? _commentCount;

  NewsDetailPostViewModel({
    required NewsPostDto newsPostDto,
    required GetMediaUseCase getMediaUseCase,
    required FetchPostCommentsUseCase fetchPostCommentsUseCase,
  })  : _fetchPostCommentsUseCase = fetchPostCommentsUseCase,
        _getMediaUseCase = getMediaUseCase,
        newsPost = newsPostDto.newsPost,
        newsChannel = newsPostDto.channel,
        currentUser = newsPostDto.currentUser;

  Stream<ToastMessage> get toastStream => _toastMessageStream.stream;

  Stream<CreatePostState> get createPostStream => _createPostStream.stream;

  Stream<PostComment> get postCommentStream => _postCommentStream.stream;

  int? get commentCount => _commentCount;

  MediaDownloadState get postMediaState => _postMediaState;

  MediaDownloadState get thumbnailMediaState => _thumbnailMediaState;

  void downloadThumbnail(String url) async {
    if (_thumbnailMediaState is! InitialMediaState && _thumbnailMediaState is! ErrorDownloadMediaState) return;

    _thumbnailMediaState = const DownloadingMediaState();
    notifyListeners();

    Result<MediaData> thumbnailResult = await _getMediaUseCase.getMediaFromUrl(
      url,
      onProgress: (p) {
        _thumbnailMediaState = DownloadingMediaState(progress: p);
        notifyListeners();
      },
    );

    print("Thumbnail result = $thumbnailResult");

    switch (thumbnailResult) {
      case Success<MediaData>():
        _thumbnailMediaState = DownloadedMediaState(media: thumbnailResult.data);
        notifyListeners();
        break;
      case Error<MediaData>():
        _thumbnailMediaState = ErrorDownloadMediaState(failure: thumbnailResult.failure);
        notifyListeners();
        break;
    }
  }

  void downloadPost(String url) async {
    if (_postMediaState is! InitialMediaState && _postMediaState is! ErrorDownloadMediaState) return;

    _postMediaState = const DownloadingMediaState();
    notifyListeners();

    Result<MediaData> thumbnailResult = await _getMediaUseCase.getMediaFromUrl(
      url,
      onProgress: (p) {
        _postMediaState = DownloadingMediaState(progress: p);
        notifyListeners();
      },
    );

    switch (thumbnailResult) {
      case Success<MediaData>():
        _postMediaState = DownloadedMediaState(media: thumbnailResult.data);
        notifyListeners();
        break;
      case Error<MediaData>():
        _postMediaState = ErrorDownloadMediaState(failure: thumbnailResult.failure);
        notifyListeners();
        break;
    }
  }

  Future<Result<List<PostComment>?>> fetchPostComments({
    required String postCollection,
    required String postId,
    required int pageSize,
    required bool fromCache,
  }) {
    return _fetchPostCommentsUseCase.fetchPostComments(
      postCollection: postCollection,
      postId: postId,
      pageSize: pageSize,
      fromCache: fromCache,
    );
  }

  Future<void> countComments({
    required String postCollection,
    required String postId,
  }) async {
    Result<int> commentCountResult = await _fetchPostCommentsUseCase.countPostComments(
      postCollection: postCollection,
      postId: postId,
      fromCache: true,
    );

    switch (commentCountResult) {
      case Success<int>():
        _commentCount = commentCountResult.data;
        notifyListeners();
        break;
      case Error<int>():
        _toastMessageStream.add(
          ToastError(title: "Comment count", message: commentCountResult.failure.message),
        );
        break;
    }
  }
}
