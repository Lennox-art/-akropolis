import 'dart:async';

import 'package:akropolis/data/models/local_models/local_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';

import 'package:akropolis/data/utils/date_format.dart';
import 'package:akropolis/presentation/features/news_feed/models/enums.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/post_comment_detail_post_view_model.dart';
import 'package:akropolis/presentation/ui/components/app_video_player.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/themes.dart';
import 'package:flutter/material.dart';

class PostCommentDetailViewPage extends StatefulWidget {
  const PostCommentDetailViewPage({
    required this.postCommentDetailViewModel,
    super.key,
  });

  final PostCommentDetailtViewModel postCommentDetailViewModel;

  @override
  State<PostCommentDetailViewPage> createState() => _PostCommentDetailViewPageState();
}

class _PostCommentDetailViewPageState extends State<PostCommentDetailViewPage> {
  late final StreamSubscription<PostComment> commentPostedStreamSubscription;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        commentPostedStreamSubscription = widget.postCommentDetailViewModel.postCommentStream.listen(_onCommentPosted);
      },
    );
    super.initState();
  }

  void _onCommentPosted(PostComment comment) {}

  @override
  void dispose() {
    widget.postCommentDetailViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NewsPost newsPost = widget.postCommentDetailViewModel.newsPost;
    NewsChannel newsChannel = widget.postCommentDetailViewModel.newsChannel;
    AppUser currentUser = widget.postCommentDetailViewModel.currentUser;
    PostComment comment = widget.postCommentDetailViewModel.comment;
    ReactionDistribution distribution = ReactionDistribution(newsPost.reaction);

    widget.postCommentDetailViewModel.downloadThumbnail(newsPost.thumbnailUrl);

    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
      backgroundColor: Colors.transparent,
      body: Column(
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
              listenable: widget.postCommentDetailViewModel,
              builder: (_, __) {
                return widget.postCommentDetailViewModel.postMediaState.map(
                  initial: (_) {
                    return widget.postCommentDetailViewModel.thumbnailMediaState.map(
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
                          widget.postCommentDetailViewModel.downloadThumbnail(newsPost.thumbnailUrl);
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
                      widget.postCommentDetailViewModel.downloadPost(
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
        ],
      ),
    );
  }
}
