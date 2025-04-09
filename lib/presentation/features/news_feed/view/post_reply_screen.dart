import 'dart:async';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/presentation/features/create_post/models/create_post_models.dart';
import 'package:akropolis/presentation/features/news_feed/models/reply_post_state.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/reply_post_view_model.dart';
import 'package:akropolis/presentation/features/video_editing/view/video_editing.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/material.dart';

import '../../../ui/themes.dart';

class PostReplyScreenPage extends StatefulWidget {
  const PostReplyScreenPage({
    required this.replyPostViewModel,
    super.key,
  });

  final ReplyPostViewModel replyPostViewModel;

  @override
  State<PostReplyScreenPage> createState() => _PostReplyScreenPageState();
}

class _PostReplyScreenPageState extends State<PostReplyScreenPage> {

  ReplyPostViewModel get replyPostViewModel => widget.replyPostViewModel;
  late final StreamSubscription<ToastMessage> toastSubscription;
  late final StreamSubscription<ReplyPostState> replyPostStateSubscription;

  @override
  void initState() {
    toastSubscription = replyPostViewModel.toastStream.listen(_onToastMessage);
    replyPostStateSubscription = replyPostViewModel.replyPostStream.listen(_onReplyStateChanged);
    super.initState();
  }

  @override
  void dispose() {
    toastSubscription.cancel();
    replyPostStateSubscription.cancel();
    super.dispose();
  }

  void _onToastMessage(ToastMessage toast) {
    toast.show();
  }

  void _onReplyStateChanged(ReplyPostState state) {
    state.mapOrNull(
      idlePostState: (_) => Navigator.of(context).pop(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: replyPostViewModel,
        builder: (_, __) {
          return replyPostViewModel.replyPostState.map(
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
                        const Text("Uploading reply"),
                        CircularFiniteLoader(progress: l.progress!),
                      ],
                    );
                  },
                ),
              );
            },
            idlePostState: (_) => const Center(
              child: Text("Idle"),
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

                                  replyPostViewModel.trimVideo(
                                    startTime: start,
                                    endTime: end,
                                  );
                                },
                              ),
                            VideoEditingTools.thumbnailPicker => ThumbnailVideoWidget(
                                selectedThumbnail: l.selectedThumbnail,
                                videoThumbnails: l.videoThumbnails,
                                onSelect: replyPostViewModel.modifyThumbnail,
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
                                          widget.replyPostViewModel.changeCurrentTool(t);
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
                        await replyPostViewModel.doPost();
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
