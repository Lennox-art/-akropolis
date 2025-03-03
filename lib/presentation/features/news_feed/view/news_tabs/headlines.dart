import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/models/news_card_model.dart';
import 'package:akropolis/domain/use_cases/fetch_post_comments_use_case.dart';
import 'package:akropolis/domain/use_cases/get_media_use_case.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:akropolis/presentation/features/news_feed/view/news_card.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/headlines_view_model.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/news_card_view_model.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/page_list_widgets.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HeadlinesContent extends StatefulWidget {
  const HeadlinesContent({
    required this.headlinesViewModel,
    required this.currentUser,
    required this.fetchPostCommentsUseCase,
    super.key,
  });

  final HeadlinesViewModel headlinesViewModel;
  final AppUser currentUser;
  final FetchPostCommentsUseCase fetchPostCommentsUseCase;

  @override
  State<HeadlinesContent> createState() => _HeadlinesContentState();
}

class _HeadlinesContentState extends State<HeadlinesContent> {

  final PageWrapper page = PageWrapper();

  late final PagingController<int, NewsCardPostModel> pagingController = PagingController(
    firstPageKey: page.page,
  );

  Future<void> _fetchPageItems() async {
    try {
      Result<List<NewsCardPostModel>?> headlinesResult = await widget.headlinesViewModel.fetchHeadlinesPostsNews(
        pageSize: PageWrapper.pageSize,
        fromCache: page.initialFetch,
      );

      switch (headlinesResult) {
        case Success<List<NewsCardPostModel>?>():
          List<NewsCardPostModel> newItems = headlinesResult.data ?? [];
          int noOfNewItems = newItems.length;

          final isLastPage = noOfNewItems < PageWrapper.pageSize;
          if (isLastPage) {
            pagingController.appendLastPage(newItems);
            return;
          }

          final int nextPageKey = page.page++;
          pagingController.appendPage(newItems, nextPageKey);

          return;
        case Error<List<NewsCardPostModel>?>():
          pagingController.error = headlinesResult.failure.message;
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
    super.dispose();
  }


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
    return PagedListView<int, NewsCardPostModel>(
      shrinkWrap: true,
      pagingController: pagingController,
      physics: const NeverScrollableScrollPhysics(),
      builderDelegate: pagedChildBuilderDelegate(
        context: context,
        itemBuilder: (_, news, i) => NewsCard(
          post: news,
          user: widget.currentUser,
          newsCardViewModel: GetIt.I(),
        ),
        fetchPageItems: _fetchPageItems,
      ),
    );
  }
}
