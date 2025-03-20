import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_models.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = InitialProfileState;
  const factory ProfileState.loading() = LoadingProfileState;
  const factory ProfileState.loaded() = LoadedProfileState;
}

@freezed
class EditProfileState with _$EditProfileState {
  const factory EditProfileState.loading() = LoadingEditProfileState;
  const factory EditProfileState.loaded() = LoadedEditProfileState;
}

@freezed
class ProfilePictureState with _$ProfilePictureState {
  const factory ProfilePictureState.loading({ProgressModel? progress}) = LoadingProfilePictureState;
  const factory ProfilePictureState.loaded() = LoadedProfilePictureState;
}

enum ProfileSections {
  myPosts("My Post"),
  comments("Comments"),
  reactions("Reactions");

  final String label;

  const ProfileSections(this.label);
}

enum ProfileTask {
  createPost(
    title: "Create Post",
    subtitle: "Say what's on your mind",
    icon: Icons.edit,
    buttonText: "Create",
  ),
  profilePicture(
    title: "Profile Picture",
    subtitle: "Make it easier for people to recognize you",
    icon: Icons.camera_alt,
    buttonText: "Add",
  ),
  bio(
    title: "Add Bio",
    subtitle: "Introduce yourself",
    icon: Icons.person,
    buttonText: "Show me",
  ),
  followTopics(
    title: "Follow 10 topic",
    subtitle: "Fill your feed with relevant posts",
    icon: Icons.interests,
    buttonText: "Take me there",
  );

  final String title;
  final String subtitle;
  final IconData icon;
  final String buttonText;

  const ProfileTask({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.buttonText,
  });
}
