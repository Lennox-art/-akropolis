import 'package:akropolis/components/news_post_components.dart';
import 'package:akropolis/features/news_feed/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

enum PostMenu {
  share("Share"),
  bookmark("Bookmark"),
  notInterested("Not interested"),
  report("Report");

  final String title;

  const PostMenu(this.title);
}

class NewsDetailedViewPage extends StatelessWidget {
  const NewsDetailedViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    NewsPost? newsPost = ModalRoute.of(context)?.settings.arguments as NewsPost?;

    if (newsPost == null) {
      return TextButton(
        onPressed: Navigator.of(context).pop,
        child: const Text("Back"),
      );
    }

    final VideoPlayerController videoController = VideoPlayerController.networkUrl(
      Uri.parse(newsPost.postUrl),
    );

    final DocumentReference newsPostRef = FirebaseFirestore.instance.collection(newsPost.channel.collection).doc(newsPost.id).withConverter<NewsPost>(
          fromFirestore: (snapshot, _) => NewsPost.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );

    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: null,
        actions: [
          ElevatedButton(
            onPressed: () {},
            style: theme.elevatedButtonTheme.style?.copyWith(
              fixedSize: const WidgetStatePropertyAll(
                Size(100, 50),
              ),
            ),
            child: const Text("Reply"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              leading: Builder(
                builder: (context) {
                  if (newsPost.author.imageUrl == null) {
                    return const Icon(Icons.person);
                  }

                  return CircleAvatar(
                    backgroundImage: NetworkImage(newsPost.author.imageUrl!),
                  );
                },
              ),
              title: Text(newsPost.author.name),
              trailing: MenuAnchor(
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
                menuChildren: PostMenu.values
                    .map(
                      (menu) => MenuItemButton(
                        onPressed: () {},
                        style: theme.menuButtonTheme.style?.copyWith(
                          backgroundColor: WidgetStatePropertyAll(
                            menu == PostMenu.report ? Colors.red : null,
                          ),
                        ),
                        child: Text(menu.title),
                      ),
                    )
                    .toList(),
              ),
            ),
            Container(
              constraints: const BoxConstraints(
                minHeight: 400,
                maxHeight: 600,
                minWidth: 500,
                maxWidth: 700,
              ),
              color: Colors.black12,
              child: FutureBuilder(
                future: videoController.initialize(),
                builder: (_, snap) {
                  if (snap.connectionState != ConnectionState.done) {
                    return const CircularProgressIndicator.adaptive();
                  }

                  //videoController.play();

                  return ValueListenableBuilder(
                    valueListenable: videoController,
                    builder: (_, videoValue, __) {
                      return AspectRatio(
                        aspectRatio: videoValue.aspectRatio,
                        child: VideoPlayer(videoController),
                      );
                    },
                  );
                },
              ),
            ),
            Text(
              newsPost.description,
              style: theme.textTheme.labelLarge,
            ),
            Text(
              newsPost.publishedAt.toIso8601String(),
              style: theme.textTheme.labelMedium?.copyWith(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            StreamBuilder(
                stream: newsPostRef.snapshots(includeMetadataChanges: true),
                builder: (_, snap) {
                  NewsPost updatedPost = snap.data?.data() as NewsPost? ?? newsPost;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flex(
                        direction: Axis.horizontal,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Flex(
                              direction: Axis.horizontal,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: PostReactionWidget(
                                    newsPost: updatedPost,
                                    postsCollectionRef: newsPostRef,
                                  ),
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(Icons.chat_outlined),
                                        Text(updatedPost.comments.length.toString()),
                                      ],
                                    ),
                                  ),
                                ),
                                const Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.circle_outlined),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Card(
                            child: Padding(
                              padding: EdgeInsets.all(
                                8.0,
                              ),
                              child: Icon(Icons.share),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Replies"),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("View Activity"),
                          ),
                        ],
                      ),
                      const Divider(),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: updatedPost.comments.length,
                        itemBuilder: (_, i) {
                          PostComment comment = updatedPost.comments[i];
                          return ListTile(
                            title: Text(comment.author.name),
                          );
                        },
                      ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
