import 'dart:io';
import 'dart:typed_data';

import 'package:akropolis/features/authentication/models/authentication_models.dart';
import 'package:akropolis/features/authentication/view_model/authentication_cubit/authentication_cubit.dart';
import 'package:akropolis/features/news_feed/models/models.dart';
import 'package:akropolis/routes/routes.dart';
import 'package:akropolis/utils/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common_fn/common_fn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCard extends StatelessWidget {
  final NewsPost post;
  final NewsChannel newsChannel;

  DocumentReference get postsCollectionRef => FirebaseFirestore.instance.collection(newsChannel.collection).doc(post.id).withConverter<NewsPost>(
        fromFirestore: (snapshot, _) => NewsPost.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson(),
      );

  const NewsCard({
    super.key,
    required this.post,
    required this.newsChannel,
  });

  void setViewedPost(String userId) {
    bool isViewer = post.viewers.contains(userId);
    if (isViewer) return;

    post.viewers.add(userId);

    postsCollectionRef.update({
      'viewers': FieldValue.arrayUnion([userId])
    });
  }



  Future<void> setCommentReaction({
    required AppUser user,
    required String updatePath,
    required File videoData,
    required Uint8List thumbnail,
  }) async {
    String commentId = "${post.id}-${generateTimeUuid()}";

    final thumbnailsRef = FirebaseStorage.instance.ref().child("thumbnails");
    final postsRef = FirebaseStorage.instance.ref().child("comments");

    late String thumbnailUrl;
    UploadTask thumbTask = thumbnailsRef.child(commentId).putFile(
          videoData,
          SettableMetadata(
            customMetadata: {
              "postId": post.id,
              "commentId": commentId,
            },
          ),
        );
    await for (var snapshot in thumbTask.snapshotEvents) {
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
          thumbnailUrl = await snapshot.ref.getDownloadURL();
          break;
      }
    }

    late String postUrl;
    UploadTask postTask = postsRef.child(commentId).putFile(
          videoData,
          SettableMetadata(
            customMetadata: {
              "postId": post.id,
              "commentId": commentId,
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

          break;
      }
    }

    PostComment comment = PostComment(
      id: commentId,
      thumbnailUrl: thumbnailUrl,
      postUrl: postUrl,
      author: Author(
        id: user.id,
        name: user.username,
        type: AuthorType.user,
      ),
      replies: [],
      commentedAt: DateTime.now(),
      reaction: PostReaction(
        log: {},
        emp: {},
      ),
    );

    postsCollectionRef.update({
      updatePath: FieldValue.arrayUnion([comment])
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    User? user = BlocProvider.of<AuthenticationCubit>(context).getCurrentUser();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (user == null) return;
        setViewedPost(user.uid);
      },
    );

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.newsDetailsPage.path,
          arguments: post,
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: post.thumbnailUrl.isNotEmpty,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16.0),
                ),
                child: Image.network(
                  post.thumbnailUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    size: 50,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.person,
                        size: 18,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          post.author.name,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        timeAgo(post.publishedAt),
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    post.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Visibility(
                        visible: post.author.imageUrl != null,
                        replacement: const CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.yellow,
                        ),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage(
                            post.author.imageUrl ?? '',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Visibility(
                        visible: post.comments.isNotEmpty,
                        replacement: const Text("Be the first to comment"),
                        child: Text(
                          "+${post.comments.length} Replies",
                          style: const TextStyle(fontSize: 14, color: Colors.blue),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.share, size: 18),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert, size: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
