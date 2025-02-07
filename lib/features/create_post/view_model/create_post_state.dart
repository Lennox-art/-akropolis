part of 'create_post_cubit.dart';

@freezed
class CreatePostState with _$CreatePostState {
  const factory CreatePostState.loading() = LoadingPostState;

  const factory CreatePostState.loaded({
    CreatePostForm? form,
  }) = LoadedPostState;
}
