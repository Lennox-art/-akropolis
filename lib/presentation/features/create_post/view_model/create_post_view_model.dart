import 'dart:async';
import 'dart:typed_data';
import 'dart:io' as io;
import 'dart:ui';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/utils/validations.dart';
import 'package:akropolis/domain/use_cases/create_user_post_use_case.dart';
import 'package:akropolis/domain/utils/functions.dart';
import 'package:akropolis/presentation/features/create_post/models/create_post_models.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CreatePostViewModel extends ChangeNotifier {
  final CreatePostUseCase _createPostUseCase;
  final StreamController<ToastMessage> _toastMessageStream = StreamController.broadcast();
  final StreamController<CreatePostState> _createPostStream = StreamController.broadcast();
  VideoEditingTools _currentTool = VideoEditingTools.thumbnailPicker;
  CreatePostState _createPostState = const PickingVideoCreatePostState();
  io.File? _videoData;
  Uint8List? _selectedThumbnail;
  List<Uint8List>? _videoThumbnails;

  CreatePostViewModel({
    required CreatePostUseCase createPostUseCase,
  }) : _createPostUseCase = createPostUseCase;

  Stream<ToastMessage> get toastStream => _toastMessageStream.stream;

  Stream<CreatePostState> get createPostStream => _createPostStream.stream;

  bool get hasDraft => _videoData != null;

  CreatePostState get createPostState => _createPostState;

  void changeCurrentTool(VideoEditingTools tool) {
    _currentTool = tool;
    _createPostState = EdittingVideoCreatePostState(
      video: _videoData!,
      selectedThumbnail: _selectedThumbnail!,
      videoThumbnails: _videoThumbnails!,
      currentTool: _currentTool,
    );
    notifyListeners();
  }

  bool goBack() {
    return _createPostState.mapOrNull(
      editingVideo: (c) {
        _createPostState = const PickingVideoCreatePostState();
        notifyListeners();
        return true;
      },
      captionPost: (c) {
        _createPostState = EdittingVideoCreatePostState(
          video: c.video,
          selectedThumbnail: c.thumbnail,
          videoThumbnails: _videoThumbnails!,
          currentTool: _currentTool,
        );
        notifyListeners();
        return true;
      },
    ) ?? false;
  }

  void useDraft() {
    if (_videoData == null) return;
    setVideo(_videoData!);
  }

  Future<void> setVideo(io.File file) async {
    String? videoError = await validateVideo(file.path);
    if (videoError != null) {
      _toastMessageStream.add(ToastError(title: "Post Video", message: videoError));
      return;
    }

    _createPostState = const LoadingCreatePostState();
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

          _createPostState = EdittingVideoCreatePostState(
            video: _videoData!,
            videoThumbnails: _videoThumbnails!,
            selectedThumbnail: _selectedThumbnail!,
            currentTool: _currentTool,
          );
          break;

        case Error<List<Uint8List>>():
          _createPostState = const PickingVideoCreatePostState();
          break;
      }
    } finally {
      _createPostStream.add(_createPostState);
      notifyListeners();
    }
  }

  Future<void> trimVideo({
    required Duration startTime,
    required Duration endTime,
  }) async {
    if (_createPostState is! EdittingVideoCreatePostState) return;

    Result<io.File> trimmedVideoResult = await trimVideoInRange(
      TrimVideoRequest(
        file: _videoData!,
        start: startTime,
        end: endTime,
      ),
    );

    switch (trimmedVideoResult) {
      case Success<io.File>():
        _videoData = trimmedVideoResult.data;
        _createPostState = EdittingVideoCreatePostState(
          video: _videoData!,
          selectedThumbnail: _selectedThumbnail!,
          videoThumbnails: _videoThumbnails!,
          currentTool: _currentTool,
        );
        notifyListeners();
        break;
      case Error<io.File>():
        _toastMessageStream.add(
          ToastSuccess(message: trimmedVideoResult.failure.message),
        );
        break;
    }
  }

  Future<void> modifyThumbnail(Uint8List thumbnail) async {
    if (_createPostState is! EdittingVideoCreatePostState) return;
    _selectedThumbnail = thumbnail;
    _createPostState = EdittingVideoCreatePostState(
      video: _videoData!,
      selectedThumbnail: _selectedThumbnail!,
      videoThumbnails: _videoThumbnails!,
      currentTool: _currentTool,
    );
    notifyListeners();
  }

  void finishEditing() {
    if (_createPostState is! EdittingVideoCreatePostState) return;

    _createPostState = CaptionPostCreatePostState(
      video: _videoData!,
      thumbnail: _selectedThumbnail!,
    );
    notifyListeners();
  }

  Future<void> doPost({
    required String description,
    required String title,
  }) async {
    if (_createPostState is! CaptionPostCreatePostState) return;

    assert(_selectedThumbnail != null);
    assert(_videoData != null);

    try {
      Result<NewsPost> newPostResult = await _createPostUseCase.post(
        thumbnailData: _selectedThumbnail!,
        videoData: await _videoData!.readAsBytes(),
        description: description,
        title: title,
        onProgress: (p) {
          _createPostState = LoadingCreatePostState(progress: p);
          notifyListeners();
        },
      );

      switch (newPostResult) {
        case Success<NewsPost>():
          _createPostState = const PickingVideoCreatePostState();
          _toastMessageStream.add(
            const ToastSuccess(title: "Post completed", message: "Post uploaded successfully"),
          );
          break;

        case Error<NewsPost>():
          _createPostState = CaptionPostCreatePostState(
            video: _videoData!,
            thumbnail: _selectedThumbnail!,
          );
          _toastMessageStream.add(
            ToastError(title: "Post upload", message: newPostResult.failure.message),
          );
          break;
      }
    } finally {
      notifyListeners();
    }
  }
}
