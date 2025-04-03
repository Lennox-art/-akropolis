import 'dart:async';
import 'dart:io';

import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/utils/date_format.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/presentation/features/chat/model/chat_models.dart';
import 'package:akropolis/presentation/features/chat/view_model/chat_view_model.dart';
import 'package:akropolis/presentation/features/new_video_message/model/new_video_message_model.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/components/duration_picker.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({required this.chatViewModel, super.key});

  final ChatViewModel chatViewModel;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final StreamSubscription<ToastMessage> toastStreamSubscription;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      toastStreamSubscription = widget.chatViewModel.toastMessageStream.listen(_onToastMessage);
    });
    super.initState();
  }

  void _onToastMessage(ToastMessage toast) {
    toast.show();
  }

  @override
  void dispose() {
    toastStreamSubscription.cancel();
    widget.chatViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatViewModel.otherUser.displayName),
        actions: [
          MenuAnchor(
            builder: (_, controller, __) {
              return IconButton(
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                    return;
                  }
                  controller.open();
                },
                icon: const Icon(Icons.more_vert),
                tooltip: 'Post options',
              );
            },
            menuChildren: ChatMenu.values
                .map(
                  (menu) => MenuItemButton(
                onPressed: () {
                  switch(menu) {

                    case ChatMenu.chatSettings:
                      Navigator.of(context).pushNamed(
                          AppRoutes.chatMessageSettings.path,
                          arguments: widget.chatViewModel.meUser,
                      );
                      return;
                  }
                },
                child: Text(
                  menu.title,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
                .toList(),
          )
        ],
      ),
      body: ListenableBuilder(
        listenable: widget.chatViewModel,
        builder: (_, __) {
          return Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListenableBuilder(
                    listenable: widget.chatViewModel,
                    builder: (context, __) {
                      return NotificationListener<ScrollNotification>(
                        onNotification: (scrollInfo) {
                          bool isLoading = widget.chatViewModel.chatItemsState is ChatLoadingState;
                          bool isAtEndOfList = scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent;
                          if (!isLoading && isAtEndOfList) {
                            widget.chatViewModel.fetchMessages();
                          }

                          return true;
                        },
                        child: ListView.builder(
                          reverse: true,
                          itemCount: widget.chatViewModel.messageList.length + (widget.chatViewModel.chatItemsState is ChatLoadingState ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index >= widget.chatViewModel.messageList.length) {
                              return const InfiniteLoader();
                            }
                            MessageRemote chatItem = widget.chatViewModel.messageList[index];
                            bool isMyMessage = chatItem.sendToUserId != widget.chatViewModel.currentUserId;

                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.chatMessage.path,
                                  arguments: chatItem,
                                );
                              },
                              child: ChatItemImageWidget(
                                isMyMessage: isMyMessage,
                                messageModel: chatItem,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.chatViewModel.chatState.map(
                  initial: (_) => const Text(". . ."),
                  requested: (_) {
                    return Visibility(
                      visible: !widget.chatViewModel.amIInitiator,
                      replacement: Text(
                        "Waiting for ${widget.chatViewModel.thread.participant2.displayName} to accept",
                        style: theme.textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${widget.chatViewModel.thread.participant1.displayName} wants to chat with you"),
                          Flex(
                            direction: Axis.horizontal,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: widget.chatViewModel.declineMessageRequest,
                                    child: Text("Decline"),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: widget.chatViewModel.acceptMessageRequest,
                                    child: Text("Accept"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  loaded: (l) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () async {
                              XFile? videoData = await getIt<ImagePicker>().pickVideo(
                                source: ImageSource.gallery,
                                maxDuration: const Duration(seconds: 30),
                              );
                              if (videoData == null || !context.mounted) return;

                              if (!context.mounted) return;

                              Navigator.of(context).pushNamed(
                                AppRoutes.newVideoMessage.path,
                                arguments: NewVideoMessageData(
                                  widget.chatViewModel.thread.threadRemote.id,
                                  File(videoData.path),
                                  widget.chatViewModel.otherUser,
                                ),
                              );
                            },
                            child: Container(
                              width: 80,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: theme.colorScheme.primary,
                                    width: 0.8,
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(8))),
                              child: Icon(
                                Icons.photo_library_outlined,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () async {
                              Duration? videoDuration = await showDurationPickerDialog(
                                context,
                                maxDuration: const Duration(seconds: 30),
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
                                  widget.chatViewModel.thread.threadRemote.id,
                                  File(videoData.path),
                                  widget.chatViewModel.otherUser,
                                ),
                              );
                            },
                            child: Container(
                              width: 80,
                              height: 40,
                              decoration: BoxDecoration(color: theme.colorScheme.primary, borderRadius: const BorderRadius.all(Radius.circular(8))),
                              child: const Icon(Icons.camera_alt_outlined),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  loading: (_) => const InfiniteLoader(),
                  declined: (_) {
                    return const Text("Chat has been declined");
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ChatItemImageWidget extends StatelessWidget {
  const ChatItemImageWidget({
    required this.isMyMessage,
    required this.messageModel,
    super.key,
  });

  final bool isMyMessage;
  final MessageRemote messageModel;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Align(
      alignment: isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: 300,
              maxHeight: 300,
              minHeight: 300,
              minWidth: 300,
            ),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: isMyMessage ? theme.colorScheme.inversePrimary : theme.colorScheme.secondary,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              image: DecorationImage(
                image: CachedNetworkImageProvider(messageModel.thumbnailUrl),
                fit: BoxFit.cover, // Use BoxFit.cover for better scaling
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              messageModel.createdAt.chatTime,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: theme.colorScheme.tertiary,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
