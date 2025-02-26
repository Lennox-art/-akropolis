import 'dart:async';
import 'dart:io';

import 'package:akropolis/domain/gen/assets.gen.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/presentation/features/create_post/models/create_post_models.dart';
import 'package:akropolis/presentation/features/create_post/view_model/create_post_view_model.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/components/duration_picker.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:akropolis/presentation/ui/themes.dart';
import 'package:akropolis/data/utils/constants.dart';
import 'package:akropolis/data/utils/validations.dart';
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
    return ListenableBuilder(
      listenable: widget.createPostViewModel,
      builder: (_, __) {
        return widget.createPostViewModel.createPostState.map(
          loading: (l) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Uploading post",
                  ),
                  Builder(
                    builder: (context) {
                      if (l.progress == null) {
                        return const SizedBox.shrink();
                      }
                      return CircularFiniteLoader(progress: l.progress!);
                    },
                  ),
                ],
              ),
            );
          },
          loaded: (l) {
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

                                String? videoError = await validateVideo(videoData.path);
                                if (!context.mounted) return;

                                if (videoError != null) {
                                  ToastError(title: "Post Video", message: videoError).show();
                                  return;
                                }

                                await widget.createPostViewModel.setVideo(
                                  File(videoData.path)..writeAsBytesSync(await videoData.readAsBytes()),
                                );

                                if (!context.mounted) return;

                                Navigator.of(context).pushNamed(
                                  AppRoutes.videoEditingPage.path,
                                );
                              },
                              splashColor: primaryColor,
                              highlightColor: primaryColor,
                              child: Padding(
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

                                String? videoError = await validateVideo(videoData.path);
                                if (!context.mounted) return;

                                if (videoError != null) {
                                  ToastError(title: "Post Video", message: videoError).show();
                                  return;
                                }

                                await widget.createPostViewModel.setVideo(
                                  File(videoData.path)..writeAsBytesSync(await videoData.readAsBytes()),
                                );

                                if (!context.mounted) return;

                                Navigator.of(context).pushNamed(
                                  AppRoutes.videoEditingPage.path,
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
                          child: ListenableBuilder(
                            listenable: widget.createPostViewModel,
                            builder: (_, state) {
                              return widget.createPostViewModel.createPostState.map(
                                loading: (_) => const InfiniteLoader(),
                                loaded: (l) {
                                  File? draftVideo = widget.createPostViewModel.videoData;
                                  bool hasDraft = draftVideo != null;

                                  return GestureDetector(
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
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        onTap: () async {
                                          if (!hasDraft) return;

                                          String? videoError = await validateVideo(draftVideo.path);
                                          if (!context.mounted) return;

                                          if (videoError != null) {
                                            ToastError(title: "Post Video", message: videoError).show();
                                            return;
                                          }

                                          await widget.createPostViewModel.setVideo(
                                            draftVideo,
                                          );

                                          if (!context.mounted) return;

                                          Navigator.of(context).pushNamed(
                                            AppRoutes.videoEditingPage.path,
                                          );
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
                                                color: hasDraft ? Colors.green : theme.iconTheme.color,
                                              ),
                                              const Text("Draft"),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
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
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              onTap: () {},
                              splashColor: primaryColor,
                              highlightColor: primaryColor,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
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
        );
      },
    );
  }
}
