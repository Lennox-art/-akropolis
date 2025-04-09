import 'dart:io';
import 'dart:typed_data';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/presentation/features/create_post/models/create_post_models.dart';
import 'package:exception_base/exception_base.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_video_message_model.freezed.dart';

@freezed
class NewVideoMessageState with _$NewVideoMessageState {
  const factory NewVideoMessageState.loading({ProgressModel? progress}) = LoadingNewVideoMessageState;

  const factory NewVideoMessageState.errorState({required AppFailure failure}) = ErrorNewVideoMessageState;

  const factory NewVideoMessageState.idlePostState() = IdleNewVideoMessageState;
  const factory NewVideoMessageState.successState() = SuccessNewVideoMessageState;

  const factory NewVideoMessageState.editingVideo({
    required File video,
    required Uint8List selectedThumbnail,
    required List<Uint8List> videoThumbnails,
    required VideoEditingTools currentTool,
  }) = EdittingVideoNewVideoMessageState;
}

class NewVideoMessageData {
  final String? threadId;
  final File video;
  final AppUser user;

  NewVideoMessageData(this.threadId, this.video, this.user);
}
