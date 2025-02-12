import 'dart:io';
import 'dart:typed_data';

import 'package:akropolis/components/toast/toast.dart';
import 'package:akropolis/features/authentication/models/authentication_models.dart';
import 'package:akropolis/features/create_post/models/models.dart';
import 'package:akropolis/features/news_feed/models/models.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/utils/functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common_fn/common_fn.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:network_service/network_service.dart';

part 'post_news_post_reply_state.dart';

part 'post_news_post_reply_cubit.freezed.dart';

class PostVideoReplyCubit extends Cubit<PostVideoReplyState> {
  CreatePostForm? replyForm;
  final thumbnailsRef = FirebaseStorage.instance.ref().child("thumbnails");
  final postsRef = FirebaseStorage.instance.ref().child("posts");
  final CollectionReference postsCollectionRef = FirebaseFirestore.instance.collection(NewsChannel.userPosts.collection).withConverter<NewsPost>(
        fromFirestore: (snapshot, _) => NewsPost.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson(),
      );

  PostVideoReplyCubit() : super(const PostVideoReplyState.loaded());

  Future<void> createVideoReply({
    required NewsPost post,
    required File file,
    required AppUser user,
  }) async {
    Uint8List? thumbnailData = await generateThumbnail(
      videoPath: file.path,
    );

    log.debug("${thumbnailData != null} with data?");

    replyForm = CreatePostForm.create(
      postId: post.id,
      appUser: user,
      videoData: file,
      thumbnailData: thumbnailData,
    );

    emit(
      LoadedPostVideoReplyState(replyForm: replyForm),
    );
  }

  Future<void> trimVideo({
    required Duration startTime,
    required Duration endTime,
  }) async {
    emit(const LoadingPostVideoReplyState());

    File? trimmedVideo = await trimVideoToTime(
      file: replyForm!.videoData!,
      start: startTime,
      end: endTime,
    );

    if (trimmedVideo != null) {
      replyForm = replyForm?.copyWith(
        videoData: trimmedVideo,
      );
    }

    emit(
      LoadedPostVideoReplyState(replyForm: replyForm),
    );
  }

  Future<void> modifyThumbnail({
    required int timeInSeconds,
  }) async {
    emit(const LoadingPostVideoReplyState());

    Uint8List? thumbnailData = await generateThumbnail(
      videoPath: replyForm!.videoData!.path,
      timeInSeconds: timeInSeconds,
    );
    if (thumbnailData != null) {
      replyForm = replyForm?.copyWith(
        thumbnailData: thumbnailData,
      );
    }
    emit(
      LoadedPostVideoReplyState(replyForm: replyForm),
    );
  }

