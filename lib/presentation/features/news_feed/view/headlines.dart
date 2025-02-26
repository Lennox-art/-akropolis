import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:akropolis/presentation/features/news_feed/view/news_card.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/headlines_view_model.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:paged_list_view/paged_list_view.dart';

class HeadlinesContent extends StatelessWidget {
  const HeadlinesContent({
    required this.headlinesViewModel,
    super.key,
  });

  final HeadlinesViewModel headlinesViewModel;

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
        Result<List<NewsPost>?> headlinesResult = await headlinesViewModel.fetchHeadlinesPostsNews(
          pageSize: pageSize,
          fromCache: initialFetch,
        );

        switch (headlinesResult) {
          case Success<List<NewsPost>?>():
            return headlinesResult.data;
          case Error<List<NewsPost>?>():
            ToastError(message: headlinesResult.failure.message).show();
            return [];
        }
      },
    );
  }
}
