import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/use_cases/fetch_post_comments_use_case.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/local_news_view_model.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/news_card_view_model.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/page_list_widgets.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'news_card.dart';

class LocalNewsContent extends StatefulWidget {
  const LocalNewsContent({
    required this.currentUser,
    required this.localNewsViewModel,
    required this.fetchPostCommentsUseCase,
    super.key,
  });

  final AppUser currentUser;
  final LocalNewsViewModel localNewsViewModel;
  final FetchPostCommentsUseCase fetchPostCommentsUseCase;

  @override
  State<LocalNewsContent> createState() => _LocalNewsContentState();
}

class _LocalNewsContentState extends State<LocalNewsContent> {

  final PageWrapper page = PageWrapper();

  late final PagingController<int, NewsPost> pagingController = PagingController(
    firstPageKey: page.page,
  );

  Future<void> _fetchPageItems() async {
    try {
      Result<List<NewsPost>?> fetchLocalNewsResult = await widget.localNewsViewModel.fetchLocalPostsNews(
        pageSize: PageWrapper.pageSize,
        fromCache: page.initialFetch,
        country: deviceCountry ?? 'us',
      );

      switch (fetchLocalNewsResult) {
        case Success<List<NewsPost>?>():
          if (page.initialFetch) page.initialFetch = false;
          List<NewsPost> newItems = fetchLocalNewsResult.data ?? [];
          int noOfNewItems = newItems.length;

          final isLastPage = noOfNewItems < PageWrapper.pageSize;
          if (isLastPage) {
            pagingController.appendLastPage(newItems);
            return;
          }

          final int nextPageKey = page.page++;
          pagingController.appendPage(newItems, nextPageKey);

          return;
        case Error<List<NewsPost>?>():
          pagingController.error = fetchLocalNewsResult.failure.message;
          return;
      }
    } catch (error, trace) {
      pagingController.error = error;
    }
  }

  @override
  void initState() {
    pagingController.addPageRequestListener((p) {
      page.page = p;
      _fetchPageItems();
    });
    super.initState();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

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
    return PagedListView<int, NewsPost>(
      shrinkWrap: true,
      pagingController: pagingController,
      physics: const ClampingScrollPhysics(),
      builderDelegate: pagedChildBuilderDelegate(
        context: context,
        itemBuilder: (_, news, i) => NewsCard(
          post: news,
          newsCardViewModel: NewsCardViewModel(
            newsPost: news,
            newsChannel: NewsChannel.worldNews,
            appUser: widget.currentUser,
            postRepository: GetIt.I(),
            fetchPostCommentsUseCase: widget.fetchPostCommentsUseCase,
          ),
        ),
        fetchPageItems: _fetchPageItems,
      ),
    );
  }
}
