part of 'post_news_post_reply_cubit.dart';

@freezed
class PostVideoReplyState with _$PostVideoReplyState {
  const factory PostVideoReplyState.loading({
    String? postId,
    ToastMessage? message,
    UploadProgress? progress,
  }) = LoadingPostVideoReplyState;

  const factory PostVideoReplyState.loaded({
    ToastMessage? message,
    CreatePostForm? replyForm,
  }) = LoadedPostVideoReplyState;
}
