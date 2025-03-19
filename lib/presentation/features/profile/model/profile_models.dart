import 'package:flutter/material.dart';

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
