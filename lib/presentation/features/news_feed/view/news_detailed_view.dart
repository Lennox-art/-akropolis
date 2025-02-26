import 'dart:async';
import 'dart:io';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/local_models/local_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/gen/assets.gen.dart';
import 'package:akropolis/main.dart';

import 'package:akropolis/data/utils/constants.dart';
import 'package:akropolis/data/utils/date_format.dart';
import 'package:akropolis/data/utils/validations.dart';
import 'package:akropolis/presentation/features/news_feed/models/enums.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/news_detail_post_view_model.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/components/app_video_player.dart';
import 'package:akropolis/presentation/ui/components/duration_picker.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/news_post_components.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paged_list_view/paged_list_view.dart';

import 'news_card.dart';

class NewsDetailedViewPage extends StatefulWidget {
  const NewsDetailedViewPage({
    super.key,
  });


  @override
  State<NewsDetailedViewPage> createState() => _NewsDetailedViewPageState();
}

class _NewsDetailedViewPageState extends State<NewsDetailedViewPage> {
  late final StreamSubscription<PostComment> commentPostedStreamSubscription;
  late final NewsDetailPostViewModel newsDetailPostViewModel = ModalRoute.of(context)!.settings.arguments as NewsDetailPostViewModel;

  @override
  void initState() {
    commentPostedStreamSubscription = newsDetailPostViewModel.postCommentStream.listen(_onCommentPosted);
    super.initState();
  }

  void _onCommentPosted(PostComment comment) {}

  @override
  void dispose() {
    newsDetailPostViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  
    

   
    final GlobalKey<PagedListState> commentPagedListKey = GlobalKey<PagedListState>();

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

                String? videoError = await validateVideo(videoData.path);
                if (!context.mounted) return;

                if (videoError != null) {
                  ToastError(title: "Post Video", message: videoError).show();
                  return;
                }

                await newsDetailPostViewModel.setVideo(
                  File(videoData.path)
                    ..writeAsBytesSync(
                      await videoData.readAsBytes(),
                    ),
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

                                  if (newsDetailPostViewModel.newsPost.author.imageUrl == null) {
                                    return const Icon(Icons.person);
                                  }

                                  return CircleAvatar(
                                    backgroundImage: NetworkImage(newsDetailPostViewModel.newsPost.author.imageUrl!),
                                  );
                                },
                              ),
                            ),
                            Text(newsDetailPostViewModel.newsPost.author.name),
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
                  ListenableBuilder(
                    listenable: newsDetailPostViewModel,
                    builder: (_, __) {
                      return newsDetailPostViewModel.createPostState.map(
                        loading: (l) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Posting comment",
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
                        loaded: (_) => const SizedBox.shrink(),
                      );
                    },
                  ),
                  /* Container(
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
                  ),*/
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                    child: Text(
                      newsDetailPostViewModel.newsPost.description,
                      style: theme.textTheme.labelLarge,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                    child: Text(
                      newsDetailPostViewModel.newsPost.publishedAt.commentDateTime,
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
                              child: NewsPostReactionWidget(
                                newsPost: newsDetailPostViewModel.newsPost,
                                currentUser: newsDetailPostViewModel.currentUser,
                                onEmpathy: () {},
                                onLogician: () {},
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
                                    ListenableBuilder(
                                      listenable: newsDetailPostViewModel,
                                      builder: (_, __) {
                                        return Visibility(
                                          visible: newsDetailPostViewModel.commentCount != null,
                                          replacement: const Icon(Icons.question_mark),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                                            child: Text((newsDetailPostViewModel.commentCount ?? 0).toString()),
                                          ),
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
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Replies",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
          noMoreItemsIndicatorBuilder: (_) => const Text("No more comments"),
          noItemsFoundIndicatorBuilder: (_) => const Text("Post the first comment"),
          firstPageProgressIndicatorBuilder: (_) => const InfiniteLoader(),
          newPageProgressIndicatorBuilder: (_) => const InfiniteLoader(),
          itemBuilder: (_, comment, i) => PostCommentCard(
            post: newsDetailPostViewModel.newsPost,
            comment: comment,
            currentUser: newsDetailPostViewModel.currentUser,
          ),
          fetchPage: (_, int pageSize, bool initialFetch) async {
            Result<List<PostComment>?> fetchCommentResult = await newsDetailPostViewModel.fetchPostComments(
              pageSize: pageSize,
              fromCache: initialFetch,
            );

            switch (fetchCommentResult) {
              case Success<List<PostComment>?>():
                return fetchCommentResult.data;

              case Error<List<PostComment>?>():
                ToastError(title: "Post comments", message: fetchCommentResult.failure.message).show();
                return [];
            }
          },
        ),
      ),
    );
  }
}
