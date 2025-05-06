import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/models/news_card_model.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/presentation/features/bookmarked/model/bookmarked_state.dart';
import 'package:akropolis/presentation/features/bookmarked/view_model/bookmarked_view_model.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookmarkedScreen extends StatelessWidget {
  const BookmarkedScreen({
    required this.bookmarkedViewModel,
    super.key,
  });

  final BookmarkedViewModel bookmarkedViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked'),
      ),
      body: ListenableBuilder(
        listenable: bookmarkedViewModel,
        builder: (_, __) {
          List<Bookmark> bookmarks = bookmarkedViewModel.bookmarkList;

          return Visibility(
            visible: bookmarks.isEmpty,
            replacement: const Center(
              child: Text('You do not have bookmark yet'),
            ),
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                bool isLoading = bookmarkedViewModel.state is LoadingBookmarkedState;
                bool isAtEndOfList = scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent;
                if (!isLoading && isAtEndOfList) {
                  bookmarkedViewModel.loadMoreItems();
                }

                return true;
              },
              child: ListView.builder(
                reverse: true,
                itemCount: bookmarks.length + (bookmarkedViewModel.state is LoadingBookmarkedState ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= bookmarks.length) {
                    return const InfiniteLoader();
                  }
                  Bookmark bookmark = bookmarks[index];
                  NewsPost? post = bookmarkedViewModel.getPost(postId: bookmark.postId);
                  if(post == null) {
                    if(bookmarkedViewModel.resolveBookmarkState is LoadingResolveBookmarkedState) {
                      return const InfiniteLoader();
                    }
                    return const Text("No post found");
                  }

                  return GestureDetector(
                    onTap: () {},
                    child: BookmarkCard(
                      post: post,
                      bookmark: bookmark,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

///BookmarkCard
class BookmarkCard extends StatelessWidget {
  final NewsPost post;
  final Bookmark bookmark;

  const BookmarkCard({
    super.key,
    required this.post,
    required this.bookmark,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      height: 400,
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.white12,
          ),
        ),
      ),
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Visibility(
                  visible: post.author.imageUrl != null,
                  replacement: const CircleAvatar(
                    radius: 12,
                    child: Icon(
                      Icons.person,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 12,
                    backgroundImage: CachedNetworkImageProvider(
                      post.author.imageUrl ?? '',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text(
                    post.author.name,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Visibility(
              visible: post.thumbnailUrl.isNotEmpty,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(16.0),
                ),
                child: CachedNetworkImage(
                  imageUrl: post.thumbnailUrl,
                  height: 50,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    log.error(error.toString());
                    return const Icon(
                      Icons.broken_image,
                      size: 180,
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              post.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 12,
                color: Colors.white,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
