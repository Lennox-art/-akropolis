import 'dart:async';
import 'dart:io' as io;

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/utils/validations.dart';
import 'package:akropolis/domain/use_cases/send_message_use_case.dart';
import 'package:akropolis/domain/utils/functions.dart';
import 'package:akropolis/presentation/features/create_post/models/create_post_models.dart';
import 'package:akropolis/presentation/features/new_video_message/model/new_video_message_model.dart';
import 'package:akropolis/presentation/features/news_feed/models/reply_post_state.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/foundation.dart';

class NewVideoMessageViewModel extends ChangeNotifier {
  final SendMessageUseCase _sendMessageUseCase;
  final StreamController<ToastMessage> _toastMessageStream = StreamController.broadcast();
  VideoEditingTools _currentTool = VideoEditingTools.thumbnailPicker;
  NewVideoMessageState _newVideoState = const IdleNewVideoMessageState();
  io.File _videoData;
  Uint8List? _selectedThumbnail;
  List<Uint8List>? _videoThumbnails;
  final AppUser _sendToAppUser;
  final String? _threadId;

  NewVideoMessageViewModel({
    required NewVideoMessageData newVideoMessageData,
    required SendMessageUseCase sendMessageUseCase,
  })  : _sendMessageUseCase = sendMessageUseCase,
        _sendToAppUser = newVideoMessageData.user,
        _threadId = newVideoMessageData.threadId,
        _videoData = newVideoMessageData.video {
    setVideo(file: _videoData);
  }

  Stream<ToastMessage> get toastStream => _toastMessageStream.stream;

  VideoEditingTools get currentTool => _currentTool;

  NewVideoMessageState get newVideoState => _newVideoState;

  void changeCurrentTool(VideoEditingTools tool) {
    _currentTool = tool;
    _newVideoState = EdittingVideoNewVideoMessageState(
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

    _newVideoState = const LoadingNewVideoMessageState();
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

          _newVideoState = EdittingVideoNewVideoMessageState(
            video: _videoData,
            videoThumbnails: _videoThumbnails!,
            selectedThumbnail: _selectedThumbnail!,
            currentTool: currentTool,
          );
          break;

        case Error<List<Uint8List>>():
          _newVideoState = ErrorNewVideoMessageState(failure: thumbnailResult.failure);
          break;
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> trimVideo({required Duration startTime, required Duration endTime}) async {
    if (_newVideoState is! EdittingVideoNewVideoMessageState) return;

    try {
      _newVideoState = LoadingNewVideoMessageState();
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
              _newVideoState = EdittingVideoNewVideoMessageState(
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
    if (_newVideoState is! EdittingVideoNewVideoMessageState) return;

    print("Modifying thumbnail");

    _selectedThumbnail = thumbnail;
    _newVideoState = EdittingVideoNewVideoMessageState(
      video: _videoData,
      selectedThumbnail: _selectedThumbnail!,
      videoThumbnails: _videoThumbnails!,
      currentTool: _currentTool,
    );
    notifyListeners();
  }

  Future<void> doSendMessage() async {
    if (_newVideoState is! EdittingVideoNewVideoMessageState) return;
    assert(_selectedThumbnail != null);

    try {
      Result<void> newPostResult = await _sendMessageUseCase.sendMessage(
        threadId: _threadId,
        thumbnailData: _selectedThumbnail!,
        videoData: await _videoData.readAsBytes(),
        sendToUserId: _sendToAppUser.id,
        onProgress: (p) {
          _newVideoState = LoadingNewVideoMessageState(progress: p);
          notifyListeners();
        },
      );

      switch (newPostResult) {
        case Success<void>():
          _newVideoState = const SuccessNewVideoMessageState();
          _toastMessageStream.add(
            const ToastSuccess(title: "New Message", message: "New message posted"),
          );
          break;

        case Error<void>():
          _newVideoState = EdittingVideoNewVideoMessageState(
            video: _videoData,
            selectedThumbnail: _selectedThumbnail!,
            videoThumbnails: _videoThumbnails!,
            currentTool: _currentTool,
          );
          _toastMessageStream.add(
            ToastError(title: "New message", message: newPostResult.failure.message),
          );
          break;
      }
    } finally {
      notifyListeners();
    }
  }
}
