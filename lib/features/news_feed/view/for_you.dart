import 'package:akropolis/features/news_feed/models/models.dart';
import 'package:akropolis/features/news_feed/view/news_card.dart';
import 'package:akropolis/features/news_feed/view_models/news_fetchers/for_you_news_fetcher.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:paged_list_view/paged_list_view.dart';
import 'package:akropolis/components/loader.dart';

class ForYouContent extends StatelessWidget {
  const ForYouContent({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<PagedListState> pagedListKey = GlobalKey<PagedListState>();
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black12,
              Colors.black26,
              Colors.black87,
              Colors.black,
            ], // Gradient
            stops: [
              0.0,
              0.05,
              0.17,
              0.29,
            ], // Evenly spaced stops
            begin: Alignment.topLeft, // Start position
            end: Alignment.bottomRight, // End position
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder(
              future: ForYouNewsFetcher.fetchUserPostsNews(
                pageSize: 10,
                fromCache: true,
              ),
              builder: (_, snap) {
                if (snap.connectionState != ConnectionState.done) {
                  return const InfiniteLoader();
                }

                return ForYouHighlightCarrousel(
                  newsPost: snap.requireData ?? [],
                );
              },
            ),
            PagedList<NewsPost>(
              shrinkWrap: true,
              key: pagedListKey,
              physics: const ClampingScrollPhysics(),
              firstPageProgressIndicatorBuilder: (_) => const InfiniteLoader(),
              newPageProgressIndicatorBuilder: (_) => const InfiniteLoader(),
              itemBuilder: (_, news, i) => ForYouCard(
                post: news,
                newsChannel: NewsChannel.userPosts,
              ),
              fetchPage: (int page, int pageSize, bool initialFetch) async {
                return ForYouNewsFetcher.fetchUserPostsNews(
                  pageSize: pageSize,
                  fromCache: initialFetch,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ForYouHighlightCarrousel extends StatelessWidget {
  ForYouHighlightCarrousel({
    required this.newsPost,
    super.key,
  });

  final List<NewsPost> newsPost;
  final ValueNotifier<int> scrollController = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 320,
          child: InfiniteCarousel.builder(
            itemCount: newsPost.length,
            itemExtent: 350,
            center: true,
            anchor: 0.0,
            velocityFactor: 0.2,
            onIndexChanged: (index) {
              scrollController.value = index;
            },
            axisDirection: Axis.horizontal,
            itemBuilder: (_, itemIndex, realIndex) {
              return ForYouHighlightCard(
                post: newsPost[itemIndex],
                newsChannel: NewsChannel.userPosts,
              );
            },
          ),
        ),
        ValueListenableBuilder(
          valueListenable: scrollController,
          builder: (_, index, __) {
            return DotsIndicator(
              dotsCount: newsPost.length,
              position: index.toDouble(),
              decorator: const DotsDecorator(
                color: Colors.grey, // Inactive color
                activeColor: Colors.white,
              ),
            );
          },
        ),
        const Divider(
          color: Colors.white12,
        )
      ],
    );
  }
}
