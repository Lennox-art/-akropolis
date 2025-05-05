import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_viewer_state.freezed.dart';


@freezed
sealed class StoryViewerState with _$StoryViewerState {
  const factory StoryViewerState.loaded() = LoadedStoryViewerState;
  const factory StoryViewerState.loading() = LoadingStoryViewerState;
}
