import 'package:akropolis/features/news_feed/view/news_card.dart';
import 'package:akropolis/features/news_feed/models/models.dart';
import 'package:akropolis/features/news_feed/view_models/news_fetchers/headlines_news_fetcher.dart';
import 'package:flutter/material.dart';
import 'package:paged_list_view/paged_list_view.dart';
import 'package:akropolis/components/loader.dart';

class HeadlinesContent extends StatelessWidget {
  const HeadlinesContent({super.key});

  /* late final ScrollOpacityController _opacityController;
  final ScrollController mainPageScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
          (_) {
        _opacityController = ScrollOpacityController(
          debugName: "Headlines",
          scrollController: mainPageScrollController,
          onScroll: (newOpacity) {
            log.info("From Headlines opacity is $newOpacity");
            bottomNavigationOpacity.value = newOpacity;
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _opacityController.dispose();
    mainPageScrollController.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    final GlobalKey<PagedListState> pagedListKey = GlobalKey<PagedListState>();

    return PagedList<NewsPost>(
      shrinkWrap: true,
      key: pagedListKey,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      // Disables ListView scrolling
      firstPageProgressIndicatorBuilder: (_) => const InfiniteLoader(),
      newPageProgressIndicatorBuilder: (_) => const InfiniteLoader(),
      itemBuilder: (_, news, i) => NewsCard(
        post: news,
        newsChannel: NewsChannel.newsHeadlines,
      ),
      fetchPage: (int page, int pageSize, bool initialFetch) async {
        return HeadlinesNewsFetcher.fetchHeadlines(
          pageSize: pageSize,
          fromCache: initialFetch,
        );
      },
    );
  }
}
