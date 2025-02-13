import 'package:akropolis/components/loader.dart';
import 'package:akropolis/components/scroll_opacity_controller.dart';
import 'package:akropolis/features/home_page.dart';
import 'package:akropolis/features/news_feed/models/models.dart';
import 'package:akropolis/features/news_feed/view_models/news_fetchers/local_news_fetcher.dart';
import 'package:akropolis/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:paged_list_view/paged_list_view.dart';

import 'news_card.dart';

class LocalNewsContent extends StatefulWidget {
  const LocalNewsContent({super.key});

  @override
  State<LocalNewsContent> createState() => _LocalNewsContentState();
}

class _LocalNewsContentState extends State<LocalNewsContent> {
  final GlobalKey<PagedListState> pagedListKey = GlobalKey<PagedListState>();
  late final ScrollOpacityController _opacityController;
  final ScrollController mainPageScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
          (_) {
        _opacityController = ScrollOpacityController(
          debugName: "Local news",
          scrollController: mainPageScrollController,
          onScroll: (newOpacity) {
            log.info("From Local news opacity is $newOpacity");
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
  }

  @override
  Widget build(BuildContext context) {

    return PagedList<NewsPost>(
      key: pagedListKey,
      scrollController: mainPageScrollController,
      firstPageProgressIndicatorBuilder: (_) => const InfiniteLoader(),
      newPageProgressIndicatorBuilder: (_) => const InfiniteLoader(),
      itemBuilder: (_, news, i) => NewsCard(
        post: news,
        newsChannel: NewsChannel.worldNews,
      ),
      fetchPage: (int page, int pageSize, bool initialFetch) async {
        return LocalNewsFetcher.fetchWorldNews(
          country: deviceCountry,
          pageSize: pageSize,
          fromCache: initialFetch,
        );
      },
    );
  }
}
