import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/use_cases/fetch_post_comments_use_case.dart';
import 'package:akropolis/domain/use_cases/post_reply_use_case.dart';
import 'package:akropolis/domain/utils/functions.dart';
import 'package:akropolis/presentation/features/create_post/models/create_post_models.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' as io;

class NewsDetailPostViewModel extends ChangeNotifier {
  final NewsPost _newsPost;
  final AppUser _currentUser;
  final NewsChannel _newsChannel;
  final PostReplyUseCase _postReplyUseCase;
  final FetchPostCommentsUseCase _fetchPostCommentsUseCase;
  final StreamController<ToastMessage> _toastMessageStream = StreamController.broadcast();
  final StreamController<CreatePostState> _createPostStream = StreamController.broadcast();
  final StreamController<PostComment> _postCommentStream = StreamController.broadcast();
  int? _commentCount;
  io.File? _videoData;
  Uint8List? _thumbnailData;
  CreatePostState _createPostState = const LoadedCreatePostState();

  NewsDetailPostViewModel({
    required NewsPost newsPost,
    required AppUser currentUser,
    required NewsChannel newsChannel,
    required PostReplyUseCase postReplyUseCase,
    required FetchPostCommentsUseCase fetchPostCommentsUseCase,
  })  : _newsPost = newsPost,
        _currentUser = currentUser,
        _newsChannel = newsChannel,
        _postReplyUseCase = postReplyUseCase,
        _fetchPostCommentsUseCase = fetchPostCommentsUseCase {
    _countComments();
  }

  Stream<ToastMessage> get toastStream => _toastMessageStream.stream;

  Stream<CreatePostState> get createPostStream => _createPostStream.stream;

  Stream<PostComment> get postCommentStream => _postCommentStream.stream;

  int? get commentCount => _commentCount;

  Uint8List? get thumbnailData => _thumbnailData;

  io.File? get videoData => _videoData;

  CreatePostState get createPostState => _createPostState;

  NewsPost get newsPost => _newsPost;

  AppUser get currentUser => _currentUser;

  Future<void> setVideo(io.File file) async {
    _videoData = file;
    _thumbnailData = await generateThumbnail(
      videoPath: file.path,
    );
    notifyListeners();
  }

  Future<void> trimVideo({
    required Duration startTime,
    required Duration endTime,
  }) async {
    if (_videoData == null) return;

    var trimmedVideo = await trimVideoInRange(
      file: videoData!,
      start: startTime,
      end: endTime,
    );

    if (trimmedVideo == null) return;
    _videoData = trimmedVideo as File?;
  }

  Future<void> modifyThumbnail({
    required int timeInSeconds,
  }) async {
    if (_videoData == null) return;

    Uint8List? thumbnailData = await generateThumbnail(
      videoPath: videoData!.path,
      timeInSeconds: timeInSeconds,
    );
    if (thumbnailData == null) return;
    _thumbnailData = thumbnailData;
  }

  Future<void> doPost() async {
    if (_createPostState is LoadingCreatePostState) return;
    if (_thumbnailData == null) return;
    if (_videoData == null) return;

    _createPostState = const LoadingCreatePostState();
    notifyListeners();

    try {
      Result<PostComment> postCommentResult = await _postReplyUseCase.post(
        thumbnailData: _thumbnailData!,
        videoData: await _videoData!.readAsBytes(),
        collection: _newsChannel.collection,
        postId: _newsPost.id,
      );

      switch (postCommentResult) {
        case Success<PostComment>():
          _videoData = null;
          _thumbnailData = null;
          _postCommentStream.add(postCommentResult.data);
          _toastMessageStream.add(
            const ToastSuccess(title: "Comment posted completed", message: "Comment posted successfully"),
          );
          _countComments();
          break;

        case Error<PostComment>():
          _toastMessageStream.add(
            ToastError(title: "Comment upload", message: postCommentResult.failure.message),
          );
          break;
      }
    } finally {
      _createPostState = const LoadedCreatePostState();
      notifyListeners();
    }
  }

  Future<Result<List<PostComment>?>> fetchPostComments({
    required int pageSize,
    required bool fromCache,
  }) {
    return _fetchPostCommentsUseCase.fetchPostComments(
      postCollection: _newsChannel.collection,
      postId: _newsPost.id,
      pageSize: pageSize,
      fromCache: fromCache,
    );
  }

  Future<void> _countComments() async {
    Result<int> commentCountResult = await _fetchPostCommentsUseCase.countPostComments(
      postCollection: _newsChannel.collection,
      postId: _newsPost.id,
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
