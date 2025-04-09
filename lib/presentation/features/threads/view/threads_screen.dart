import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/gen/assets.gen.dart';
import 'package:akropolis/domain/models/thread_model.dart';
import 'package:akropolis/presentation/features/chat/model/chat_models.dart';
import 'package:akropolis/presentation/features/threads/model/thread_state.dart';
import 'package:akropolis/presentation/features/threads/view_model/thread_view_model.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
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



  double get _radius => 38;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              backgroundColor: Colors.green,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.newThreadScreen.path);
                },
                icon: Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),

      body: ListenableBuilder(
        listenable: widget.threadViewModel,
        builder: (_, __) {
          return Visibility(
            visible: widget.threadViewModel.threadList.isNotEmpty,
            replacement: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Builder(
                        builder: (context) {
                         String? profilePic = widget.threadViewModel.currentUser?.profilePicture;
                         if(profilePic == null) {
                           return  CircleAvatar(
                             radius: _radius,
                             child: Assets.profilePic.svg(),
                           );
                         }

                         return CircleAvatar(
                           radius: _radius,
                           backgroundImage: NetworkImage(profilePic),
                         );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 50),
                        child: CircleAvatar(
                          radius: _radius,
                          child: Assets.profilePic.svg(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    widget.threadViewModel.currentUser?.displayName ?? '',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                Text(
                  "This could be the beginning of\n something good",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  child: NotificationListener<ScrollNotification>(
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
                        Thread threadItem = widget.threadViewModel.threadList[index];
                        return ThreadTile(
                          thread: threadItem,
                          currentUserId: widget.threadViewModel.currentUserId,
                        );
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14.0),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Text("Connects"),
                        ...widget.threadViewModel.connectList.map(
                          (e) => ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(e.imageUrl),
                            ),
                            title: Text(e.name),
                            subtitle: Text(e.message),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
    required this.currentUserId,
    super.key,
  });

  final Thread thread;
  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    AppUser otherUser = thread.participant1.id == currentUserId ? thread.participant2 : thread.participant1;
    ThemeData theme = Theme.of(context);
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.chat.path,
          arguments: ChatDto(thread, currentUserId),
        );
      },

      leading: Builder(
        builder: (context) {
          String? imageUrl = otherUser.profilePicture;
          if (imageUrl == null) {
            return const CircleAvatar(
              child: Icon(Icons.person),
            );
          }

          return CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(imageUrl),
          );
        },
      ),
      trailing: Visibility(
        visible: !thread.threadRemote.accepted,
        child: CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 5,
        ),
      ),
      title: Text(otherUser.displayName),
      subtitle: const Align(
        alignment: Alignment.centerLeft,
        child: Icon(Icons.video_collection_outlined),
      ),

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
