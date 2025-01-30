import 'dart:typed_data';

import 'package:flutter/material.dart';

enum EditVideoPostSteps { videoEditing, postDescription }

class EditVideoPostPage extends StatelessWidget {
  const EditVideoPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    Uint8List? videoData =
        ModalRoute.of(context)?.settings.arguments as Uint8List?;

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
                      videoData: videoData,
                    ),
                  EditVideoPostSteps.postDescription => PostDescriptionWidget(
                      videoData: videoData,
                    ),
                },
              ),
              ListTile(
                trailing: TextButton(
                  onPressed: () {
                    switch(step) {

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
  const PostDescriptionWidget({required this.videoData, super.key});

  final Uint8List videoData;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class VideoEditingWidget extends StatelessWidget {
  const VideoEditingWidget({required this.videoData, super.key});

  final Uint8List videoData;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
