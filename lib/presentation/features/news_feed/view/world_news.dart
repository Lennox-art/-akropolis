import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/use_cases/fetch_post_comments_use_case.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/news_card_view_model.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/world_news_view_model.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:paged_list_view/paged_list_view.dart';

import 'news_card.dart';

class WorldNewsContent extends StatelessWidget {
  const WorldNewsContent({
    required this.worldNewsViewModel,
    required this.fetchPostCommentsUseCase,
    required this.currentUser,
    super.key,
  });

  final WorldNewsViewModel worldNewsViewModel;
  final FetchPostCommentsUseCase fetchPostCommentsUseCase;
  final AppUser currentUser;

  /*late final ScrollOpacityController _opacityController;
  final ScrollController mainPageScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
        _opacityController = ScrollOpacityController(
          debugName: "World news",
          scrollController: mainPageScrollController,
          onScroll: (newOpacity) {
            log.info("From World news opacity is $newOpacity");
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
        newsCardViewModel: NewsCardViewModel(
          newsPost: news,
          newsChannel: NewsChannel.worldNews,
          appUser: currentUser,
          postRepository: GetIt.I(),
          fetchPostCommentsUseCase: fetchPostCommentsUseCase,
        ),
      ),
      fetchPage: (int page, int pageSize, bool initialFetch) async {
        Result<List<NewsPost>?> headlinesResult = await worldNewsViewModel.fetchWorldPostsNews(
          pageSize: pageSize,
          fromCache: initialFetch,
          country: null,
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
