
import 'package:akropolis/main.dart';
import 'package:akropolis/presentation/features/create_post/models/create_post_models.dart';
import 'package:akropolis/presentation/features/create_post/view_model/create_post_view_model.dart';
import 'package:akropolis/presentation/features/video_editing/view/video_editing.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/themes.dart';
import 'package:flutter/material.dart';

class EditVideoPostPage extends StatefulWidget {
  const EditVideoPostPage({
    required this.createPostViewModel,
    super.key,
  });

  final CreatePostViewModel createPostViewModel;

  @override
  State<EditVideoPostPage> createState() => _EditVideoPostPageState();
}

class _EditVideoPostPageState extends State<EditVideoPostPage> {
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<VideoEditingTools> currentToolNotifier = ValueNotifier(
      VideoEditingTools.trimVideo,
    );

    return SafeArea(
      child: Scaffold(
        body: ListenableBuilder(

          listenable: widget.createPostViewModel,
          builder: (_, __) {
            return widget.createPostViewModel.createPostState.map(
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
                      child: VideoEditingWidget(
                        createPostViewModel: widget.createPostViewModel,
                        currentToolNotifier: currentToolNotifier,
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
    required this.createPostViewModel,
    super.key,
  });

  final ValueNotifier<VideoEditingTools> currentToolNotifier;
  final CreatePostViewModel createPostViewModel;

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
                    data: createPostViewModel.videoData!,
                    onConfirm: ({
                      required Duration start,
                      required Duration end,
                    }) {
                      log.debug("Modifying trim video");

                      createPostViewModel.trimVideo(
                        startTime: start,
                        endTime: end,
                      );
                    },
                  ),
                VideoEditingTools.thumbnailPicker => ThumbnailVideoWidget(
                    data: createPostViewModel.videoData!,
                    onConfirm: (p) {
                      createPostViewModel.modifyThumbnail(
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
