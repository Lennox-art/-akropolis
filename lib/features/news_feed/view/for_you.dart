import 'package:akropolis/features/news_feed/view/news_card.dart';
import 'package:akropolis/features/news_feed/models/models.dart';
import 'package:akropolis/features/news_feed/view_models/news_fetchers/for_you_news_fetcher.dart';
import 'package:flutter/material.dart';
import 'package:paged_list_view/paged_list_view.dart';
import 'package:akropolis/components/loader.dart';


class ForYouContent extends StatelessWidget {
  const ForYouContent({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<PagedListState> pagedListKey = GlobalKey<PagedListState>();

    return RefreshIndicator(
      onRefresh: () => pagedListKey.currentState!.refresh(),
      child: PagedList<NewsPost>(
        key: pagedListKey,
        firstPageProgressIndicatorBuilder: (_) => const InfiniteLoader(),
        newPageProgressIndicatorBuilder: (_) => const InfiniteLoader(),
        itemBuilder: (_, news, i) => NewsCard(
          post: news,
          newsChannel: NewsChannel.userPosts,
        ),
        fetchPage: (int page, int pageSize, bool initialFetch) async {
          /*return BlocProvider.of<ForYouNewsCubit>(context).fetchNews(
            page: page,
            pageSize: pageSize,
            fromCache: initialFetch,
            language: Language.en,
            sources: NewsSourceEnum.values.map((s) => s.name).toList(),
          );*/
          return ForYouNewsFetcher.fetchUserPostsNews(
            pageSize: pageSize,
            fromCache: initialFetch,
          );
        },
      ),
    );
  }
}
