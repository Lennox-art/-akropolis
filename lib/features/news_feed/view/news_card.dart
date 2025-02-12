import 'dart:typed_data';

import 'package:akropolis/components/news_post_components.dart';
import 'package:akropolis/features/authentication/view_model/authentication_cubit/authentication_cubit.dart';
import 'package:akropolis/features/news_feed/models/models.dart';
import 'package:akropolis/local_storage/media_cache.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/routes/routes.dart';
import 'package:akropolis/utils/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:akropolis/components/loader.dart';

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
          arguments: NewsPostDto(post, newsChannel),
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
                child: StreamBuilder(
                  stream: MediaCache.downloadMedia(post.thumbnailUrl),
                  builder: (_, snap) {

                    log.info(snap.connectionState);

                    if(snap.connectionState != ConnectionState.done) {
                      return const InfiniteLoader();
                    }

                    Uint8List? thumbnailData = snap.data;
                    if(thumbnailData == null) {
                      return const Icon(
                        Icons.image_not_supported_outlined,
                        size: 180,
                      );
                    }

                    return Image.memory(
                      thumbnailData,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        log.error(error.toString(), trace: stackTrace);
                        return const Icon(
                          Icons.broken_image,
                          size: 180,
                        );
                      },
                    );
                  },
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
                          child: Icon(Icons.person),
                        ),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage(
                            post.author.imageUrl ?? '',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      FutureBuilder(
                          future: postsCollectionRef.collection(PostComment.collection).count().get(),
                          builder: (_, commentsCountSnap) {
                            if (commentsCountSnap.connectionState != ConnectionState.done) {
                              return const InfiniteLoader();
                            }

                            int? commentsCount = commentsCountSnap.data?.count;

                            if (commentsCount == null) {
                              return const Icon(Icons.question_mark);
                            }

                            return Visibility(
                              visible: commentsCount > 0,
                              replacement: const Text("Be the first to comment"),
                              child: Text(
                                "+$commentsCount Replies",
                                style: const TextStyle(fontSize: 14, color: Colors.blue),
                              ),
                            );
                          }),
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

class PostCommentCard extends StatelessWidget {
  const PostCommentCard({
    required this.post,
    required this.comment,
    required this.newsPostRef,
    super.key,
  });

  final NewsPost post;
  final PostComment comment;
  final DocumentReference newsPostRef;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Builder(
              builder: (context) {
                if (comment.author.imageUrl == null) {
                  return const Icon(Icons.person);
                }

                return CircleAvatar(
                  backgroundImage: NetworkImage(comment.author.imageUrl!),
                );
              },
            ),
            title: Text(comment.author.name),
            trailing: Text(timeAgo(comment.commentedAt)),
          ),
          SizedBox(
            height: 400,
            child: Image.network(
              comment.thumbnailUrl,
              fit: BoxFit.fill,
            ),
          ),
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: newsPostRef
                      .collection(PostComment.collection)
                      .doc(comment.id)
                      .withConverter<PostComment>(
                        fromFirestore: (snapshot, _) => PostComment.fromJson(snapshot.data()!),
                        toFirestore: (model, _) => model.toJson(),
                      )
                      .snapshots(includeMetadataChanges: true),
                  builder: (_, commentSnap) {
                    final PostComment comment = commentSnap.data?.data() ?? this.comment;

                    return CommentReactionWidget(
                      newsPost: post,
                      postComment: comment,
                      postsCollectionRef: newsPostRef,
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.show_chart),
                  Icon(Icons.more_vert),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
