import 'package:akropolis/data/utils/validations.dart';
import 'package:akropolis/presentation/features/profile/view_model/edit_profile_view_model.dart';
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
  final TextEditingController nameController = TextEditingController(text: "John Doe");
  final TextEditingController usernameController = TextEditingController(text: "@johndoe87344");
  final TextEditingController bioController = TextEditingController();
  int bioWordCount = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade800,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.camera_alt, size: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Display Name",
              ),
            ),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: "Username",
              ),
            ),
            TextField(
              controller: bioController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Short Bio",
              ),
              maxLength: maxBioLength,
            ),
            ElevatedButton(
              onPressed: () {
                // Handle profile update logic
              },
              child: const Text("Update Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
