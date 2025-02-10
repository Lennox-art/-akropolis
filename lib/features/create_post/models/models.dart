import 'dart:io';
import 'dart:typed_data';
import 'package:akropolis/features/authentication/models/authentication_models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter/material.dart';

part 'models.freezed.dart';

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
class CreatePostForm with _$CreatePostForm {
  const factory CreatePostForm.create({
    required String postId,
    required AppUser appUser,
    File? videoData,
    @Default(false) bool videoDataUploaded,

    Duration? videoDuration,
    Uint8List? thumbnailData,
    @Default(false) bool thumbnailUploaded,
  }) = _CreatePostForm;
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