import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/presentation/features/chat/view_model/chat_message_view_model.dart';
import 'package:akropolis/presentation/ui/components/app_video_player.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:flutter/material.dart';

class ChatMessageScreen extends StatefulWidget {
  const ChatMessageScreen({
    required this.chatMessageViewModel,
    super.key,
  });

  final ChatMessageViewModel chatMessageViewModel;

  @override
  State<ChatMessageScreen> createState() => _ChatMessageScreenState();
}

class _ChatMessageScreenState extends State<ChatMessageScreen> {


  @override
  void initState() {
    widget.chatMessageViewModel.downloadThumbnail();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Message"),
      ),
      body: Container(
        height: 400,
        color: Colors.black12,
        child: ListenableBuilder(
          listenable: widget.chatMessageViewModel,
          builder: (_, __) {
            return widget.chatMessageViewModel.postMediaState.map(
              initial: (_) {
                return widget.chatMessageViewModel.thumbnailMediaState.map(
                  initial: (_) => const SizedBox.shrink(),
                  downloadingMedia: (d) {
                    if (d.progress == null) {
                      return const InfiniteLoader();
                    }

                    return CircularFiniteLoader(progress: d.progress!);
                  },
                  downloadedMedia: (d) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.file(
                          d.media.file,
                          height: 350,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        IconButton(
                          onPressed: widget.chatMessageViewModel.downloadPost,
                          icon: const Icon(
                            Icons.play_arrow,
                            size: 25,
                          ),
                        ),
                      ],
                    );
                  },
                  errorDownloadingMedia: (e) => IconButton(
                    onPressed: widget.chatMessageViewModel.downloadThumbnail,
                    icon: const Icon(
                      Icons.broken_image_outlined,
                    ),
                  ),
                );
              },
              downloadingMedia: (d) {
                if (d.progress == null) {
                  return const InfiniteLoader();
                }

                return CircularFiniteLoader(progress: d.progress!);
              },
              downloadedMedia: (d) {
                switch (d.media.mediaType) {
                  case MediaType.image:
                    return Image.file(
                      d.media.file,
                      height: 350,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  case MediaType.video:
                    return CachedVideoPlayer(
                      file: d.media.file,
                      autoPlay: true,
                    );
                }
              },
              errorDownloadingMedia: (e) => IconButton(
                onPressed: widget.chatMessageViewModel.downloadPost,
                icon: const Icon(
                  Icons.broken_image_outlined,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
