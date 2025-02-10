import 'dart:io';
import 'dart:typed_data';

import 'package:akropolis/features/create_post/models/models.dart';
import 'package:akropolis/features/create_post/view_model/create_post_cubit.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/routes/routes.dart';
import 'package:akropolis/utils/duration_style.dart';
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
    super.key,
  });

  final File data;

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
                    onTrim: (vid) {},
                  ),
                VideoEditingTools.thumbnailPicker => ThumbnailVideoWidget(
                    data: data,
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
    final VideoPlayerController controller = VideoPlayerController.file(data);

    return FutureBuilder(
      future: controller.initialize(),
      builder: (_, vidSnap) {
        if (vidSnap.connectionState != ConnectionState.done) {
          return const CircularProgressIndicator.adaptive();
        }

        final Duration originalVideoDuration = controller.value.duration;

        final ValueNotifier<RangeValues> rangeNotifier = ValueNotifier(
          const RangeValues(0.0, 1.0),
        );

        final ValueNotifier<({Duration start, Duration end})> videoDurationNotifier = ValueNotifier(
          (start: Duration.zero, end: originalVideoDuration),
        );

        controller.addListener(
          () {
            Duration currentPosition = controller.value.position;

            ///Correct trim
            if (currentPosition.compareTo(videoDurationNotifier.value.start) < 0) {
              controller.seekTo(videoDurationNotifier.value.start);
              return;
            }

            if (currentPosition.compareTo(videoDurationNotifier.value.end) > 0) {
              controller.seekTo(videoDurationNotifier.value.end);
              return;
            }
          },
        );

        return ValueListenableBuilder(
          valueListenable: videoDurationNotifier,
          builder: (__, trimmedDuration, ___) {
            return Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: rangeNotifier,
                  builder: (_, values, __) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RangeSlider(
                          values: RangeValues(values.start, values.end),
                          onChanged: (v) {
                            rangeNotifier.value = v;

                            double startTimeInS = (values.start * originalVideoDuration.inSeconds) / 1.0;
                            Duration startDuration = Duration(seconds: startTimeInS.round());

                            double endTimeInS = (values.end * originalVideoDuration.inSeconds) / 1.0;
                            Duration endDuration = Duration(seconds: endTimeInS.round());

                            videoDurationNotifier.value = (start: startDuration, end: endDuration);
                          },
                          activeColor: Colors.green,
                          inactiveColor: Colors.red,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(trimmedDuration.start.format(DurationStyle.FORMAT_HH_MM_SS)),
                            Text(trimmedDuration.end.format(DurationStyle.FORMAT_HH_MM_SS)),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("Trim"),
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class ThumbnailVideoWidget extends StatelessWidget {
  const ThumbnailVideoWidget({
    required this.data,
    required this.onSelect,
    super.key,
  });

  final File data;
  final Function(Uint8List) onSelect;

  @override
  Widget build(BuildContext context) {
    final VideoPlayerController controller = VideoPlayerController.file(data);

    return FutureBuilder(
      future: controller.initialize(),
      builder: (_, vidSnap) {
        if (vidSnap.connectionState != ConnectionState.done) {
          return const CircularProgressIndicator.adaptive();
        }

        final Duration originalVideoDuration = controller.value.duration;
        final ValueNotifier<Duration> thumbnailPositionNotifier = ValueNotifier(Duration.zero);

        return ValueListenableBuilder(
          valueListenable: thumbnailPositionNotifier,
          builder: (__, thumbnailPosition, ___) {
            //1.0 = originalVideoDuration
            // thumbnailPosition
            double sliderPosition = (thumbnailPosition.inSeconds * 1.0) / originalVideoDuration.inSeconds;

            return Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Slider(
                      value: sliderPosition,
                      onChanged: (v) {
                        double updatedDurationInS = (v * originalVideoDuration.inSeconds) / 1.0;
                        Duration updatedDuration = Duration(seconds: updatedDurationInS.round());
                        thumbnailPositionNotifier.value = updatedDuration;
                        controller.seekTo(updatedDuration);
                      },
                      activeColor: Colors.green,
                      inactiveColor: Colors.red,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Uint8List? thumbnailData = await generateThumbnail(
                          videoPath: data.path,
                          timeInSeconds: thumbnailPosition.inSeconds,
                        );
                        if(thumbnailData == null) return;
                        onSelect(thumbnailData);
                      },
                      child: const Text("Select thumbnail"),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
