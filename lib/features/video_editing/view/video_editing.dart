import 'dart:io';

import 'package:akropolis/main.dart';
import 'package:akropolis/utils/duration_style.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class TrimVideoWidget extends StatelessWidget {
  const TrimVideoWidget({
    required this.data,
    required this.onConfirm,
    super.key,
  });

  final File data;
  final Function({required Duration start, required Duration end}) onConfirm;

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
            log.info("Start position ${videoDurationNotifier.value.start.format(DurationStyle.FORMAT_HH_MM_SS)}");
            log.info("End position ${videoDurationNotifier.value.end.format(DurationStyle.FORMAT_HH_MM_SS)}");
            log.info("Current position ${currentPosition.format(DurationStyle.FORMAT_HH_MM_SS)}");

            ///Correct trim
            if (currentPosition.compareTo(videoDurationNotifier.value.start) < 0) {
              controller.seekTo(videoDurationNotifier.value.start);
              controller.pause();
              return;
            }

            if (currentPosition.compareTo(videoDurationNotifier.value.end) > 0) {
              controller.seekTo(videoDurationNotifier.value.end);
              controller.pause();
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
                    valueListenable: controller,
                    builder: (_, videoCtrl, __) {
                      return Visibility(
                        visible: videoCtrl.isPlaying,
                        replacement: IconButton(
                          onPressed: () {
                            controller.play();
                          },
                          icon: const Icon(
                            Icons.play_arrow,
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {
                            controller.pause();
                          },
                          icon: const Icon(
                            Icons.pause,
                          ),
                        ),
                      );
                    }),
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

                            videoDurationNotifier.value = (
                            start: startDuration,
                            end: endDuration,
                            );
                          },
                          labels: RangeLabels(
                            trimmedDuration.start.format(DurationStyle.FORMAT_HH_MM_SS),
                            trimmedDuration.end.format(DurationStyle.FORMAT_HH_MM_SS),
                          ),
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
                          onPressed: () {
                            onConfirm(
                              start: trimmedDuration.start,
                              end: trimmedDuration.end,
                            );
                          },
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
    required this.onConfirm,
    super.key,
  });

  final File data;
  final Function(Duration thumbnailPosition) onConfirm;

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
                        onConfirm(thumbnailPosition);
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