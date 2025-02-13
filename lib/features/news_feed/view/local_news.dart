import 'package:akropolis/components/loader.dart';
import 'package:akropolis/features/news_feed/models/models.dart';
import 'package:akropolis/features/news_feed/view_models/news_fetchers/local_news_fetcher.dart';
import 'package:akropolis/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:paged_list_view/paged_list_view.dart';

import 'news_card.dart';

class LocalNewsContent extends StatelessWidget {
  const LocalNewsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<PagedListState> pagedListKey = GlobalKey<PagedListState>();

    return PagedList<NewsPost>(
      key: pagedListKey,
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
