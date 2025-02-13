import 'dart:io';
import 'dart:typed_data';

import 'package:akropolis/components/toast/toast.dart';
import 'package:akropolis/features/authentication/models/authentication_models.dart';
import 'package:akropolis/features/create_post/models/models.dart';
import 'package:akropolis/features/news_feed/models/models.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/utils/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common_fn/common_fn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:network_service/network_service.dart';

part 'create_post_state.dart';

part 'create_post_cubit.freezed.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostForm? form;
  final thumbnailsRef = FirebaseStorage.instance.ref().child("thumbnails");
  final postsRef = FirebaseStorage.instance.ref().child("posts");
  final CollectionReference postsCollectionRef = FirebaseFirestore.instance.collection(NewsChannel.userPosts.collection).withConverter<NewsPost>(
        fromFirestore: (snapshot, _) => NewsPost.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson(),
      );

  CreatePostCubit() : super(const CreatePostState.loaded());

  Future<void> createNewPost({
    required File file,
    required AppUser user,
  }) async {
    Uint8List? thumbnailData = await generateThumbnail(
      videoPath: file.path,
    );

    log.debug("${thumbnailData != null} with data?");

    form = CreatePostForm.create(
      postId: generateTimeUuid(),
      appUser: user,
      videoData: file,
      thumbnailData: thumbnailData,
    );

    emit(
      LoadedPostState(form: form),
    );
  }

  Future<void> trimVideo({
    required Duration startTime,
    required Duration endTime,
  }) async {
    emit(const LoadingPostState());

    File? trimmedVideo = await trimVideoToTime(
      file: form!.videoData!,
      start: startTime,
      end: endTime,
    );

    if (trimmedVideo != null) {
      form = form?.copyWith(
        videoData: trimmedVideo,
      );
    }

    emit(
      LoadedPostState(form: form),
    );
  }

  Future<void> modifyThumbnail({
    required int timeInSeconds,
  }) async {
    emit(const LoadingPostState());

    Uint8List? thumbnailData = await generateThumbnail(
      videoPath: form!.videoData!.path,
      timeInSeconds: timeInSeconds,
    );
    if (thumbnailData != null) {
      form = form?.copyWith(
        thumbnailData: thumbnailData,
      );
    }
    emit(
      LoadedPostState(form: form),
    );
  }

  Future<void> doPost({
    required String description,
    required String title,
  }) async {
    if (form == null) return;
    if (form!.thumbnailData == null) return;
    if (form!.videoData == null) return;

    emit(const LoadingPostState());

    String postId = form!.postId;

    //Upload thumbnail
    String thumbnailUrl = '';
    if (form!.thumbnailUploaded) {
      thumbnailUrl = await thumbnailsRef.child(postId).getDownloadURL();
    } else {
      UploadTask thumbnailTask = thumbnailsRef.child(postId).putData(
            form!.thumbnailData!,
            SettableMetadata(
              customMetadata: {
                "postId": postId,
                "title": title,
              },
            ),
          );

      await for (var snapshot in thumbnailTask.snapshotEvents) {
        if(snapshot.totalBytes == 0) continue;

        final progress = UploadProgress(sent: snapshot.bytesTransferred, total: snapshot.totalBytes);
        log.info("Transferred ${snapshot.bytesTransferred} out of ${snapshot.totalBytes} complete.");

        switch (snapshot.state) {
          case TaskState.running:
            log.info("Thumbnail Upload is ${progress.percent.toInt()}% complete.");

            emit(
              LoadingPostState(
                message: ToastInfo(
                  message: "(2/2) Thumbnail Upload is ${progress.percent.toInt()}% complete.",
                ),
                progress: progress,
              ),
            );
            break;
          case TaskState.paused:
            log.info("Upload paused");
            emit(
              LoadingPostState(
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
              LoadingPostState(
                message: ToastError(
                  message: "(2/2) Upload cancelled at ${progress.percent.toInt()}%",
                ),
                progress: progress,
              ),
            );
            break;
          case TaskState.error:
            emit(
              LoadingPostState(
                message: ToastError(
                  message: "(2/2) Error uploading thumbnail at ${progress.percent.toInt()}%",
                ),
                progress: progress,
              ),
            );
            break;
          case TaskState.success:
            thumbnailUrl = await snapshot.ref.getDownloadURL();
            form = form?.copyWith(thumbnailUploaded: true);

            emit(
              LoadingPostState(
                message: const ToastSuccess(
                  message: "(2/2) Thumbnail uploaded successfully",
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
    if (form!.videoDataUploaded) {
      postUrl = await postsRef.child(postId).getDownloadURL();
    } else {
      UploadTask postTask = postsRef.child(postId).putFile(
            form!.videoData!,
            SettableMetadata(
              customMetadata: {
                "postId": postId,
                "title": title,
                "description": description,
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
              LoadingPostState(
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
              LoadingPostState(
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
              LoadingPostState(
                message: ToastError(
                  message: "(2/2) Upload cancelled at ${progress.percent.toInt()}%",
                ),
                progress: progress,
              ),
            );
            break;
          case TaskState.error:
            emit(
              LoadingPostState(
                message: ToastError(
                  message: "(2/2) Error uploading post at ${progress.percent.toInt()}%",
                ),
                progress: progress,
              ),
            );
            break;
          case TaskState.success:
            postUrl = await snapshot.ref.getDownloadURL();
            form = form?.copyWith(thumbnailUploaded: true);

            emit(
              LoadingPostState(
                message: const ToastSuccess(
                  message: "(2/2) Post uploaded successfully",
                ),
                progress: progress,
              ),
            );
            break;
        }
      }
    }

    //Upload posts
    NewsPost newsPost = NewsPost(
      id: postId,
      thumbnailUrl: thumbnailUrl,
      postUrl: postUrl,
      title: title,
      description: description,
      author: Author(
        id: form!.appUser.id,
        name: form!.appUser.displayName,
        imageUrl: form!.appUser.profilePicture,
        type: AuthorType.user,
      ),
      viewers: {},
      reaction: PostReaction(
        log: {},
        emp: {},
      ),
      publishedAt: DateTime.now(),
    );
    await postsCollectionRef.doc(newsPost.id).set(newsPost);
    form = null;

    emit(
      LoadedPostState(
        toast: const ToastSuccess(
          message: "Post uploaded successfully",
        ),
        newPost: newsPost,
      ),
    );


    form = null;
  }
}
