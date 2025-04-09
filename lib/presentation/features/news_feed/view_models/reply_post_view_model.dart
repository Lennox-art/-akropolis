import 'dart:async';
import 'dart:io' as io;

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/utils/validations.dart';
import 'package:akropolis/domain/models/news_card_model.dart';
import 'package:akropolis/domain/use_cases/post_reply_use_case.dart';
import 'package:akropolis/domain/utils/functions.dart';
import 'package:akropolis/presentation/features/create_post/models/create_post_models.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:akropolis/presentation/features/news_feed/models/reply_post_state.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/foundation.dart';

class ReplyPostViewModel extends ChangeNotifier {
  final PostReplyUseCase _postReplyUseCase;
  final StreamController<ToastMessage> _toastMessageStream = StreamController.broadcast();
  final StreamController<ReplyPostState> _replyPostStream = StreamController.broadcast();
  VideoEditingTools _currentTool = VideoEditingTools.thumbnailPicker;
  ReplyPostState _replyPostState = const IdlePostState();
  io.File _videoData;
  Uint8List? _selectedThumbnail;
  List<Uint8List>? _videoThumbnails;
  final NewsCardPostModel _newsPost;

  ReplyPostViewModel({
    required NewsPostReplyDto newsPostReplyDto,
    required PostReplyUseCase postReplyUseCase,
  })  : _postReplyUseCase = postReplyUseCase,
        _newsPost = newsPostReplyDto.newsPost,
        _videoData = newsPostReplyDto.commentVideo {
    setVideo(file: _videoData);
  }

  Stream<ToastMessage> get toastStream => _toastMessageStream.stream;

  Stream<ReplyPostState> get replyPostStream => _replyPostStream.stream;

  VideoEditingTools get currentTool => _currentTool;

  ReplyPostState get replyPostState => _replyPostState;

  void changeCurrentTool(VideoEditingTools tool) {
    _currentTool = tool;
    _replyPostState = ReplyPostState.editingVideo(
      video: _videoData,
      selectedThumbnail: _selectedThumbnail!,
      videoThumbnails: _videoThumbnails!,
      currentTool: _currentTool,
    );
    notifyListeners();
  }

  Future<void> setVideo({required io.File file}) async {
    String? videoError = await validateVideo(file.path);
    if (videoError != null) {
      _toastMessageStream.add(ToastError(title: "Post Video", message: videoError));
      return;
    }

    _replyPostState = const LoadingReplyPostState();
    notifyListeners();

    try {
      Result<List<Uint8List>> thumbnailResult = await generateThumbnails(
        GenerateThumbnailsRequest(
          videoPath: file.path,
          count: 8,
        ),
      );

      switch (thumbnailResult) {
        case Success<List<Uint8List>>():
          _videoData = file;
          _videoThumbnails = thumbnailResult.data;
          _selectedThumbnail = thumbnailResult.data.first;

          _replyPostState = EdittingVideoReplyPostState(
            video: _videoData,
            videoThumbnails: _videoThumbnails!,
            selectedThumbnail: _selectedThumbnail!,
            currentTool: currentTool,
          );
          break;

        case Error<List<Uint8List>>():
          _replyPostState = ErrorReplyPostState(failure: thumbnailResult.failure);
          break;
      }
    } finally {
      _replyPostStream.add(_replyPostState);
      notifyListeners();
    }
  }

  Future<void> trimVideo({required Duration startTime, required Duration endTime}) async {
    if (_replyPostState is! EdittingVideoReplyPostState) return;

    try {
      _replyPostState = const LoadingReplyPostState();
      notifyListeners();

      Result<io.File> trimmedVideoResult = await trimVideoInRange(
        TrimVideoRequest(
          file: _videoData,
          start: startTime,
          end: endTime,
        ),
      );

      switch (trimmedVideoResult) {
        case Success<io.File>():
          Result<List<Uint8List>> thumbnailResult = await generateThumbnails(
            GenerateThumbnailsRequest(
              videoPath: trimmedVideoResult.data.path,
              count: 8,
            ),
          );

          switch (thumbnailResult) {
            case Success<List<Uint8List>>():
              _videoData = trimmedVideoResult.data;
              _replyPostState = EdittingVideoReplyPostState(
                video: _videoData,
                videoThumbnails: _videoThumbnails!,
                selectedThumbnail: _selectedThumbnail!,
                currentTool: _currentTool,
              );
              break;
            case Error<List<Uint8List>>():
              _toastMessageStream.add(
                ToastSuccess(message: thumbnailResult.failure.message),
              );
              break;
          }

          break;
        case Error<io.File>():
          _toastMessageStream.add(
            ToastSuccess(message: trimmedVideoResult.failure.message),
          );
          break;
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> modifyThumbnail(Uint8List thumbnail) async {
    if (_replyPostState is! EdittingVideoReplyPostState) return;

    print("Modifying thumbnail");

    _selectedThumbnail = thumbnail;
    _replyPostState = EdittingVideoReplyPostState(
      video: _videoData,
      selectedThumbnail: _selectedThumbnail!,
      videoThumbnails: _videoThumbnails!,
      currentTool: _currentTool,
    );
    notifyListeners();
  }

  Future<void> doPost() async {
    if (_replyPostState is! EdittingVideoReplyPostState) return;
    assert(_selectedThumbnail != null);

    try {
      Result<PostComment> newPostResult = await _postReplyUseCase.post(
        thumbnailData: _selectedThumbnail!,
        videoData: await _videoData.readAsBytes(),
        collection: _newsPost.newsChannel.collection,
        postId: _newsPost.newsPost.id,
        onProgress: (p) {
          _replyPostState = LoadingReplyPostState(progress: p);
          notifyListeners();
        },
      );

      switch (newPostResult) {
        case Success<PostComment>():
          _replyPostState = const IdlePostState();
          _toastMessageStream.add(
            const ToastSuccess(title: "Comment post", message: "Comment uploaded successfully"),
          );
          break;

        case Error<PostComment>():
          _replyPostState = EdittingVideoReplyPostState(
            video: _videoData,
            selectedThumbnail: _selectedThumbnail!,
            videoThumbnails: _videoThumbnails!,
            currentTool: _currentTool,
          );
          _toastMessageStream.add(
            ToastError(title: "Comment post", message: newPostResult.failure.message),
          );
          break;
      }
    } finally {
      _replyPostStream.add(_replyPostState);
      notifyListeners();
    }
  }

}
