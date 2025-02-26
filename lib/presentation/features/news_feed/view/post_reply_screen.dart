import 'dart:io';


import 'package:akropolis/main.dart';
import 'package:akropolis/presentation/features/create_post/models/create_post_models.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/post_news_post_reply_cubit/post_news_post_reply_cubit.dart';
import 'package:akropolis/presentation/features/video_editing/view/video_editing.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostReplyScreenPage extends StatelessWidget {
  const PostReplyScreenPage({super.key});

  @override
  Widget build(BuildContext context) {

    final ValueNotifier<VideoEditingTools> currentToolNotifier = ValueNotifier(
      VideoEditingTools.trimVideo,
    );

    return Scaffold(
      body: BlocBuilder<PostVideoReplyCubit, PostVideoReplyState>(
        builder: (_, state) {
          return state.map(
            loading: (_) => const Center(
              child: InfiniteLoader(),
            ),
            loaded: (l) {
              return Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Visibility(
                      visible: l.replyForm != null,
                      child: VideoEditingWidget(
                        data: l.replyForm!._videoData!,
                        currentToolNotifier: currentToolNotifier,
                      ),
                    ),
                  ),
                  ListTile(
                    trailing: TextButton(
                      onPressed: () {
                        BlocProvider.of<PostVideoReplyCubit>(context).doPost();
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
      ),
    );
  }
}

class VideoEditingWidget extends StatelessWidget {
  const VideoEditingWidget({
    required this.currentToolNotifier,
    required this.data,
    super.key,
  });

  final File data;
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

                      BlocProvider.of<PostVideoReplyCubit>(context).trimVideo(
                        startTime: start,
                        endTime: end,
                      );
                    },
                  ),
                VideoEditingTools.thumbnailPicker => ThumbnailVideoWidget(
                    data: data,
                    onConfirm: (p) {
                      BlocProvider.of<PostVideoReplyCubit>(context).modifyThumbnail(
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