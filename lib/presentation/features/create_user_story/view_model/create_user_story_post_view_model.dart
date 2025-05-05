import 'dart:async';
import 'dart:io' as io;

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/utils/validations.dart';
import 'package:akropolis/domain/use_cases/create_user_post_use_case.dart';
import 'package:akropolis/domain/utils/functions.dart';
import 'package:akropolis/presentation/features/create_post/models/create_post_models.dart';
import 'package:akropolis/presentation/features/create_user_story/models/create_user_story_post_models.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/foundation.dart';

class CreateUserPostViewModel extends ChangeNotifier {
  final CreateUserPostUseCase _createPostUseCase;
  final StreamController<ToastMessage> _toastMessageStream = StreamController.broadcast();
  final StreamController<CreateUserStoryPostState> _createPostStream = StreamController.broadcast();
  VideoEditingTools _currentTool = VideoEditingTools.thumbnailPicker;
  CreateUserStoryPostState _createPostState = const PickingVideoCreateUserStoryPostState();
  io.File? _videoData;
  Uint8List? _selectedThumbnail;
  List<Uint8List>? _videoThumbnails;

  CreateUserPostViewModel({
    required CreateUserPostUseCase createPostUseCase,
  }) : _createPostUseCase = createPostUseCase;

  Stream<ToastMessage> get toastStream => _toastMessageStream.stream;

  Stream<CreateUserStoryPostState> get createPostStream => _createPostStream.stream;

  bool get hasDraft => _videoData != null;

  CreateUserStoryPostState get createPostState => _createPostState;

  void changeCurrentTool(VideoEditingTools tool) {
    _currentTool = tool;
    _createPostState = EdittingVideoCreateUserStoryPostState(
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
        _createPostState = const PickingVideoCreateUserStoryPostState();
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

    _createPostState = const LoadingCreateUserStoryPostState();
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

          _createPostState = EdittingVideoCreateUserStoryPostState(
            video: _videoData!,
            videoThumbnails: _videoThumbnails!,
            selectedThumbnail: _selectedThumbnail!,
            currentTool: _currentTool,
          );
          break;

        case Error<List<Uint8List>>():
          _createPostState = const PickingVideoCreateUserStoryPostState();
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
    if (_createPostState is! EdittingVideoCreateUserStoryPostState) return;

    try {
      _createPostState = const LoadingCreateUserStoryPostState();
      notifyListeners();

      Result<io.File> trimmedVideoResult = await trimVideoInRange(
        TrimVideoRequest(
          file: _videoData!,
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
              _createPostState = EdittingVideoCreateUserStoryPostState(
                video: _videoData!,
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
    if (_createPostState is! EdittingVideoCreateUserStoryPostState) return;

      _selectedThumbnail = thumbnail;
      _createPostState = EdittingVideoCreateUserStoryPostState(
        video: _videoData!,
        selectedThumbnail: _selectedThumbnail!,
        videoThumbnails: _videoThumbnails!,
        currentTool: _currentTool,
      );
      notifyListeners();

  }


  Future<void> doPost() async {
    if (_createPostState is! EdittingVideoCreateUserStoryPostState) return;

    assert(_selectedThumbnail != null);
    assert(_videoData != null);

    try {
      Result<UserStory> newPostResult = await _createPostUseCase.post(
        thumbnailData: _selectedThumbnail!,
        videoData: await _videoData!.readAsBytes(),
        onProgress: (p) {
          _createPostState = LoadingCreateUserStoryPostState(progress: p);
          notifyListeners();
        },
      );

      switch (newPostResult) {
        case Success<UserStory>():
          _createPostState = const PickingVideoCreateUserStoryPostState();
          _toastMessageStream.add(
            const ToastSuccess(title: "Story completed", message: "Story uploaded successfully"),
          );
          reset();
          break;

        case Error<UserStory>():
          _createPostState = EdittingVideoCreateUserStoryPostState(
            video: _videoData!,
            selectedThumbnail: _selectedThumbnail!,
            videoThumbnails: _videoThumbnails!,
            currentTool: _currentTool,
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

  void reset({bool saveDraft = true}) {

    if(!saveDraft) {
      _videoData = null;
    }

    _selectedThumbnail = null;
    _videoThumbnails = null;
    _createPostState = const PickingVideoCreateUserStoryPostState();
    notifyListeners();
  }
}
