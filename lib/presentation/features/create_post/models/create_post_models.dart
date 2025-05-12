import 'dart:io';
import 'dart:typed_data';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter/material.dart';

part 'create_post_models.freezed.dart';

enum VideoEditingTools {
  trimVideo(
    "Trim",
    Icons.cut_outlined,
  ),
  thumbnailPicker(
    "Thumbnail",
    Icons.pages_outlined,
  );

  const VideoEditingTools(this.title, this.iconData);

  final String title;
  final IconData iconData;
}

@freezed
class DurationTrim with _$DurationTrim {
  const factory DurationTrim.create({
    required Duration duration,
    @Default(0.0) double start,
    @Default(1.0) double end,
  }) = _DurationTrim;
}

extension TrimFunctionsX on DurationTrim {
  double getDurationRange(Duration d) => (d.inMilliseconds * 100) / duration.inMilliseconds;
}

@freezed
class CreatePostState with _$CreatePostState {
  const factory CreatePostState.loading({ProgressModel? progress}) = LoadingCreatePostState;

  const factory CreatePostState.pickingVideo() = PickingVideoCreatePostState;

  const factory CreatePostState.editingVideo({
    required File video,
    required Uint8List selectedThumbnail,
    required List<Uint8List> videoThumbnails,
    required VideoEditingTools currentTool,
  }) = EdittingVideoCreatePostState;

  const factory CreatePostState.captionPost({required File video, required Uint8List thumbnail}) = CaptionPostCreatePostState;
}
