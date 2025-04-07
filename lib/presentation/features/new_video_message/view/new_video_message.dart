import 'dart:async';

import 'package:akropolis/main.dart';
import 'package:akropolis/presentation/features/create_post/models/create_post_models.dart';
import 'package:akropolis/presentation/features/new_video_message/view_model/new_video_message_view_model.dart';
import 'package:akropolis/presentation/features/news_feed/models/reply_post_state.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/reply_post_view_model.dart';
import 'package:akropolis/presentation/features/video_editing/view/video_editing.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/material.dart';

import '../../../ui/themes.dart';

class NewVideoMessageScreen extends StatefulWidget {
  const NewVideoMessageScreen({
    required this.newVideoMessageViewModel,
    super.key,
  });

  final NewVideoMessageViewModel newVideoMessageViewModel;

  @override
  State<NewVideoMessageScreen> createState() => _NewVideoMessageScreenState();
}

class _NewVideoMessageScreenState extends State<NewVideoMessageScreen> {
  NewVideoMessageViewModel get newVideoMessageViewModel => widget.newVideoMessageViewModel;
  late final StreamSubscription<ToastMessage> toastSubscription;

  @override
  void initState() {
    toastSubscription = newVideoMessageViewModel.toastStream.listen(_onToastMessage);
    super.initState();
  }

  @override
  void dispose() {
    toastSubscription.cancel();
    super.dispose();
  }

  void _onToastMessage(ToastMessage toast) {
    toast.show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: newVideoMessageViewModel,
        builder: (_, __) {
          return newVideoMessageViewModel.newVideoState.map(
            loading: (_) => const InfiniteLoader(),
            idlePostState: (_) => Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    "Message sent",
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: ElevatedButton(
                    onPressed: Navigator.of(context).pop,
                    child: const Text("Back to chat"),
                  ),
                ),
              ],
            ),
            errorState: (e) => Text(e.failure.message),
            editingVideo: (l) {
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
                          child: switch (l.currentTool) {
                            VideoEditingTools.trimVideo => TrimVideoWidget(
                                data: l.video,
                                thumbnails: l.videoThumbnails,
                                onConfirm: ({
                                  required Duration start,
                                  required Duration end,
                                }) {
                                  log.debug("Modifying trim video");

                                  newVideoMessageViewModel.trimVideo(
                                    startTime: start,
                                    endTime: end,
                                  );
                                },
                              ),
                            VideoEditingTools.thumbnailPicker => ThumbnailVideoWidget(
                                selectedThumbnail: l.selectedThumbnail,
                                videoThumbnails: l.videoThumbnails,
                                onSelect: newVideoMessageViewModel.modifyThumbnail,
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
                                          widget.newVideoMessageViewModel.changeCurrentTool(t);
                                        },
                                        icon: Icon(t.iconData),
                                        color: t == l.currentTool ? primaryColor : Colors.white70,
                                      ),
                                      Text(t.title),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    trailing: TextButton(
                      onPressed: () async {
                        await newVideoMessageViewModel.doSendMessage();
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
    );
  }
}
