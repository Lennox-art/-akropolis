import 'dart:io';
import 'dart:typed_data';

import 'package:akropolis/features/create_post/models/models.dart';
import 'package:akropolis/features/create_post/view_model/create_post_cubit.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/routes/routes.dart';
import 'package:akropolis/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class EditVideoPostPage extends StatelessWidget {
  const EditVideoPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CreatePostCubit, CreatePostState>(
        builder: (_, state) {
          return state.map(
            loading: (_) => const CircularProgressIndicator.adaptive(),
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
                        videoDuration: Duration.zero,
                      ),
                    ),
                  ),
                  ListTile(
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
    );
  }
}

class VideoEditingWidget extends StatelessWidget {
  const VideoEditingWidget({
    required this.data,
    required this.videoDuration,
    super.key,
  });

  final File data;
  final Duration videoDuration;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<VideoEditingTools> currentToolNotifier = ValueNotifier(
      VideoEditingTools.trimVideo,
    );

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
                    onTrim: (vid) {

                    },
                  ),
                VideoEditingTools.thumbnailPicker => ThumbnailVideoWidget(
                    data: data,
                    videoDuration: videoDuration,
                    onSelect: (data) {
                      log.debug("Modifying thumbnail");
                      BlocProvider.of<CreatePostCubit>(context).modifyThumbnail(thumbnail: data);
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

class TrimVideoWidget extends StatelessWidget {
  const TrimVideoWidget({
    required this.data,
    required this.onTrim,
    super.key,
  });

  final File data;
  final Function(File) onTrim;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<DurationTrim> rangeNotifier = ValueNotifier(
      const DurationTrim.create(duration: Duration()),
    );
    final VideoPlayerController controller = VideoPlayerController.file(data);

    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: FutureBuilder(
            future: controller.initialize(),
            builder: (_, vidSnap) {
              if (vidSnap.connectionState != ConnectionState.done) {
                return const CircularProgressIndicator.adaptive();
              }

              rangeNotifier.value = DurationTrim.create(
                duration: controller.value.duration,
              );

              return AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              );
            },
          ),
        ),
        ValueListenableBuilder(
          valueListenable: rangeNotifier,
          builder: (_, values, __) {
            return RangeSlider(
              values: RangeValues(values.start, values.end),
              onChanged: (v) {
                // v.end;
              },
            );
          },
        ),
      ],
    );
  }
}

class ThumbnailVideoWidget extends StatelessWidget {
  const ThumbnailVideoWidget({
    required this.data,
    required this.videoDuration,
    required this.onSelect,
    super.key,
  });

  final File data;
  final Duration? videoDuration;
  final Function(Uint8List) onSelect;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Uint8List?> thumbnailNotifier = ValueNotifier(null);
    final ValueNotifier<double> durationNotifier = ValueNotifier(0.0);

    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: ValueListenableBuilder(
              valueListenable: thumbnailNotifier,
              builder: (_, thumbNail, __) {
                if (thumbNail == null) {
                  return const Text("Select thumbnail");
                }

                return SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.memory(thumbNail),
                );
              }),
        ),
        ValueListenableBuilder(
          valueListenable: durationNotifier,
          builder: (_, values, __) {
            return Slider(
              value: values,
              onChanged: (v) async {
                durationNotifier.value = v;
                final uint8list = await generateThumbnailBytes(
                  videoPath: data.path,
                  quality: 50,
                  timeMs: v.round(),
                );
                thumbnailNotifier.value = uint8list;
                if (uint8list != null) {
                  onSelect(uint8list);
                }
              },
            );
          },
        ),
      ],
    );
  }
}
