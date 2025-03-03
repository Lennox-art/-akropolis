import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/post_repository/post_repository.dart';
import 'package:akropolis/domain/models/news_card_model.dart';
import 'package:akropolis/domain/use_cases/fetch_post_comments_use_case.dart';
import 'package:akropolis/domain/use_cases/get_media_use_case.dart';
import 'package:akropolis/domain/use_cases/news_card_use_case.dart';
import 'package:akropolis/domain/use_cases/post_reply_use_case.dart';
import 'package:akropolis/domain/utils/functions.dart';
import 'package:akropolis/presentation/features/create_post/models/create_post_models.dart';
import 'package:akropolis/presentation/features/news_feed/models/media_download_state.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' as io;

class NewsDetailPostViewModel extends ChangeNotifier {
  late final NewsCardPostModel newsPost;
  late final AppUser currentUser;
  final NewsCardUseCase _newsCardUseCase;
  final GetMediaUseCase _getMediaUseCase;
  final PostRepository _postRepository;
  final FetchPostCommentsUseCase _fetchPostCommentsUseCase;
  final StreamController<ToastMessage> _toastMessageStream = StreamController.broadcast();
  final StreamController<CreatePostState> _createPostStream = StreamController.broadcast();
  MediaDownloadState _thumbnailMediaState = const InitialMediaState();
  MediaDownloadState _postMediaState = const InitialMediaState();

  NewsDetailPostViewModel({
    required NewsPostDto newsPostDto,
    required NewsCardUseCase newsCardUseCase,
    required PostRepository postRepository,
    required GetMediaUseCase getMediaUseCase,
    required FetchPostCommentsUseCase fetchPostCommentsUseCase,
  })  : _fetchPostCommentsUseCase = fetchPostCommentsUseCase,
        _newsCardUseCase = newsCardUseCase,
        _getMediaUseCase = getMediaUseCase,
        _postRepository = postRepository,
        newsPost = newsPostDto.newsPost,
        currentUser = newsPostDto.currentUser;

  Stream<ToastMessage> get toastStream => _toastMessageStream.stream;

  Stream<CreatePostState> get createPostStream => _createPostStream.stream;

  MediaDownloadState get postMediaState => _postMediaState;

  MediaDownloadState get thumbnailMediaState => _thumbnailMediaState;

  bool get alreadyReacted => isLogReaction || isEmpReaction;

  bool get isLogReaction => newsPost.newsPost.reaction.log.contains(currentUser.id);

  bool get isEmpReaction => newsPost.newsPost.reaction.emp.contains(currentUser.id);

  ReactionDistribution get distribution => ReactionDistribution(newsPost.newsPost.reaction);

  void downloadThumbnail() async {
    if (_thumbnailMediaState is! InitialMediaState && _thumbnailMediaState is! ErrorDownloadMediaState) return;

    if (newsPost.thumbnail is Success<Result<MapEntry<String, MediaData>>>) {
      Success<MapEntry<String, MediaData>> result = newsPost.thumbnail as Success<MapEntry<String, MediaData>>;
      _thumbnailMediaState = DownloadedMediaState(media: result.data.value);
      notifyListeners();
      return;
    }

    _thumbnailMediaState = const DownloadingMediaState();
    notifyListeners();

    Result<MapEntry<String, MediaData>> thumbnailResult = await _getMediaUseCase.getMediaFromUrl(
      newsPost.newsPost.thumbnailUrl,
      onProgress: (p) {
        _thumbnailMediaState = DownloadingMediaState(progress: p);
        notifyListeners();
      },
    );

    print("Thumbnail result = $thumbnailResult");

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
      newsPost.newsPost.postUrl,
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

    newsPost.newsPost.reaction.log.add(currentUser.id);
    notifyListeners();

    Result<void> addViewerResult = await _postRepository.addUserToPostLogicianReaction(
      postId: newsPost.newsPost.id,
      collection: newsPost.newsChannel.collection,
      userId: currentUser.id,
    );

    switch (addViewerResult) {
      case Success<void>():
        break;
      case Error<void>():
        newsPost.newsPost.reaction.log.remove(currentUser.id);
        notifyListeners();
        break;
    }
  }

  Future<void> emp() async {
    if (alreadyReacted) return;

    newsPost.newsPost.reaction.emp.add(currentUser.id);
    notifyListeners();

    Result<void> addViewerResult = await _postRepository.addUserToPostEmpathyReaction(
      postId: newsPost.newsPost.id,
      collection: newsPost.newsChannel.collection,
      userId: currentUser.id,
    );

    switch (addViewerResult) {
      case Success<void>():
        break;
      case Error<void>():
        newsPost.newsPost.reaction.emp.remove(currentUser.id);
        notifyListeners();
        break;
    }
  }

  Future<Result<List<NewsCardCommentModel>?>> fetchPostComments({
    required String postCollection,
    required String postId,
    required int pageSize,
    required bool fromCache,
  }) async {
    Result<List<PostComment>?> fetchCommentResult = await _fetchPostCommentsUseCase.fetchPostComments(
      postCollection: postCollection,
      postId: postId,
      pageSize: pageSize,
      fromCache: fromCache,
    );

    switch (fetchCommentResult) {
      case Success<List<PostComment>?>():
        List<PostComment>? retrievedComments = fetchCommentResult.data;
        if (retrievedComments == null) return const Result.success(data: null);

        List<NewsCardCommentModel> commentModels = await _newsCardUseCase.resolveNewsPostComments(
          retrievedComments,
        );

        return Result.success(data: commentModels);

      case Error<List<PostComment>?>():
        return Result.error(failure: fetchCommentResult.failure);
    }
  }
}
