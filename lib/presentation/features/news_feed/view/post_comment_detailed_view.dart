import 'dart:async';

import 'package:akropolis/data/models/local_models/local_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';

import 'package:akropolis/data/utils/date_format.dart';
import 'package:akropolis/presentation/features/news_feed/models/enums.dart';
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

  final PostCommentDetailViewModel postCommentDetailViewModel;

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
        widget.postCommentDetailViewModel.downloadThumbnail();
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
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
                          if (widget.postCommentDetailViewModel.newsPost.newsPost.author.imageUrl == null) {
                            return const Icon(Icons.person);
                          }

                          return CircleAvatar(
                            backgroundImage: NetworkImage(widget.postCommentDetailViewModel.newsPost.newsPost.author.imageUrl!),
                          );
                        },
                      ),
                    ),
                    Text(widget.postCommentDetailViewModel.newsPost.newsPost.author.name),
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
                              onPressed: widget.postCommentDetailViewModel.downloadPost,
                              icon: const Icon(
                                Icons.play_arrow,
                                size: 25,
                              ),
                            ),
                          ],
                        );
                      },
                      errorDownloadingMedia: (e) => IconButton(
                        onPressed: widget.postCommentDetailViewModel.downloadThumbnail,
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
                    onPressed: widget.postCommentDetailViewModel.downloadPost,
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
              widget.postCommentDetailViewModel.comment.commentedAt.commentDateTime,
              style: theme.textTheme.labelMedium?.copyWith(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          ListenableBuilder(
            listenable: widget.postCommentDetailViewModel,
            builder: (_, __) {
              return Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: widget.postCommentDetailViewModel.distribution.logFlex,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        "${widget.postCommentDetailViewModel.distribution.logPercent} % (${widget.postCommentDetailViewModel.distribution.logCount})",
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: widget.postCommentDetailViewModel.distribution.empFlex,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                      decoration: const BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        "${widget.postCommentDetailViewModel.distribution.empPercent} % (${widget.postCommentDetailViewModel.distribution.empCount})",
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ),
                ],
              );
            }
          ),
        ],
      ),
      bottomNavigationBar: ListenableBuilder(
          listenable: widget.postCommentDetailViewModel,
          builder: (_, __) {
            return Container(
              color: Colors.white12,
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton(
                        onPressed: widget.postCommentDetailViewModel.alreadyReacted ? null : widget.postCommentDetailViewModel.log,
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            widget.postCommentDetailViewModel.isLogReaction ? logicianColor : Colors.transparent,
                          ),
                          foregroundColor: WidgetStateProperty.all(
                            widget.postCommentDetailViewModel.isLogReaction ? secondaryColor : logicianColor,
                          ),
                          side: const WidgetStatePropertyAll(
                            BorderSide(color: logicianColor, width: 1.0),
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text("Logician"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton(
                        onPressed: widget.postCommentDetailViewModel.alreadyReacted ? null : widget.postCommentDetailViewModel.emp,
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(widget.postCommentDetailViewModel.isEmpReaction ? empathyColor : Colors.transparent),
                          foregroundColor: WidgetStateProperty.all(widget.postCommentDetailViewModel.isEmpReaction ? secondaryColor : empathyColor),
                          side: const WidgetStatePropertyAll(
                            BorderSide(color: empathyColor, width: 1.0),
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text("Empath"),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}