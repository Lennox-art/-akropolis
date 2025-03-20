import 'dart:async';
import 'dart:math';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/utils/validations.dart';
import 'package:akropolis/presentation/features/profile/view_model/edit_profile_view_model.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:akropolis/presentation/ui/media_functions.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    required this.editProfileViewModel,
    super.key,
  });

  final EditProfileViewModel editProfileViewModel;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  AppUser get currentUser => widget.editProfileViewModel.currentUser;
  late final StreamSubscription<ToastMessage> toastStreamSubscription;
  late final TextEditingController displayNameController = TextEditingController(text: currentUser.displayName);
  late final TextEditingController bioController = TextEditingController(text: currentUser.bio);

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        toastStreamSubscription = widget.editProfileViewModel.toastStream.listen(_onToastMessage);
      },
    );
    super.initState();
  }

  void _onToastMessage(ToastMessage toast) {
    toast.show();
  }

  @override
  void dispose() {
    toastStreamSubscription.cancel();
    widget.editProfileViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: ListenableBuilder(
        listenable: widget.editProfileViewModel,
        builder: (_, __) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.editProfileViewModel.profilePictureState.map(
                    loading: (l) {
                      if (l.progress == null) return const InfiniteLoader();
                      return CircularFiniteLoader(progress: l.progress!);
                    },
                    loaded: (_) {
                      String? profilePicture = currentUser.profilePicture;

                      return Center(
                        child: Stack(
                          children: [
                            Builder(
                              builder: (context) {
                                if (profilePicture == null) {
                                  return CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey.shade800,
                                    child: const Icon(Icons.person, size: 50, color: Colors.white),
                                  );
                                }
                                return CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.grey.shade800,
                                  backgroundImage: NetworkImage(profilePicture),
                                );
                              },
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () async {
                                  Result<MediaBlobData> pickImageResult = await pickImageFromDevice();
                                  switch (pickImageResult) {
                                    case Success<MediaBlobData>():
                                      widget.editProfileViewModel.uploadProfilePicture(pickImageResult.data);
                                      break;
                                    case Error<MediaBlobData>():
                                      ToastInfo(message: pickImageResult.failure.message).show();
                                      break;
                                  }
                                },
                                child: const CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.blue,
                                  child: Icon(Icons.camera_alt, size: 18, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: displayNameController,
                      validator: validateDisplayName,
                      decoration: const InputDecoration(
                        labelText: "Display Name",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: bioController,
                      maxLines: 3,
                      validator: validateBio,
                      decoration: const InputDecoration(
                        labelText: "Short Bio",
                      ),
                      maxLength: maxBioLength,
                    ),
                  ),
                  widget.editProfileViewModel.editProfileState.map(
                    loading: (l) {
                      return const InfiniteLoader();
                    },
                    loaded: (l) {
                      return ElevatedButton(
                        onPressed: () {
                          // Handle profile update logic
                          if (!_formKey.currentState!.validate()) return;

                          String displayName = displayNameController.text;
                          String bio = bioController.text;

                          widget.editProfileViewModel.updateUser(
                            currentUser
                              ..bio = bio
                              ..displayName = displayName,
                          );
                        },
                        child: const Text("Update Profile"),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
