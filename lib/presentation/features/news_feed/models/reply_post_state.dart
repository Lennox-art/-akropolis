import 'dart:io';
import 'dart:typed_data';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/presentation/features/create_post/models/create_post_models.dart';
import 'package:exception_base/exception_base.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reply_post_state.freezed.dart';

@freezed
class ReplyPostState with _$ReplyPostState {
  const factory ReplyPostState.loading({ProgressModel? progress}) = LoadingReplyPostState;

  const factory ReplyPostState.errorState({required AppFailure failure}) = ErrorReplyPostState;

  const factory ReplyPostState.idlePostState() = IdlePostState;

  const factory ReplyPostState.editingVideo({
    required File video,
    required Uint8List selectedThumbnail,
    required List<Uint8List> videoThumbnails,
    required VideoEditingTools currentTool,
  }) = EdittingVideoReplyPostState;

}