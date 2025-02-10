import 'dart:io';
import 'dart:typed_data';

import 'package:akropolis/components/toast/toast.dart';
import 'package:akropolis/features/authentication/models/authentication_models.dart';
import 'package:akropolis/features/create_post/models/models.dart';
import 'package:akropolis/utils/functions.dart';
import 'package:camera/camera.dart';
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
  final CollectionReference postsCollectionRef = FirebaseFirestore.instance.collection(NewsPost.collection).withConverter<NewsPost>(
        fromFirestore: (snapshot, _) => NewsPost.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson(),
      );

  CreatePostCubit() : super(const CreatePostState.loaded());

  Future<void> createNewPost({
    required XFile file,
    required AppUser user,
  }) async {
    File tempFilePath = await File(file.path).writeAsBytes(
      await file.readAsBytes(),
    );

    Duration? duration;
    // = await getVideoDuration(file.path);
    Uint8List? thumbnailData = await generateThumbnailBytes(
      videoPath: file.path,
    );

    form = CreatePostForm.create(
      postId: generateTimeUuid(),
      appUser: user,
      videoData: tempFilePath,
      videoDuration: duration,
      thumbnailData: thumbnailData,
    );

    emit(
      LoadedPostState(form: form),
    );
  }

  void modifyThumbnail({

    Uint8List? thumbnail,
  }) {
    form = form?.copyWith(
      thumbnailData: thumbnail,
    );
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
    late String thumbnailUrl;
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
        switch (snapshot.state) {
          case TaskState.running:
            final progress = 100.0 * (snapshot.bytesTransferred / snapshot.totalBytes);
            print("Thumbnail Upload is $progress% complete.");
            break;
          case TaskState.paused:
            print("Upload is paused.");
            break;
          case TaskState.canceled:
            print("Upload was canceled");
            break;
          case TaskState.error:
            // Handle unsuccessful uploads
            break;
          case TaskState.success:
            // Handle successful uploads on complete
            // ...
            thumbnailUrl = await snapshot.ref.getDownloadURL();
            form = form?.copyWith(thumbnailUploaded: true);

            break;
        }
      }
    }

    //Upload post data
    late String postUrl;
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
        switch (snapshot.state) {
          case TaskState.running:
            final progress = 100.0 * (snapshot.bytesTransferred / snapshot.totalBytes);
            print("Post Upload is $progress% complete.");
            break;
          case TaskState.paused:
            print("Upload is paused.");
            break;
          case TaskState.canceled:
            print("Upload was canceled");
            break;
          case TaskState.error:
            // Handle unsuccessful uploads
            break;
          case TaskState.success:
            // Handle successful uploads on complete
            // ...
            postUrl = await snapshot.ref.getDownloadURL();
            form = form?.copyWith(videoDataUploaded: true);

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
      comments: [],
      viewers: {},
      reaction: PostReaction(log: {}, emp: {}),
      publishedAt: DateTime.now(),
    );
    await postsCollectionRef.doc(newsPost.id).set(newsPost);
    form = null;

    emit(
      const LoadedPostState(),
    );
  }
}
