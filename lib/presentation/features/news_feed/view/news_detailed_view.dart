import 'dart:io';


import 'package:akropolis/data/models/local_models/local_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/gen/assets.gen.dart';
import 'package:akropolis/main.dart';

import 'package:akropolis/data/utils/constants.dart';
import 'package:akropolis/data/utils/date_format.dart';
import 'package:akropolis/data/utils/validations.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/news_fetchers/post_comment_fetcher.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/post_news_post_reply_cubit/post_news_post_reply_cubit.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/components/app_video_player.dart';
import 'package:akropolis/presentation/ui/components/duration_picker.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/news_post_components.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paged_list_view/paged_list_view.dart';

import 'news_card.dart';

enum PostMenu {
  share("Share"),
  bookmark("Bookmark"),
  notInterested("Not interested"),
  report("Report");

  final String title;

  const PostMenu(this.title);
}

class NewsDetailedViewPage extends StatefulWidget {
  const NewsDetailedViewPage({super.key});

  @override
  State<NewsDetailedViewPage> createState() => _NewsDetailedViewPageState();
}

class _NewsDetailedViewPageState extends State<NewsDetailedViewPage> {
  late final NewsPostDto? newsPostDto = ModalRoute.of(context)?.settings.arguments as NewsPostDto?;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (newsPostDto == null) {
      return TextButton(
        onPressed: Navigator.of(context).pop,
        child: const Text("Back"),
      );
    }

    NewsPost newsPost = newsPostDto!.newsPost;
    NewsChannel channel = newsPostDto!.channel;
    final GlobalKey<PagedListState> commentPagedListKey = GlobalKey<PagedListState>();

    final DocumentReference newsPostRef = FirebaseFirestore.instance.collection(channel.collection).doc(newsPost.id).withConverter<NewsPost>(
          fromFirestore: (snapshot, _) => NewsPost.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );

    late Future<AggregateQuerySnapshot> commentCount = newsPostRef.collection(PostComment.collection).count().get();

    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: null,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                Duration? videoDuration = await showDurationPickerDialog(
                  context,
                  maxDuration: maxVideoDuration,
                );
                if (videoDuration == null || !context.mounted) return;

                XFile? videoData = await getIt<ImagePicker>().pickVideo(
                  source: ImageSource.camera,
                  preferredCameraDevice: CameraDevice.rear,
                  maxDuration: videoDuration,
                );
                if (videoData == null || !context.mounted) return;

                AppUser? user = await BlocProvider.of<UserCubit>(context).getCurrentUser();
                if (user == null || !context.mounted) return;

                String? videoError = await validateVideo(videoData.path);
                if (!context.mounted) return;

                if (videoError != null) {
                  ToastError(title: "Post Video", message: videoError).show();
                  return;
                }

                await BlocProvider.of<PostVideoReplyCubit>(context).createVideoReply(
                  post: newsPost,
                  file: File(videoData.path)..writeAsBytesSync(await videoData.readAsBytes()),
                  user: user,
                );

                if (!context.mounted) return;

