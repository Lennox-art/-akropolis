import 'dart:collection';

import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/presentation/features/news_feed/models/media_download_state.dart';
import 'package:exception_base/exception_base.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_card_replies_state.freezed.dart';

@freezed
class NewsCardRepliesState with _$NewsCardRepliesState {
  const factory NewsCardRepliesState.initial() = InitialNewsCardRepliesState;

  const factory NewsCardRepliesState.loading() = LoadingNewsCardRepliesState;

  const factory NewsCardRepliesState.errorState({required AppFailure failure}) = ErrorNewsCardRepliesState;

  const factory NewsCardRepliesState.loaded() = LoadedNewsCardRepliesState;

}