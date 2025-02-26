import 'dart:async';
import 'dart:typed_data';
import 'dart:io' as io;

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/use_cases/create_user_post_use_case.dart';
import 'package:akropolis/domain/utils/functions.dart';
import 'package:akropolis/presentation/features/create_post/models/create_post_models.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/file.dart';

class CreatePostViewModel extends ChangeNotifier {
  final CreatePostUseCase _createPostUseCase;
  final StreamController<ToastMessage> _toastMessageStream = StreamController.broadcast();
  final StreamController<CreatePostState> _createPostStream = StreamController.broadcast();
  io.File? _videoData;
  Uint8List? _thumbnailData;
  CreatePostState _createPostState = const LoadedCreatePostState();

  CreatePostViewModel({
    required CreatePostUseCase createPostUseCase,
  }) : _createPostUseCase = createPostUseCase;

  Stream<ToastMessage> get toastStream => _toastMessageStream.stream;
  Stream<CreatePostState> get createPostStream => _createPostStream.stream;

  Uint8List? get thumbnailData => _thumbnailData;

  io.File? get videoData => _videoData;

  CreatePostState get createPostState => _createPostState;

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

  Future<void> doPost({
    required String description,
    required String title,
  }) async {
    if (_createPostState is LoadingCreatePostState) return;
    if (_thumbnailData == null) return;
    if (_videoData == null) return;

    _createPostState = const LoadingCreatePostState();
    notifyListeners();

    try {
      Result<NewsPost> newPostResult = await _createPostUseCase.post(
        thumbnailData: _thumbnailData!,
        videoData: await _videoData!.readAsBytes(),
        description: description,
        title: title,
      );

      switch(newPostResult) {

        case Success<NewsPost>():
          _toastMessageStream.add(
            const ToastSuccess(title: "Post completed", message: "Post uploaded successfully"),
          );
          break;

        case Error<NewsPost>():
          _toastMessageStream.add(
            ToastError(title: "Post upload", message: newPostResult.failure.message),
          );
          break;
      }

    } finally {
      _createPostState = const LoadedCreatePostState();
      notifyListeners();
    }
  }
}
