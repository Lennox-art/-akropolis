import 'dart:io';

import 'package:akropolis/main.dart';
import 'package:akropolis/presentation/features/create_post/models/create_post_models.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/news_detail_post_view_model.dart';
import 'package:akropolis/presentation/features/video_editing/view/video_editing.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:flutter/material.dart';

class PostReplyScreenPage extends StatelessWidget {
  const PostReplyScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsDetailPostViewModel newsDetailPostViewModel = ModalRoute.of(context)!.settings.arguments as NewsDetailPostViewModel;
    final ValueNotifier<VideoEditingTools> currentToolNotifier = ValueNotifier(
      VideoEditingTools.trimVideo,
    );
    return ListenableBuilder(
      listenable: newsDetailPostViewModel,
      builder: (_, __) {
        return newsDetailPostViewModel.createPostState.map(
          loading: (_) => const InfiniteLoader(),
          loaded: (l) {
            return Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: VideoEditingWidget(
                    newsDetailPostViewModel: newsDetailPostViewModel,
                    data: newsDetailPostViewModel.videoData!,
                    currentToolNotifier: currentToolNotifier,
                  ),
                ),
                ListTile(
                  trailing: TextButton(
                    onPressed: () async {
                      await newsDetailPostViewModel.doPost();
                      if (!context.mounted) return;
                      Navigator.of(context).pop();
                    },
                    child: const Text("Post"),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class VideoEditingWidget extends StatelessWidget {
  const VideoEditingWidget({
    required this.newsDetailPostViewModel,
    required this.currentToolNotifier,
    required this.data,
    super.key,
  });

  final File data;
  final NewsDetailPostViewModel newsDetailPostViewModel;
  final ValueNotifier<VideoEditingTools> currentToolNotifier;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: currentToolNotifier,
            builder: (_, tool, __) {
              return switch (tool) {
                VideoEditingTools.trimVideo => TrimVideoWidget(
                    data: data,
                    onConfirm: ({
                      required Duration start,
                      required Duration end,
                    }) {
                      log.debug("Modifying trim video");

                      newsDetailPostViewModel.trimVideo(
                        startTime: start,
                        endTime: end,
                      );
                    },
                  ),
                VideoEditingTools.thumbnailPicker => ThumbnailVideoWidget(
                    data: data,
                    onConfirm: (p) {
                      newsDetailPostViewModel.modifyThumbnail(
                        timeInSeconds: p.inSeconds,
                      );
                      log.debug("Modifying thumbnail");
                    },
                  ),
              };
            },
          ),
        ),
        SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: VideoEditingTools.values
                .map(
                  (t) => IconButton(
                    onPressed: () {
                      currentToolNotifier.value = t;
                    },
                    icon: Icon(t.iconData),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