  Future<void> doPost() async {
    if (replyForm == null) return;
    if (replyForm!.thumbnailData == null) return;
    if (replyForm!.videoData == null) return;

    emit(const LoadingPostVideoReplyState());

    String postId = replyForm!.postId;
    String commentId = generateTimeUuid();

    //Upload thumbnail
    String thumbnailUrl = '';
    if (replyForm!.thumbnailUploaded) {
      thumbnailUrl = await thumbnailsRef.child(postId).getDownloadURL();
    } else {
      UploadTask thumbnailTask = thumbnailsRef.child(postId).putData(
            replyForm!.thumbnailData!,
            SettableMetadata(
              customMetadata: {
                "commentId": commentId,
                "postId": postId,
              },
            ),
          );

      await for (var snapshot in thumbnailTask.snapshotEvents) {
        if(snapshot.totalBytes == 0) continue;

        final progress = UploadProgress(sent: snapshot.bytesTransferred, total: snapshot.totalBytes);

        switch (snapshot.state) {
          case TaskState.running:
            log.info("Thumbnail upload is ${progress.percent.toInt()}% complete.");

            emit(
              LoadingPostVideoReplyState(
                postId: postId,
                message: ToastInfo(
                  message: "(1/2) Thumbnail Upload is ${progress.percent.toInt()}% complete.",
                ),
                progress: progress,
              ),
            );
            break;
          case TaskState.paused:
            log.info("Upload paused");
            emit(
              LoadingPostVideoReplyState(
                postId: postId,
                message: ToastInfo(
                  message: "(1/2) Upload paused at ${progress.percent.toInt()}%",
                ),
                progress: progress,
              ),
            );
            break;
          case TaskState.canceled:
            log.info("Upload was canceled");
            emit(
              LoadingPostVideoReplyState(
                postId: postId,
                message: ToastError(
                  message: "(1/2) Upload cancelled at ${progress.percent.toInt()}%",
                ),
                progress: progress,
              ),
            );
            break;
          case TaskState.error:
            emit(
              LoadingPostVideoReplyState(
                postId: postId,
                message: ToastError(
                  message: "(1/2) Error uploading thumbnail at ${progress.percent.toInt()}%",
                ),
                progress: progress,
              ),
            );
            break;
          case TaskState.success:
            thumbnailUrl = await snapshot.ref.getDownloadURL();
            replyForm = replyForm?.copyWith(thumbnailUploaded: true);

            emit(
              LoadingPostVideoReplyState(
                postId: postId,
                message: const ToastSuccess(
                  message: "(1/2) Thumbnail uploaded successfully",
                ),
                progress: progress,
              ),
            );
            break;
        }
      }
    }

    //Upload post data
    String postUrl = '';
    if (replyForm!.videoDataUploaded) {
      postUrl = await postsRef.child(postId).getDownloadURL();
    } else {
      UploadTask postTask = postsRef.child(postId).putFile(
            replyForm!.videoData!,
            SettableMetadata(
              customMetadata: {
                "postId": postId,
              },
            ),
          );

      await for (var snapshot in postTask.snapshotEvents) {
        if(snapshot.totalBytes == 0) continue;
        final progress = UploadProgress(sent: snapshot.bytesTransferred, total: snapshot.totalBytes);

        switch (snapshot.state) {
          case TaskState.running:
            log.info("Post upload is ${progress.percent.toInt()}% complete.");

            emit(
              LoadingPostVideoReplyState(
                postId: postId,
                message: ToastInfo(
                  message: "(2/2) Post Upload is ${progress.percent.toInt()}% complete.",
                ),
                progress: progress,
              ),
            );
            break;
          case TaskState.paused:
            log.info("Upload paused");
            emit(
              LoadingPostVideoReplyState(
                postId: postId,
                message: ToastInfo(
                  message: "(2/2) Upload paused at ${progress.percent.toInt()}%",
                ),
                progress: progress,
              ),
            );
            break;
          case TaskState.canceled:
            log.info("Upload was canceled");
            emit(
              LoadingPostVideoReplyState(
                postId: postId,
                message: ToastError(
                  message: "(2/2) Upload cancelled at ${progress.percent.toInt()}%",
                ),
                progress: progress,
              ),
            );
            break;
          case TaskState.error:
            emit(
              LoadingPostVideoReplyState(
                postId: postId,
                message: ToastError(
                  message: "(2/2) Error uploading comment at ${progress.percent.toInt()}%",
                ),
                progress: progress,
              ),
            );
            break;
          case TaskState.success:
            postUrl = await snapshot.ref.getDownloadURL();
            replyForm = replyForm?.copyWith(thumbnailUploaded: true);

            emit(
              LoadingPostVideoReplyState(
                postId: postId,
                message: const ToastSuccess(
                  message: "(2/2) Comment uploaded successfully",
                ),
                progress: progress,
              ),
            );
            break;
        }
      }
    }

    //Upload posts
    PostComment newComment = PostComment(
      id: commentId,
      postId: replyForm!.postId,
      thumbnailUrl: thumbnailUrl,
      postUrl: postUrl,
      author: Author(
        id: replyForm!.appUser.id,
        name: replyForm!.appUser.username,
        imageUrl: replyForm!.appUser.profilePicture,
        type: AuthorType.user,
      ),
      commentedAt: DateTime.now(),
      reaction: PostReaction(log: {}, emp: {}),
    );

    await postsCollectionRef
        .doc(replyForm!.postId)
        .collection(PostComment.collection)
        .doc(newComment.id)
        .set(newComment.toJson());


    emit(
      const LoadedPostVideoReplyState(
        message: ToastSuccess(
          title: "Post Reply",
          message: "Comment posted",
        ),
      ),
    );


    replyForm = null;
  }
}
