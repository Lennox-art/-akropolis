import 'dart:io';
import 'dart:typed_data';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/presentation/features/create_post/models/create_post_models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter/material.dart';
import 'package:network_service/network_service.dart';

part 'create_user_story_post_models.freezed.dart';

@freezed
class CreateUserStoryPostState with _$CreateUserStoryPostState {
  const factory CreateUserStoryPostState.loading({ProgressModel? progress}) = LoadingCreateUserStoryPostState;

  const factory CreateUserStoryPostState.pickingVideo() = PickingVideoCreateUserStoryPostState;

  const factory CreateUserStoryPostState.editingVideo({
    required File video,
    required Uint8List selectedThumbnail,
    required List<Uint8List> videoThumbnails,
    required VideoEditingTools currentTool,
  }) = EdittingVideoCreateUserStoryPostState;

}
