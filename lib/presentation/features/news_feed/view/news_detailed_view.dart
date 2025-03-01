import 'dart:async';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/local_models/local_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/use_cases/get_media_use_case.dart';

import 'package:akropolis/data/utils/date_format.dart';
import 'package:akropolis/presentation/features/news_feed/models/enums.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/news_detail_post_view_model.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/post_comment_card_view_model.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/reply_post_view_model.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/components/app_video_player.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/page_list_widgets.dart';
import 'package:akropolis/presentation/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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
  late final NewsPost newsPost = widget.newsDetailPostViewModel.newsPost;
  late final NewsChannel newsChannel = widget.newsDetailPostViewModel.newsChannel;
  late final AppUser currentUser = widget.newsDetailPostViewModel.currentUser;
  final PageWrapper page = PageWrapper();

  late final PagingController<int, PostComment> pagingController = PagingController(
    firstPageKey: page.page,
  );

  Future<void> _fetchPageItems() async {
    try {
      Result<List<PostComment>?> fetchCommentsResult = await widget.newsDetailPostViewModel.fetchPostComments(
        postCollection: newsChannel.collection,
        postId: newsPost.id,
        pageSize: PageWrapper.pageSize,
        fromCache: page.initialFetch,
      );

      switch (fetchCommentsResult) {
        case Success<List<PostComment>?>():
          if (page.initialFetch) page.initialFetch = false;
          List<PostComment> newItems = fetchCommentsResult.data ?? [];
          int noOfNewItems = newItems.length;

          final isLastPage = noOfNewItems < PageWrapper.pageSize;
          if (isLastPage) {
            pagingController.appendLastPage(newItems);
            return;
          }

          final int nextPageKey = page.page++;
          pagingController.appendPage(newItems, nextPageKey);

          return;
        case Error<List<PostComment>?>():
          pagingController.error = fetchCommentsResult.failure.message;
          return;
      }
    } catch (error, trace) {
      pagingController.error = error;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        commentPostedStreamSubscription = widget.newsDetailPostViewModel.postCommentStream.listen(_onCommentPosted);
      },
    );
    pagingController.addPageRequestListener((p) {
      page.page = p;
      _fetchPageItems();
    });
    super.initState();
  }

  void _onCommentPosted(PostComment comment) {}

  @override
  void dispose() {
    widget.newsDetailPostViewModel.dispose();
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ReactionDistribution distribution = ReactionDistribution(newsPost.reaction);

    widget.newsDetailPostViewModel.downloadThumbnail(newsPost.thumbnailUrl);
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: null,
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
      body: ListView(
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
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.file(
                              d.media.file,
                              height: 350,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            IconButton(
                              onPressed: () {
                                widget.newsDetailPostViewModel.downloadPost(
                                  newsPost.postUrl,
                                );
                              },
                              icon: const Icon(
                                Icons.play_arrow,
                                size: 25,
                              ),
                            ),
                          ],
                        );
                      },
                      errorDownloadingMedia: (e) => IconButton(
                        onPressed: () {
                          widget.newsDetailPostViewModel.downloadThumbnail(newsPost.thumbnailUrl);
                        },
                        icon: const Icon(
                          Icons.refresh,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "View Post Activity",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: distribution.logFlex,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    "${distribution.logPercent} % (${distribution.logCount})",
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                flex: distribution.empFlex,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                  decoration: const BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    "${distribution.empPercent} % (${distribution.empCount})",
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.white12,
          ),
          PagedGridView<int, PostComment>(
            shrinkWrap: true,
            showNewPageProgressIndicatorAsGridChild: false,
            showNewPageErrorIndicatorAsGridChild: false,
            showNoMoreItemsIndicatorAsGridChild: false,
            pagingController: pagingController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 100 / 150,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
            ),
            physics: const NeverScrollableScrollPhysics(),
            builderDelegate: pagedChildBuilderDelegate(
              context: context,
              itemBuilder: (_, comment, i) => GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.newsCommentDetailsPage.path,
                    arguments: NewsPostCommentDto(
                      newsPost,
                      newsChannel,
                      currentUser,
                      comment,
                    ),
                  );
                },
                child: PostCommentCard(
                  postCommentCardViewModel: PostCommentCardViewModel(
                      comment: comment,
                      getMediaUseCase: GetMediaUseCase(
                        localDataStorageService: GetIt.I(),
                        localFileStorageService: GetIt.I(),
                        remoteFileStorageService: GetIt.I(),
                      )),
                  post: newsPost,
                  comment: comment,
                  currentUser: currentUser,
                ),
              ),
              fetchPageItems: _fetchPageItems,
            ),
          ),
        ],
      ),
    );
  }
}
