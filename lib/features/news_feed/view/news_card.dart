import 'dart:typed_data';

import 'package:akropolis/components/app_video_player.dart';
import 'package:akropolis/components/news_post_components.dart';
import 'package:akropolis/features/authentication/view_model/authentication_cubit/authentication_cubit.dart';
import 'package:akropolis/features/news_feed/models/models.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/routes/routes.dart';
import 'package:akropolis/utils/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:akropolis/components/loader.dart';

import 'news_detailed_view.dart';

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
    late Future<AggregateQuerySnapshot> commentsCountFuture = postsCollectionRef.collection(PostComment.collection).count().get();

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
                child: CachedNetworkImage(
                  imageUrl: post.thumbnailUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    log.error(error.toString());
                    return const Icon(
                      Icons.broken_image,
                      size: 180,
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
                        future: commentsCountFuture,
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
                        },
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

class PostCommentCard extends StatelessWidget {
  PostCommentCard({
    required this.post,
    required this.comment,
    required this.newsPostRef,
    super.key,
  });

  final NewsPost post;
  final PostComment comment;
  final DocumentReference newsPostRef;
  final ValueNotifier<bool> clickedPlay = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
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
          child: ValueListenableBuilder(
            valueListenable: clickedPlay,
            builder: (_, showVideo, __) {
              if (!showVideo) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: comment.thumbnailUrl,
                      fit: BoxFit.fill,
                    ),
                    IconButton(
                      onPressed: () {
                        clickedPlay.value = true;
                      },
                      icon: const Icon(Icons.play_arrow),
                    ),
                  ],
                );
              }

              return CachedVideoPlayer(
                videoUrl: comment.postUrl,
                autoPlay: true,
              );
            },
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
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.show_chart),
                  ),
                  MenuAnchor(
                    builder: (_, controller, __) {
                      return IconButton(
                        onPressed: () {
                          if (controller.isOpen) {
                            controller.close();
                            return;
                          }
                          controller.open();
                        },
                        icon: const Icon(Icons.more_vert),
                        tooltip: 'Post options',
                      );
                    },
                    menuChildren: PostMenu.values
                        .where((e) => e != PostMenu.notInterested)
                        .map(
                          (menu) => MenuItemButton(
                            onPressed: () {},
                            child: Text(
                              menu.title,
                              style: TextStyle(color: menu == PostMenu.report ? Colors.red : Colors.white),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ForYouHighlightCard extends StatelessWidget {
  final NewsPost post;
  final NewsChannel newsChannel;

  DocumentReference get postsCollectionRef => FirebaseFirestore.instance.collection(newsChannel.collection).doc(post.id).withConverter<NewsPost>(
        fromFirestore: (snapshot, _) => NewsPost.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson(),
      );

  const ForYouHighlightCard({
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
    late Future<AggregateQuerySnapshot> commentsCountFuture = postsCollectionRef.collection(PostComment.collection).count().get();

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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: post.thumbnailUrl.isNotEmpty,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16.0),
                ),
                child: CachedNetworkImage(
                  imageUrl: post.thumbnailUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    log.error(error.toString());
                    return const Icon(
                      Icons.broken_image,
                      size: 180,
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          post.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
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
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                post.author.name,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.labelLarge?.copyWith(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(

                        child: Flex(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          direction: Axis.horizontal,
                          children: [
                            Flexible(
                              child: Visibility(
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
                            ),
                            Expanded(
                              flex: 2,
                              child: FutureBuilder(
                                future: commentsCountFuture,
                                builder: (_, commentsCountSnap) {
                                  if (commentsCountSnap.connectionState != ConnectionState.done) {
                                    return const InfiniteLoader();
                                  }

                                  int? commentsCount = commentsCountSnap.data?.count;

                                  if (commentsCount == null) {
                                    return const Icon(Icons.question_mark);
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Visibility(
                                      visible: commentsCount > 0,
                                      replacement: const Text("Be the first to comment"),
                                      child: Text(
                                        "+$commentsCount Replies",
                                        style: const TextStyle(fontSize: 12, color: Colors.blue),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Flexible(
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.share,
                                  size: 14,
                                ),
                              ),
                            ),
                            Flexible(
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.more_vert,
                                  size: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
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
