import 'dart:async';
import 'dart:io';

import 'package:akropolis/domain/gen/assets.gen.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/presentation/features/create_post/models/create_post_models.dart';
import 'package:akropolis/presentation/features/create_post/view_model/create_post_view_model.dart';
import 'package:akropolis/presentation/features/video_editing/view/video_editing.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/components/duration_picker.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:akropolis/presentation/ui/themes.dart';
import 'package:akropolis/data/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({
    required this.createPostViewModel,
    super.key,
  });

  final CreatePostViewModel createPostViewModel;

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  late final StreamSubscription<ToastMessage> toastStreamSubscription;
  late final StreamSubscription<CreatePostState> createPostStreamSubscription;

  @override
  void initState() {
    toastStreamSubscription = widget.createPostViewModel.toastStream.listen(_onToastMessage);
    createPostStreamSubscription = widget.createPostViewModel.createPostStream.listen(_onStateChange);
    super.initState();
  }

  void _onToastMessage(ToastMessage toast) {
    toast.show();
  }

  void _onStateChange(CreatePostState state) {}

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
          listenable: widget.createPostViewModel,
          builder: (_, __) {
            return widget.createPostViewModel.createPostState.map(
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
                          const Text("Uploading post"),
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Assets.akropolisLogo.svg(
                              height: 80,
                              width: 80,
                            ),
                          ),
                          Text(
                            "Create your post now.",
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
                                      maxDuration: maxVideoDuration,
                                    );
                                    if (videoDuration == null || !context.mounted) return;

                                    XFile? videoData = await getIt<ImagePicker>().pickVideo(
                                      source: ImageSource.camera,
                                      preferredCameraDevice: CameraDevice.rear,
                                      maxDuration: videoDuration,
                                    );
                                    if (videoData == null || !context.mounted) return;

                                    widget.createPostViewModel.setVideo(
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

                                    widget.createPostViewModel.setVideo(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                      if (!widget.createPostViewModel.hasDraft) return;
                                      widget.createPostViewModel.useDraft();

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
                                            color: widget.createPostViewModel.hasDraft ? Colors.green : theme.iconTheme.color,
                                          ),
                                          const Text("Draft"),
                                        ],
                                      ),
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
                                  onTap: () {},
                                  splashColor: primaryColor,
                                  highlightColor: primaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Assets.circlesThree.svg(
                                              height: 30,
                                              width: 30,
                                              color: Colors.white,
                                            ),
                                            const Icon(
                                              Icons.lock_outline,
                                              color: Colors.orange,
                                            ),
                                          ],
                                        ),
                                        const Text("Use Templates"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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

                                  widget.createPostViewModel.trimVideo(
                                    startTime: start,
                                    endTime: end,
                                  );
                                },
                              ),
                              VideoEditingTools.thumbnailPicker => ThumbnailVideoWidget(
                                selectedThumbnail: e.selectedThumbnail,
                                videoThumbnails: e.videoThumbnails,
                                onSelect: widget.createPostViewModel.modifyThumbnail,
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
                                        widget.createPostViewModel.changeCurrentTool(t);
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
                          widget.createPostViewModel.finishEditing();
                        },
                        child: const Text("Next"),
                      ),
                    ),
                  ],
                );
              },
              captionPost: (c) {
                TextEditingController titleController = TextEditingController();
                TextEditingController descriptionController = TextEditingController();

                return Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Card(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                          child: Image.memory(
                            c.thumbnail,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text("Title"),
                      subtitle: TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          hintText: "Title",
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text("Description"),
                      subtitle: TextFormField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          hintText: "Description",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          String title = titleController.text;
                          String description = descriptionController.text;

                          widget.createPostViewModel.doPost(
                            title: title,
                            description: description,
                          );

                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.home.path,
                            (_) => false,
                          );
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


