import 'dart:io';

import 'package:akropolis/domain/use_cases/post_reply_use_case.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/presentation/features/create_post/models/create_post_models.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/news_detail_post_view_model.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/reply_post_view_model.dart';
import 'package:akropolis/presentation/features/video_editing/view/video_editing.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PostReplyScreenPage extends StatefulWidget {
  const PostReplyScreenPage({
    super.key,
  });

  @override
  State<PostReplyScreenPage> createState() => _PostReplyScreenPageState();
}

class _PostReplyScreenPageState extends State<PostReplyScreenPage> {

  late final ReplyPostViewModel replyPostViewModel;

  @override
  void initState() {
    NewsPostDto newsPostDto = ModalRoute.of(context)!.settings.arguments as NewsPostDto;
    replyPostViewModel = ReplyPostViewModel(
      newsPost: newsPostDto.newsPost,
      newsChannel: newsPostDto.channel,
      postReplyUseCase: PostReplyUseCase(
        userRepository: GetIt.I(),
        authenticationRepository: GetIt.I(),
        postRepository: GetIt.I(),
        localDataStorageService: GetIt.I(),
        remoteFileStorageService: GetIt.I(),
        localFileStorageService: GetIt.I(),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: replyPostViewModel,
      builder: (_, __) {
        return replyPostViewModel.replyPostState.map(
          loading: (_) => const InfiniteLoader(),
          idlePostState: (_) => const Text("Idle"),
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
                              onSelect:replyPostViewModel.modifyThumbnail,
                            ),
                        },
                      ),
                      SizedBox(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: VideoEditingTools.values
                              .map(
                                (t) => IconButton(
                                  onPressed: () => replyPostViewModel.changeCurrentTool(t),
                                  icon: Icon(t.iconData),
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
                      if (!context.mounted) return;
                      Navigator.of(context).pop();
                    },
                    child: const Text("Post"),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

}