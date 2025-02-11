import 'dart:io';

import 'package:akropolis/features/authentication/models/authentication_models.dart';
import 'package:akropolis/features/create_post/view_model/create_post_cubit.dart';
import 'package:akropolis/features/on_boarding/view_model/user_cubit/user_cubit.dart';
import 'package:akropolis/gen/assets.gen.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostPage extends StatelessWidget {
  const CreatePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Post"),
      ),
      body: Column(
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
                  child: Assets.home.svg(
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
                    width: 150,
                    child: GestureDetector(
                      onTap: () async {
                        XFile? videoData = await getIt<ImagePicker>().pickVideo(
                          source: ImageSource.camera,
                          preferredCameraDevice: CameraDevice.rear,
                          maxDuration: const Duration(minutes: 1),
                        );
                        if (videoData == null || !context.mounted) return;

                        AppUser? user = await BlocProvider.of<UserCubit>(context).getCurrentUser();
                        if (user == null || !context.mounted) return;

                        await BlocProvider.of<CreatePostCubit>(context).createNewPost(
                          file: File(videoData.path)..writeAsBytesSync(await videoData.readAsBytes()),
                          user: user,
                        );

                        if (!context.mounted) return;

                        Navigator.of(context).pushNamed(
                          AppRoutes.videoEditingPage.path,
                        );
                      },
                      child: const Card(
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
                    width: 150,
                    child: GestureDetector(
                      onTap: () async {
                        XFile? videoData = await getIt<ImagePicker>().pickVideo(
                          source: ImageSource.gallery,
                          preferredCameraDevice: CameraDevice.rear,
                          maxDuration: const Duration(minutes: 1),
                        );
                        if (videoData == null || !context.mounted) return;

                        AppUser? user = await BlocProvider.of<UserCubit>(context).getCurrentUser();
                        if (user == null || !context.mounted) return;


                        await BlocProvider.of<CreatePostCubit>(context).createNewPost(
                          file: File(videoData.path)..writeAsBytesSync(await videoData.readAsBytes()),
                          user: user,
                        );

                        if (!context.mounted) return;

                        Navigator.of(context).pushNamed(
                          AppRoutes.videoEditingPage.path,
                        );
                      },
                      child: const Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.upload_file_outlined),
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
                    width: 150,
                    child: BlocBuilder<CreatePostCubit, CreatePostState>(
                      builder: (_, state) {
                        return state.map(
                          loading: (_) => const CircularProgressIndicator.adaptive(),
                          loaded: (l) {
                            bool hasDraft = l.form?.videoData != null;

                            return GestureDetector(
                              onTap: () async {
                                if(!hasDraft) return;

                                AppUser? user = await BlocProvider.of<UserCubit>(context).getCurrentUser();
                                if (user == null || !context.mounted) return;

                                await BlocProvider.of<CreatePostCubit>(context).createNewPost(
                                  file: l.form!.videoData!,
                                  user: user,
                                );

                                if (!context.mounted) return;

                                Navigator.of(context).pushNamed(
                                  AppRoutes.videoEditingPage.path,
                                );
                              },
                              child: Card(
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
                                      Text("Draft"),
                                    ],
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
                    width: 150,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /*Icon(Icons.group_work_outlined),
                            Text("Use template"),*/
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}