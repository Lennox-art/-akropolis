import 'dart:async';
import 'dart:io';

import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/utils/constants.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/presentation/features/new_thread/model/new_thread_model.dart';
import 'package:akropolis/presentation/features/new_thread/view_model/new_thread_view_model.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/components/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewThreadScreen extends StatefulWidget {
  const NewThreadScreen({required this.newThreadViewModel, super.key});

  final NewThreadViewModel newThreadViewModel;

  @override
  State<NewThreadScreen> createState() => _NewThreadScreenState();
}

class _NewThreadScreenState extends State<NewThreadScreen> {
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      _performSearch(query);
    });
  }

  void _performSearch(String query) {
    if (query.isEmpty) return;
    debugPrint("Searching for: $query");
    widget.newThreadViewModel.searchUsers(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
            child: SearchBar(
              onChanged: _onSearchChanged,
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: widget.newThreadViewModel.userStream,
              builder: (_, snap) {
                List<AppUser> users = snap.data ?? [];
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (_, i) {
                    AppUser appUser = users[i];
                    return ListTile(
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

                        if (!context.mounted) return;

                        Navigator.of(context).pushNamed(
                          AppRoutes.newVideoMessage.path,
                          arguments: NewVideoMessageData(
                            File(videoData.path),
                            appUser,
                          ),
                        );
                      },
                      leading: Builder(
                        builder: (context) {
                          if (appUser.profilePicture == null) {
                            return const CircleAvatar();
                          }
                          return CircleAvatar(
                            backgroundImage: NetworkImage(appUser.profilePicture!),
                          );
                        },
                      ),
                      title: Text(appUser.displayName),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
