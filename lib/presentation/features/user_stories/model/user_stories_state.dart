import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_stories_state.freezed.dart';

@freezed
sealed class UserStoryState with _$UserStoryState {
  const factory UserStoryState.loading() = LoadingUserStoryState;
  const factory UserStoryState.loaded() = LoadedUserStoryState;
}

@freezed
sealed class MyUserStoryState with _$MyUserStoryState {
  const factory MyUserStoryState.loading() = LoadingMyUserStoryState;
  const factory MyUserStoryState.loaded() = LoadedMyUserStoryState;
}