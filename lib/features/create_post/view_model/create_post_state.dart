part of 'create_post_cubit.dart';

@freezed
class CreatePostState with _$CreatePostState {
  const factory CreatePostState.loading({
    ToastMessage? message,
    UploadProgress? progress,
  }) = LoadingPostState;

  const factory CreatePostState.loaded({
    ToastMessage? toast,
    CreatePostForm? form,
  }) = LoadedPostState;
}
