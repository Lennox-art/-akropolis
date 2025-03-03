import 'dart:io';
import 'dart:typed_data';

import 'package:akropolis/main.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/themes.dart';
import 'package:akropolis/data/utils/duration_style.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TrimVideoWidget extends StatelessWidget {
  const TrimVideoWidget({
    required this.thumbnails,
    required this.data,
    required this.onConfirm,
    super.key,
  });

  final File data;
  final List<Uint8List> thumbnails;
  final Function({required Duration start, required Duration end}) onConfirm;
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
              height: 100,
              child: Stack(
                children: [
                  VideoThumbnailTimelineViewer(
                    selectedThumbnail: Uint8List.fromList([]),
                    onSelectThumbnail: (_) {},
                    thumbnails: thumbnails,
                  ),
                  ValueListenableBuilder(
                    valueListenable: videoDurationNotifier,
                    builder: (__, trimmedDuration, ___) {
                      return ValueListenableBuilder(
                        valueListenable: rangeNotifier,
                        builder: (_, values, __) {
                          return SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 2,
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
    required this.videoThumbnails,
    required this.selectedThumbnail,
    required this.onSelect,
    super.key,
  });

  final List<Uint8List> videoThumbnails;
  final Uint8List selectedThumbnail;
  final Function(Uint8List thumbnail) onSelect;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: Image.memory(
            selectedThumbnail,
          ),
        ),
        VideoThumbnailTimelineViewer(
          onSelectThumbnail: onSelect,
          selectedThumbnail: selectedThumbnail,
          thumbnails: videoThumbnails,
        ),
      ],
    );
  }
}

class VideoThumbnailTimelineViewer extends StatelessWidget {
  const VideoThumbnailTimelineViewer({
    required this.onSelectThumbnail,
    required this.selectedThumbnail,
    required this.thumbnails,
    super.key,
  });

  final Uint8List selectedThumbnail;
  final Function(Uint8List) onSelectThumbnail;
  final List<Uint8List> thumbnails;

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 3.0,
        ),
      ),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: thumbnails.map((bytes) {
          return Expanded(
            child: GestureDetector(
              onTap: () => onSelectThumbnail(bytes),
              child: Container(
                decoration: bytes == selectedThumbnail
                    ? BoxDecoration(
                        border: Border.all(
                          width: 2.0,
                          color: bytes == selectedThumbnail ? primaryColor : Colors.transparent,
                        ),
                      )
                    : null,
                child: Image.memory(
                  bytes,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
