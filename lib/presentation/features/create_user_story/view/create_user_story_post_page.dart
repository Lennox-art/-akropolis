import 'dart:async';
import 'dart:io';

import 'package:akropolis/main.dart';
import 'package:akropolis/presentation/features/create_post/models/create_post_models.dart';
import 'package:akropolis/presentation/features/create_user_story/models/create_user_story_post_models.dart';
import 'package:akropolis/presentation/features/create_user_story/view_model/create_user_story_post_view_model.dart';
import 'package:akropolis/presentation/features/video_editing/view/video_editing.dart';
import 'package:akropolis/presentation/ui/components/duration_picker.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:akropolis/presentation/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateUserPostPage extends StatefulWidget {
  const CreateUserPostPage({
    required this.createUserPostViewModel,
    super.key,
  });

  final CreateUserPostViewModel createUserPostViewModel;

  @override
  State<CreateUserPostPage> createState() => _CreateUserPostPageState();
}

class _CreateUserPostPageState extends State<CreateUserPostPage> {
  late final StreamSubscription<ToastMessage> toastStreamSubscription;
  late final StreamSubscription<CreateUserStoryPostState> createPostStreamSubscription;

  @override
  void initState() {
    toastStreamSubscription = widget.createUserPostViewModel.toastStream.listen(_onToastMessage);
    createPostStreamSubscription = widget.createUserPostViewModel.createPostStream.listen(_onStateChange);
    super.initState();
  }

  void _onToastMessage(ToastMessage toast) {
    toast.show();
  }

  void _onStateChange(CreateUserStoryPostState state) {}

  @override
  void dispose() {
    toastStreamSubscription.cancel();
    createPostStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return PopScope(
      canPop: true,
      child: Scaffold(
        body: ListenableBuilder(
          listenable: widget.createUserPostViewModel,
          builder: (_, __) {
            return widget.createUserPostViewModel.createPostState.map(
              loading: (l) {
                return Center(
                  child: Builder(
                    builder: (context) {
                      if (l.progress == null) {
                        return const Text("Loading ...");
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Uploading story"),
                          ),

                          CircularFiniteLoader(progress: l.progress!),
                        ],
                      );
                    },
                  ),
                );
              },
              pickingVideo: (l) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Text(
                            "Create your story now.",
                            style: theme.textTheme.headlineSmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 150,
                              width: 180,
                              child: Card(
                                color: Colors.black,
                                shape: const RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: InkWell(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  onTap: () async {

                                    Duration? videoDuration = await showDurationPickerDialog(
                                      context,
                                      maxDuration: const Duration(seconds: 45),
                                    );
                                    if (videoDuration == null || !context.mounted) return;

                                    XFile? videoData = await getIt<ImagePicker>().pickVideo(
                                      source: ImageSource.camera,
                                      preferredCameraDevice: CameraDevice.rear,
                                      maxDuration: videoDuration,
                                    );
                                    if (videoData == null || !context.mounted) return;

                                    widget.createUserPostViewModel.setVideo(
                                      File(videoData.path),
                                    );

                                  },
                                  splashColor: primaryColor,
                                  highlightColor: primaryColor,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.camera_alt_outlined),
                                        Text("Use camera"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 150,
                              width: 180,
                              child: Card(
                                color: Colors.black,
                                shape: const RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: InkWell(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  onTap: () async {
                                    XFile? videoData = await getIt<ImagePicker>().pickVideo(
                                      source: ImageSource.gallery,
                                      preferredCameraDevice: CameraDevice.rear,
                                      maxDuration: const Duration(minutes: 1),
                                    );
                                    if (videoData == null || !context.mounted) return;

                                    widget.createUserPostViewModel.setVideo(
                                      File(videoData.path),
                                    );

                                  },
                                  splashColor: primaryColor,
                                  highlightColor: primaryColor,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.file_upload_outlined),
                                        Text("Upload a video"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:12.0, top: 3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 150,
                                width: 180,
                                child: GestureDetector(
                                  child: Card(
                                    color: Colors.black,
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Colors.white,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: InkWell(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      onTap: () async {
                                        if (!widget.createUserPostViewModel.hasDraft) return;
                                        widget.createUserPostViewModel.useDraft();

                                      },
                                      splashColor: primaryColor,
                                      highlightColor: primaryColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.circle_outlined,
                                              color: widget.createUserPostViewModel.hasDraft ? Colors.green : theme.iconTheme.color,
                                            ),
                                            const Text("Draft"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
              editingVideo: (e) {
                return Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Flex(
                        direction: Axis.vertical,
                        children: [
                          Expanded(
                            child: switch (e.currentTool) {
                              VideoEditingTools.trimVideo => TrimVideoWidget(
                                data: e.video,
                                thumbnails: e.videoThumbnails,
                                onConfirm: ({
                                  required Duration start,
                                  required Duration end,
                                }) {
                                  log.debug("Modifying trim video");

                                  widget.createUserPostViewModel.trimVideo(
                                    startTime: start,
                                    endTime: end,
                                  );
                                },
                              ),
                              VideoEditingTools.thumbnailPicker => ThumbnailVideoWidget(
                                selectedThumbnail: e.selectedThumbnail,
                                videoThumbnails: e.videoThumbnails,
                                onSelect: widget.createUserPostViewModel.modifyThumbnail,
                              ),
                            },
                          ),
                          SizedBox(
                            height: 80,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: VideoEditingTools.values.map((t) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        widget.createUserPostViewModel.changeCurrentTool(t);
                                      },
                                      icon: Icon(t.iconData),
                                      color: t == e.currentTool ? primaryColor : Colors.white70,
                                    ),
                                    Text(t.title),
                                  ],
                                ),
                              ).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: TextButton(
                        onPressed: () {
                          widget.createUserPostViewModel.reset();
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
                          widget.createUserPostViewModel.doPost();
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
      ),
    );
  }
}