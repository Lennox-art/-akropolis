import 'dart:io';

import 'package:akropolis/features/create_post/models/models.dart';
import 'package:akropolis/features/create_post/view_model/create_post_cubit.dart';
import 'package:akropolis/features/video_editing/view/video_editing.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/routes/routes.dart';
import 'package:akropolis/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:akropolis/components/loader.dart';

class EditVideoPostPage extends StatelessWidget {
  const EditVideoPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<VideoEditingTools> currentToolNotifier = ValueNotifier(
      VideoEditingTools.trimVideo,
    );

    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<CreatePostCubit, CreatePostState>(
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
                        visible: l.form != null,
                        child: VideoEditingWidget(
                          data: l.form!.videoData!,
                          currentToolNotifier: currentToolNotifier,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      trailing: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.finalizePost.path,
                          );
                        },
                        child: const Text("Next"),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
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
    return ValueListenableBuilder(
      valueListenable: currentToolNotifier,
      builder: (_, tool, __) {
        return Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: switch (tool) {
                VideoEditingTools.trimVideo => TrimVideoWidget(
                    data: data,
                    onConfirm: ({
                      required Duration start,
                      required Duration end,
                    }) {
                      log.debug("Modifying trim video");

                      BlocProvider.of<CreatePostCubit>(context).trimVideo(
                        startTime: start,
                        endTime: end,
                      );
                    },
                  ),
                VideoEditingTools.thumbnailPicker => ThumbnailVideoWidget(
                    data: data,
                    onConfirm: (p) {
                      BlocProvider.of<CreatePostCubit>(context).modifyThumbnail(
                        timeInSeconds: p.inSeconds,
                      );
                      log.debug("Modifying thumbnail");
                    },
                  ),
              },
            ),
            SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: VideoEditingTools.values
                    .map(
                      (t) => Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              currentToolNotifier.value = t;
                            },
                            icon: Icon(t.iconData),
                            color: t == tool ? primaryColor : Colors.white70,
                          ),
                          Text(t.title),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
