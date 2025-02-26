import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/local_news_view_model.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:paged_list_view/paged_list_view.dart';

import 'news_card.dart';

class LocalNewsContent extends StatelessWidget {
  const LocalNewsContent({
    required this.localNewsViewModel,
    super.key,
  });

  final LocalNewsViewModel localNewsViewModel;

  /*late final ScrollOpacityController _opacityController;
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
  }*/
  @override
  Widget build(BuildContext context) {
    final GlobalKey<PagedListState> pagedListKey = GlobalKey<PagedListState>();
    return PagedList<NewsPost>(
      key: pagedListKey,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      firstPageProgressIndicatorBuilder: (_) => const InfiniteLoader(),
      newPageProgressIndicatorBuilder: (_) => const InfiniteLoader(),
      itemBuilder: (_, news, i) => NewsCard(
        post: news,
        newsChannel: NewsChannel.worldNews,
      ),
      fetchPage: (int page, int pageSize, bool initialFetch) async {
        Result<List<NewsPost>?> localNewsResult = await localNewsViewModel.fetchLocalPostsNews(
          pageSize: pageSize,
          fromCache: initialFetch,
          country: deviceCountry ?? 'us',
        );

        switch (localNewsResult) {
          case Success<List<NewsPost>?>():
            return localNewsResult.data;
          case Error<List<NewsPost>?>():
            ToastError(message: localNewsResult.failure.message).show();
            return [];
        }
      },
    );
  }
}
