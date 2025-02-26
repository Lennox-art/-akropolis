import 'dart:io';
import 'dart:typed_data';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter/material.dart';
import 'package:network_service/network_service.dart';

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

  const factory CreatePostState.loading({UploadProgress? progress}) = LoadingCreatePostState;

  const factory CreatePostState.loaded() = LoadedCreatePostState;

}