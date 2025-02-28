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
import 'package:akropolis/presentation/features/news_feed/view_models/reply_post_view_model.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/components/app_video_player.dart';
import 'package:akropolis/presentation/ui/components/duration_picker.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/news_post_components.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paged_list_view/paged_list_view.dart';

import 'news_card.dart';

class NewsDetailedViewPage extends StatefulWidget {
  const NewsDetailedViewPage({
    required this.newsDetailPostViewModel,
    super.key,
  });

  final NewsDetailPostViewModel newsDetailPostViewModel;

  @override
  State<NewsDetailedViewPage> createState() => _NewsDetailedViewPageState();
}

class _NewsDetailedViewPageState extends State<NewsDetailedViewPage> {
  late final StreamSubscription<PostComment> commentPostedStreamSubscription;
  late final ReplyPostViewModel replyPostViewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        commentPostedStreamSubscription = widget.newsDetailPostViewModel.postCommentStream.listen(_onCommentPosted);
      },
    );
    super.initState();
  }

  void _onCommentPosted(PostComment comment) {}

  @override
  void dispose() {
    widget.newsDetailPostViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NewsPostDto newsPostDto = ModalRoute.of(context)!.settings.arguments as NewsPostDto;
    NewsPost newsPost = newsPostDto.newsPost;
    NewsChannel newsChannel = newsPostDto.channel;
    AppUser currentUser = newsPostDto.currentUser;

    widget.newsDetailPostViewModel.downloadThumbnail(newsPost.thumbnailUrl);


    final GlobalKey<PagedListState> commentPagedListKey = GlobalKey<PagedListState>();
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (_, innerBoxIsScrolled) {
          return [
            const SliverAppBar(
              backgroundColor: Colors.transparent,
              floating: true,
              actions: [
                /*Padding(
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

                await widget.newsDetailPostViewModel.setVideo(
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
          ),*/
              ],
            ),
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
                  Container(
                    height: 400,
                    color: Colors.black12,
                    child: ListenableBuilder(
                      listenable: widget.newsDetailPostViewModel,
                      builder: (_, __) {
                        return widget.newsDetailPostViewModel.postMediaState.map(
                          initial: (_) {
                            return widget.newsDetailPostViewModel.thumbnailMediaState.map(
                              initial: (_) => const SizedBox.shrink(),
                              downloadingMedia: (d) {
                                if (d.progress == null) {
                                  return const InfiniteLoader();
                                }

                                return CircularFiniteLoader(progress: d.progress!);
                              },
                              downloadedMedia: (d) {
                                return Image.file(
                                  d.media.file,
                                  height: 350,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                );
                              },
                              errorDownloadingMedia: (e) => IconButton(
                                onPressed: () {
                                  widget.newsDetailPostViewModel.downloadThumbnail(newsPost.thumbnailUrl);
                                },
                                icon: const Icon(
                                  Icons.broken_image_outlined,
                                ),
                              ),
                            );
                          },
                          downloadingMedia: (d) {
                            if (d.progress == null) {
                              return const InfiniteLoader();
                            }

                            return CircularFiniteLoader(progress: d.progress!);
                          },
                          downloadedMedia: (d) {
                            switch (d.media.mediaType) {
                              case MediaType.image:
                                return Image.file(
                                  d.media.file,
                                  height: 350,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                );
                              case MediaType.video:
                                return CachedVideoPlayer(
                                  file: d.media.file,
                                  autoPlay: true,
                                );
                            }
                          },
                          errorDownloadingMedia: (e) => IconButton(
                            onPressed: () {
                              widget.newsDetailPostViewModel.downloadPost(
                                newsPost.postUrl,
                              );
                            },
                            icon: const Icon(
                              Icons.broken_image_outlined,
                            ),
                          ),
                        );
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
                              child: NewsPostReactionWidget(
                                newsPost: newsPost,
                                currentUser: currentUser,
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
                                      listenable: widget.newsDetailPostViewModel,
                                      builder: (_, __) {
                                        return Visibility(
                                          visible: widget.newsDetailPostViewModel.commentCount != null,
                                          replacement: const Icon(Icons.question_mark),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                                            child: Text((widget.newsDetailPostViewModel.commentCount ?? 0).toString()),
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
            ),
          ];
        },
        body: PagedList<PostComment>(
          key: commentPagedListKey,
          noMoreItemsIndicatorBuilder: (_) => const Text("No more comments"),
          noItemsFoundIndicatorBuilder: (_) => const Text("Post the first comment"),
          firstPageProgressIndicatorBuilder: (_) => const InfiniteLoader(),
          newPageProgressIndicatorBuilder: (_) => const InfiniteLoader(),
          itemBuilder: (_, comment, i) => PostCommentCard(
            post: newsPost,
            comment: comment,
            currentUser: currentUser,
          ),
          fetchPage: (_, int pageSize, bool initialFetch) async {
            Result<List<PostComment>?> fetchCommentResult = await widget.newsDetailPostViewModel.fetchPostComments(
              postId: newsPost.id,
              postCollection: newsChannel.collection,
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
