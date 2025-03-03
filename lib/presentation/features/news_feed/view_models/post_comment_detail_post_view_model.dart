import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/post_repository/post_repository.dart';
import 'package:akropolis/domain/models/news_card_model.dart';
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

class PostCommentDetailViewModel extends ChangeNotifier {
  final GetMediaUseCase _getMediaUseCase;
  final PostRepository _postRepository;
  final NewsCardPostModel newsPost;
  final AppUser currentUser;
  final NewsCardCommentModel _comment;
  final StreamController<ToastMessage> _toastMessageStream = StreamController.broadcast();
  final StreamController<CreatePostState> _createPostStream = StreamController.broadcast();
  final StreamController<PostComment> _postCommentStream = StreamController.broadcast();
  MediaDownloadState _thumbnailMediaState = const InitialMediaState();
  MediaDownloadState _postMediaState = const InitialMediaState();

  PostCommentDetailViewModel({
    required PostRepository postRepository,
    required GetMediaUseCase getMediaUseCase,
    required NewsPostCommentDto newsPostCommentDto,
    required FetchPostCommentsUseCase fetchPostCommentsUseCase,
  })  : _getMediaUseCase = getMediaUseCase,
        _postRepository = postRepository,
        currentUser = newsPostCommentDto.currentUser,
        _comment = newsPostCommentDto.comment,
        newsPost = newsPostCommentDto.newsPost;

  Stream<ToastMessage> get toastStream => _toastMessageStream.stream;

  Stream<CreatePostState> get createPostStream => _createPostStream.stream;

  Stream<PostComment> get postCommentStream => _postCommentStream.stream;

  MediaDownloadState get postMediaState => _postMediaState;

  MediaDownloadState get thumbnailMediaState => _thumbnailMediaState;

  PostComment get comment => _comment.postComment;

  bool get alreadyReacted => isLogReaction || isEmpReaction;

  bool get isLogReaction => comment.reaction.log.contains(currentUser.id);

  bool get isEmpReaction => comment.reaction.emp.contains(currentUser.id);

  ReactionDistribution get distribution => ReactionDistribution(comment.reaction);

  void downloadThumbnail() async {
    if (_thumbnailMediaState is! InitialMediaState && _thumbnailMediaState is! ErrorDownloadMediaState) return;

    if (_comment.thumbnail is Success<Result<MapEntry<String, MediaData>>>) {
      Success<MapEntry<String, MediaData>> result = _comment.thumbnail as Success<MapEntry<String, MediaData>>;
      _thumbnailMediaState = DownloadedMediaState(media: result.data.value);
      notifyListeners();
      return;
    }

    _thumbnailMediaState = const DownloadingMediaState();
    notifyListeners();

    Result<MapEntry<String, MediaData>> thumbnailResult = await _getMediaUseCase.getMediaFromUrl(
      comment.thumbnailUrl,
      onProgress: (p) {
        _thumbnailMediaState = DownloadingMediaState(progress: p);
        notifyListeners();
      },
    );

    switch (thumbnailResult) {
      case Success<MapEntry<String, MediaData>>():
        _thumbnailMediaState = DownloadedMediaState(media: thumbnailResult.data.value);
        notifyListeners();
        break;
      case Error<MapEntry<String, MediaData>>():
        _thumbnailMediaState = ErrorDownloadMediaState(failure: thumbnailResult.failure);
        notifyListeners();
        break;
    }
  }

  void downloadPost() async {
    if (_postMediaState is! InitialMediaState && _postMediaState is! ErrorDownloadMediaState) return;

    _postMediaState = const DownloadingMediaState();
    notifyListeners();

    Result<MapEntry<String, MediaData>> thumbnailResult = await _getMediaUseCase.getMediaFromUrl(
      comment.postUrl,
      onProgress: (p) {
        _postMediaState = DownloadingMediaState(progress: p);
        notifyListeners();
      },
    );

    switch (thumbnailResult) {
      case Success<MapEntry<String, MediaData>>():
        _postMediaState = DownloadedMediaState(media: thumbnailResult.data.value);
        notifyListeners();
        break;
      case Error<MapEntry<String, MediaData>>():
        _postMediaState = ErrorDownloadMediaState(failure: thumbnailResult.failure);
        notifyListeners();
        break;
    }
  }

  Future<void> log() async {
    if (alreadyReacted) return;

    _comment.postComment.reaction.log.add(currentUser.id);
    notifyListeners();

    Result<void> addViewerResult = await _postRepository.addUserToPostCommentLogicianReaction(
      postId: newsPost.newsPost.id,
      commentId: comment.id,
      collection: newsPost.newsChannel.collection,
      userId: currentUser.id,
    );

    switch (addViewerResult) {
      case Success<void>():
        break;
      case Error<void>():
        _comment.postComment.reaction.log.remove(currentUser.id);
        notifyListeners();
        break;
    }
  }

  Future<void> emp() async {
    if (alreadyReacted) return;

    _comment.postComment.reaction.emp.add(currentUser.id);
    notifyListeners();

    Result<void> addViewerResult = await _postRepository.addUserToPostCommentEmpathyReaction(
      postId: newsPost.newsPost.id,
      commentId: comment.id,
      collection: newsPost.newsChannel.collection,
      userId: currentUser.id,
    );

    switch (addViewerResult) {
      case Success<void>():
        break;
      case Error<void>():
        _comment.postComment.reaction.emp.remove(currentUser.id);
        notifyListeners();
        break;
    }
  }

}
