import 'package:akropolis/features/news_feed/models/models.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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

    final VideoPlayerController videoController = VideoPlayerController.networkUrl(Uri.parse(newsPost.postUrl));
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: null,
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
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                ),
              ),
            ),
            FutureBuilder(
              future: videoController.initialize(),
              builder: (_, snap) {
                if (snap.connectionState != ConnectionState.done) {
                  return const CircularProgressIndicator.adaptive();
                }

                videoController.play();

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
            Text(
              newsPost.description,
              style: theme.textTheme.bodyLarge,
            ),
            Text(
              newsPost.publishedAt.toIso8601String(),
              style: theme.textTheme.labelMedium?.copyWith(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.arrow_upward),
                            Text("LOG"),
                            Text(newsPost.reaction.log.length.toString()),
                            Text("EMP"),
                            Text(newsPost.reaction.emp.length.toString()),
                            Expanded(
                              child: SizedBox(
                                width: double.infinity,
                              ),
                            ),
                            Icon(Icons.arrow_upward),
                          ],
                        ),
                      ),
                      Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.chat_outlined),
                            Text(newsPost.comments.length.toString()),
                          ],
                        ),
                      ),
                      Card(
                        child: Icon(Icons.circle_outlined),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Card(
                  child: Icon(Icons.share),
                ),
              ],
            ),
            const Divider(),
            const ListTile(
              title: Text("Replies"),
              trailing: Text("View Activity"),
            ),
            const Divider(),
            ListView.builder(
              shrinkWrap: true,
              itemCount: newsPost.comments.length,
              itemBuilder: (_, i) {
                PostComment comment = newsPost.comments[i];
                return ListTile(
                  title: Text(comment.author.name),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
