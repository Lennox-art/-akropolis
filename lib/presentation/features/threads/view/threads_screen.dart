import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/presentation/features/threads/model/thread_state.dart';
import 'package:akropolis/presentation/features/threads/view_model/thread_view_model.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:flutter/material.dart';

class ThreadsScreen extends StatefulWidget {
  const ThreadsScreen({
    required this.threadViewModel,
    super.key,
  });

  final ThreadViewModel threadViewModel;

  @override
  State<ThreadsScreen> createState() => _ThreadsScreenState();
}

class _ThreadsScreenState extends State<ThreadsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.newThreadScreen.path);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: widget.threadViewModel,
        builder: (_, __) {
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              bool isLoading = widget.threadViewModel.threadState is ThreadsLoadingState;
              bool isAtEndOfList = scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent;

              print("isLoading $isLoading : isAtEndOfList $isAtEndOfList");

              if (!isLoading && isAtEndOfList) {
                widget.threadViewModel.loadMoreItems();
              }

              return true;
            },
            child: ListView.builder(
              itemCount: widget.threadViewModel.threadList.length + (widget.threadViewModel.threadState is ThreadsLoadingState ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= widget.threadViewModel.threadList.length) {
                  return const InfiniteLoader();
                }
                ThreadRemote threadItem = widget.threadViewModel.threadList[index];
                return ThreadTile(thread: threadItem);
              },
            ),
          );
        },
      ),
    );
  }
}

class ThreadTile extends StatelessWidget {
  const ThreadTile({
    required this.thread,
    super.key,
  });

  final ThreadRemote thread;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ListTile(
      onTap: () {
        // Navigator.of(context).pushNamed(
        //   AppRoutes.chat.path,
        //   arguments: thread,
        // );
      },

      // leading: thread.otherDevice.profilePictureResult.map(
      //   success: (s) {
      //     MediaFileData? profileData = s.data;
      //     if (profileData == null) {
      //       return CircleAvatar(
      //         radius: 30,
      //         child: Icon(
      //           Icons.edit,
      //         ),
      //       );
      //     }
      //
      //     return CircleAvatar(
      //       backgroundImage: FileImage(profileData.file),
      //     );
      //   },
      //   error: (s) {
      //     return CircleAvatar(
      //       child: Icon(Icons.devices),
      //     );
      //   },
      // ),
      title: Text(thread.participant1),
      // title: Text(thread.otherDevice.device.nickname),

      // subtitle: Align(
      //   alignment: Alignment.centerLeft,
      //   child: thread.latestMessageResult.map(
      //     success: (s) {
      //       MessageLocal? message = s.data;
      //       if (message == null) return null;
      //       return switch (message.mediaType) {
      //         MediaType.text => Text(message.content),
      //         MediaType.image => Icon(Icons.insert_photo_outlined),
      //         MediaType.video => Icon(Icons.video_collection_outlined),
      //       };
      //     },
      //     error: (e) {
      //       return Text(e.failure.message, style: TextStyle(color:theme.colorScheme.error ),);
      //     },
      //   ),
      // ),
      // trailing: Flex(
      //   direction: Axis.vertical,
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     thread.latestMessageResult.map(
      //       success: (s) {
      //         MessageLocal? messageLocal = s.data;
      //         if (messageLocal == null) return SizedBox.shrink();
      //         return Flexible(
      //           child: Text(messageLocal.createdAt.chatTime),
      //         );
      //       },
      //       error: (_) => SizedBox.shrink(),
      //     ),
      //     thread.unreadMessageCountResult.map(
      //       success: (s) {
      //         int? count = s.data;
      //         if (count == null || count == 0) return SizedBox.shrink();
      //
      //         return Flexible(
      //           child: CircleAvatar(
      //             child: Text("$count"),
      //           ),
      //         );
      //       },
      //       error: (_) => SizedBox.shrink(),
      //     ),
      //   ],
      // ),
    );
  }
}
