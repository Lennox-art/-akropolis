import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

enum EditVideoPostSteps { videoEditing, postDescription }

class EditVideoPostPage extends StatelessWidget {
  const EditVideoPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    File? videoData = ModalRoute.of(context)?.settings.arguments as File?;

    if (videoData == null) {
      return Scaffold(
        body: TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text("No video"),
        ),
      );
    }

    final ValueNotifier<EditVideoPostSteps> stepNotifier = ValueNotifier(
      EditVideoPostSteps.videoEditing,
    );

    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: stepNotifier,
        builder: (_, step, __) {
          return Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: switch (step) {
                  EditVideoPostSteps.videoEditing => VideoEditingWidget(
                      data: videoData,
                    ),
                  EditVideoPostSteps.postDescription => PostDescriptionWidget(
                      data: videoData,
                    ),
                },
              ),
              ListTile(
                trailing: TextButton(
                  onPressed: () {
                    switch (step) {
                      case EditVideoPostSteps.videoEditing:
                        stepNotifier.value = EditVideoPostSteps.postDescription;
                        break;
                      case EditVideoPostSteps.postDescription:
                        //TODO: Post
                        break;
                    }
                  },
                  child: const Text("Next"),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PostDescriptionWidget extends StatelessWidget {
  const PostDescriptionWidget({required this.data, super.key});

  final File data;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

enum VideoEditingTools {
  trimVideo(
    "Trim",
    Icons.cut_outlined,
  ),
  thumbnailPicker(
    "Thumbnail",
    Icons.pages_outlined,
  );

  const VideoEditingTools(this.title, this.iconData);

  final String title;
  final IconData iconData;
}

class VideoEditingWidget extends StatelessWidget {
  const VideoEditingWidget({required this.data, super.key});

  final File data;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<VideoEditingTools> currentToolNotifier = ValueNotifier(
      VideoEditingTools.trimVideo,
    );

    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: currentToolNotifier,
              builder: (_, tool, __) {
                return switch (tool) {
                  VideoEditingTools.trimVideo => TrimVideoWidget(data: data),
                  VideoEditingTools.thumbnailPicker => Container(),
                };
              },
            ),
          ),
          SizedBox(
            height: 80,
            child: Row(
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
      ),
    );
  }
}

class TrimVideoWidget extends StatelessWidget {
  const TrimVideoWidget({required this.data, super.key});

  final File data;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<File> tempDataNotifier = ValueNotifier(data);
    final ValueNotifier<RangeValues> rangeNotifier = ValueNotifier(const RangeValues(0.0, 1.0));

    return ValueListenableBuilder(
      valueListenable: tempDataNotifier,
      builder: (_, file, __) {

        final VideoPlayerController controller = VideoPlayerController.file(
          file,
        );

        return FutureBuilder(
          future: controller.initialize(),
          builder: (_, snap) {

            if(snap.connectionState != ConnectionState.done) {
              return const CircularProgressIndicator.adaptive();
            }

            return Column(
              children: [
                AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(
                    controller,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: rangeNotifier,
                  builder: (_, values, __) {
                    return RangeSlider(
                      values: values,
                      onChanged: (v) {
                        rangeNotifier.value = v;
                      },
                    );
                  }
                ),
              ],
            );
          }
        );
      }
    );
  }
}