                Navigator.of(context).pushNamed(
                  AppRoutes.postReplyScreen.path,
                );
              },
              style: theme.elevatedButtonTheme.style?.copyWith(
                fixedSize: const WidgetStatePropertyAll(
                  Size(100, 40),
                ),
              ),
              child: const Text("Reply"),
            ),
          ),
        ],
      ),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (_, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Builder(
                                builder: (context) {
                                  if (newsPost.author.imageUrl == null) {
                                    return const Icon(Icons.person);
                                  }

                                  return CircleAvatar(
                                    backgroundImage: NetworkImage(newsPost.author.imageUrl!),
                                  );
                                },
                              ),
                            ),
                            Text(newsPost.author.name),
                          ],
                        ),
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
                      )
                    ],
                  ),
                  BlocConsumer<PostVideoReplyCubit, PostVideoReplyState>(
                    listener: (context, state) {
                      state.mapOrNull(
                        loaded: (l) {
                          setState(() {
                            commentCount = newsPostRef.collection(PostComment.collection).count().get();
                          });
                          l.message?.show();
                        },
                      );
                    },
                    builder: (context, state) {
                      return state.mapOrNull(
                            loading: (l) {
                              if (newsPost.id != l.postId) return null;

                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    l.message?.message ?? "...",
                                  ),
                                  Builder(builder: (context) {
                                    if (l.progress == null) {
                                      return const SizedBox.shrink();
                                    }
                                    return FiniteLoader(progress: l.progress!);
                                  }),
                                ],
                              );
                            },
                          ) ??
                          const SizedBox.shrink();
                    },
                  ),
                  Container(
                    height: 400,
                    color: Colors.black12,
                    child: FutureBuilder<MediaType>(
                      future: whichMediaType(newsPost.postUrl),
                      builder: (_, mediaTypeSnap) {
                        if (!mediaTypeSnap.hasData) {
                          return const InfiniteLoader();
                        }

                        MediaType mediaType = mediaTypeSnap.data!;

                        switch (mediaType) {
                          case MediaType.image:
                            return CachedNetworkImage(
                              imageUrl: newsPost.postUrl,
                              height: 350,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) {
                                log.error(error.toString());
                                return const Icon(Icons.broken_image, size: 180);
                              },
                            );
                          case MediaType.video:
                            return CachedVideoPlayer(
                              videoUrl: newsPost.postUrl,
                              autoPlay: true,
                            );
                          case MediaType.unknown:
                            if (channel == NewsChannel.userPosts) {
                              return const Icon(Icons.question_mark, size: 180);
                            }

                            return CachedNetworkImage(
                              imageUrl: newsPost.thumbnailUrl,
                              height: 350,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) {
                                log.error(error.toString());
                                return const Icon(Icons.broken_image, size: 180);
                              },
                            );
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                    child: Text(
                      newsPost.description,
                      style: theme.textTheme.labelLarge,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                    child: Text(
                      newsPost.publishedAt.commentDateTime,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Flex(
                          direction: Axis.horizontal,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: StreamBuilder(
                                stream: newsPostRef.snapshots(includeMetadataChanges: true),
                                builder: (_, snap) {
                                  NewsPost updatedPost = snap.data?.data() as NewsPost? ?? newsPost;
                                  return NewsPostReactionWidget(
                                    newsPost: updatedPost,
                                    postsCollectionRef: newsPostRef,
                                  );
                                },
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Assets.chatTearDot.svg(),
                                    FutureBuilder(
                                      future: commentCount,
                                      builder: (_, commentsCountSnap) {
                                        if (commentsCountSnap.connectionState != ConnectionState.done) {
                                          return const InfiniteLoader();
                                        }

                                        int? commentsCount = commentsCountSnap.data?.count;

                                        if (commentsCount == null) {
                                          return const Icon(Icons.question_mark);
                                        }

                                        return Padding(
                                          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                                          child: Text(commentsCount.toString()),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Assets.medal.svg(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(
                            8.0,
                          ),
                          child: Assets.share.svg(),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.white12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Replies",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "View Activity",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.white12,
                  ),
                ],
              ),
            )
          ];
        },
        body: PagedList<PostComment>(
          key: commentPagedListKey,
          noMoreItemsIndicatorBuilder: (_) => Text("No more comments"),
          noItemsFoundIndicatorBuilder: (_) => Text("Post the first comment"),
          firstPageProgressIndicatorBuilder: (_) => const InfiniteLoader(),
          newPageProgressIndicatorBuilder: (_) => const InfiniteLoader(),
          itemBuilder: (_, comment, i) => PostCommentCard(
            post: newsPost,
            comment: comment,
            newsPostRef: newsPostRef,
          ),
          fetchPage: (_, int pageSize, bool initialFetch) async {
            return PostCommentFetcher.fetchPostsCommentsNews(
              postCollection: channel.collection,
              postId: newsPost.id,
              pageSize: pageSize,
              fromCache: initialFetch,
            );
          },
        ),
      ),
    );
  }
}
