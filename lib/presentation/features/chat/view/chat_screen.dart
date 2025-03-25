import 'dart:async';

import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/utils/date_format.dart';
import 'package:akropolis/presentation/features/chat/model/chat_models.dart';
import 'package:akropolis/presentation/features/chat/view_model/chat_view_model.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatViewModel.otherUser.displayName),
      ),
      body: Flex(
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
                        // widget.chatViewModel.setMessageAsRead(chatItem);
                        bool isMyMessage = chatItem.sendToUserId == widget.chatViewModel.currentUserId;

                        return ChatItemImageWidget(isMyMessage: isMyMessage, messageModel: chatItem);
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
              loaded: (l) {
                return Visibility(
                  visible: widget.chatViewModel.thread.threadRemote.accepted,
                  replacement: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("${widget.chatViewModel.otherUser.displayName} wants to chat with you"),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text("Decline"),
                              ),
                            ),
                          ),

                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text("Accept"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    child: IconButton(
                      onPressed: () async {},
                      icon: const Icon(Icons.attach_file),
                    ),
                  ),
                );
              },
              loading: (_) => InfiniteLoader(),
            ),
          ),
        ],
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
                image: NetworkImage(messageModel.thumbnailUrl),
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
