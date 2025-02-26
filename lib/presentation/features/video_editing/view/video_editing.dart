import 'dart:io';
import 'dart:typed_data';

import 'package:akropolis/main.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/themes.dart';
import 'package:akropolis/data/utils/duration_style.dart';
import 'package:akropolis/domain/utils/functions.dart';
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
  final double thumbnailHeight = 100;
  final int divisions = 8;

  @override
  Widget build(BuildContext context) {
    final VideoPlayerController controller = VideoPlayerController.file(data);

    return FutureBuilder(
      future: controller.initialize(),
      builder: (_, vidSnap) {
        if (vidSnap.connectionState != ConnectionState.done) {
          return const InfiniteLoader();
        }

        final Duration originalVideoDuration = controller.value.duration;

        final ValueNotifier<RangeValues> rangeNotifier = ValueNotifier(
          RangeValues(Duration.zero.inMilliseconds.toDouble(), originalVideoDuration.inMilliseconds.toDouble()),
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
              },
            ),
            SizedBox(
              height: thumbnailHeight,
              width: 300,
              child: Stack(
                children: [
                  VideoThumbnailTimelineViewer(
                    videoFile: data,
                    division: divisions,
                    height: thumbnailHeight,
                  ),
                  ValueListenableBuilder(
                    valueListenable: videoDurationNotifier,
                    builder: (__, trimmedDuration, ___) {
                      return ValueListenableBuilder(
                        valueListenable: rangeNotifier,
                        builder: (_, values, __) {
                          return SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: thumbnailHeight,
                              trackShape: const RectangularSliderTrackShape(),
                              activeTrackColor: primaryColor.withValues(alpha: 0.6),
                              inactiveTrackColor: Colors.transparent,
                            ),
                            child: RangeSlider(
                              values: RangeValues(values.start, values.end),
                              onChanged: (v) {
                                rangeNotifier.value = v;

                                videoDurationNotifier.value = (
                                  start: Duration(milliseconds: v.start.toInt()),
                                  end: Duration(milliseconds: v.end.toInt()),
                                );
                              },
                              min: Duration.zero.inMilliseconds.toDouble(),
                              max: originalVideoDuration.inMilliseconds.toDouble(),
                              labels: RangeLabels(
                                trimmedDuration.start.format(DurationStyle.FORMAT_HH_MM_SS),
                                trimmedDuration.end.format(DurationStyle.FORMAT_HH_MM_SS),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(Duration.zero.format(DurationStyle.FORMAT_HH_MM_SS)),
                Text(originalVideoDuration.format(DurationStyle.FORMAT_HH_MM_SS)),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                onConfirm(
                  start: videoDurationNotifier.value.start,
                  end: videoDurationNotifier.value.end,
                );
              },
              child: const Text("Trim"),
            ),
          ],
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
  final double thumbnailHeight = 100;
  final int divisions = 8;

  @override
  Widget build(BuildContext context) {
    final VideoPlayerController controller = VideoPlayerController.file(data);

    return FutureBuilder(
      future: controller.initialize(),
      builder: (_, vidSnap) {
        if (vidSnap.connectionState != ConnectionState.done) {
          return const InfiniteLoader();
        }

        final Duration originalVideoDuration = controller.value.duration;
        final ValueNotifier<Duration> thumbnailPositionNotifier = ValueNotifier(Duration.zero);

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
                SizedBox(
                  height: thumbnailHeight,
                  width: 300,
                  child: Stack(
                    children: [
                      VideoThumbnailTimelineViewer(
                        videoFile: data,
                        division: divisions,
                        height: thumbnailHeight,
                      ),
                      ValueListenableBuilder(
                        valueListenable: thumbnailPositionNotifier,
                        builder: (__, thumbnailPosition, ___) {
                          return SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              overlayShape: SliderComponentShape.noThumb,
                              trackHeight: thumbnailHeight,
                              trackShape: const RectangularSliderTrackShape(),
                              activeTrackColor: Colors.transparent,
                              inactiveTrackColor: Colors.transparent,
                            ),
                            child: Slider(
                              value: thumbnailPosition.inMilliseconds.toDouble(),
                              onChanged: (v) {
                                Duration updatedDuration = Duration(milliseconds: v.round());
                                thumbnailPositionNotifier.value = updatedDuration;
                                controller.seekTo(updatedDuration);
                              },
                              min: Duration.zero.inMilliseconds.toDouble(),
                              max: originalVideoDuration.inMilliseconds.toDouble(),
                              label: thumbnailPosition.format(DurationStyle.FORMAT_MM_SS_MS),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => onConfirm(thumbnailPositionNotifier.value),
                  child: const Text("Select thumbnail"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class VideoThumbnailTimelineViewer extends StatelessWidget {
  const VideoThumbnailTimelineViewer({
    required this.videoFile,
    required this.division,
    required this.height,
    super.key,
  });

  final File videoFile;
  final int division;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(8.0),
      decoration:  BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(18),
        ),
          border: Border.all(
            color: Colors.white,
            width: 3.0,
          ),
      ),
      child: FutureBuilder(
        future: generateThumbnails(
          videoPath: videoFile.path,
          count: division,
        ),
        builder: (_, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const InfiniteLoader();
          }

          List<Uint8List> thumbnails = snap.data ?? [];

          return Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: thumbnails.map((bytes) {
              return Expanded(
                child: Image.memory(
                  bytes,
                  height: height,
                  fit: BoxFit.fill,
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
