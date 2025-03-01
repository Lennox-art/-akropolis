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

class PostCommentDetailtViewModel extends ChangeNotifier {
  final GetMediaUseCase _getMediaUseCase;
  final NewsPost newsPost;
  final NewsChannel newsChannel;
  final AppUser currentUser;
  final PostComment comment;
  final StreamController<ToastMessage> _toastMessageStream = StreamController.broadcast();
  final StreamController<CreatePostState> _createPostStream = StreamController.broadcast();
  final StreamController<PostComment> _postCommentStream = StreamController.broadcast();
  MediaDownloadState _thumbnailMediaState = const InitialMediaState();
  MediaDownloadState _postMediaState = const InitialMediaState();

  PostCommentDetailtViewModel({
    required GetMediaUseCase getMediaUseCase,
    required NewsPostCommentDto newsPostCommentDto,
    required FetchPostCommentsUseCase fetchPostCommentsUseCase,
  })  : _getMediaUseCase = getMediaUseCase,
        newsChannel = newsPostCommentDto.channel,
        currentUser = newsPostCommentDto.currentUser,
        comment = newsPostCommentDto.comment,
        newsPost = newsPostCommentDto.newsPost;

  Stream<ToastMessage> get toastStream => _toastMessageStream.stream;

  Stream<CreatePostState> get createPostStream => _createPostStream.stream;

  Stream<PostComment> get postCommentStream => _postCommentStream.stream;

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
    if (_postMediaState is! InitialMediaState || _postMediaState is! ErrorDownloadMediaState) return;

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
}
