import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/use_cases/fetch_post_comments_use_case.dart';
import 'package:akropolis/domain/use_cases/get_media_use_case.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:akropolis/presentation/features/news_feed/view/news_card.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/for_you_view_model.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/news_card_view_model.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/page_list_widgets.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ForYouContent extends StatefulWidget {
  const ForYouContent({
    required this.currentUser,
    required this.forYouViewModel,
    required this.fetchPostCommentsUseCase,
    super.key,
  });

  final AppUser currentUser;
  final ForYouViewModel forYouViewModel;
  final FetchPostCommentsUseCase fetchPostCommentsUseCase;

  @override
  State<ForYouContent> createState() => _ForYouContentState();
}

class _ForYouContentState extends State<ForYouContent> {
  final PageWrapper page = PageWrapper();

  late final PagingController<int, NewsPost> pagingController = PagingController(
    firstPageKey: page.page,
  );

  Future<void> _fetchPageItems() async {
    try {
      Result<List<NewsPost>?> forYouHighlightResult = await widget.forYouViewModel.fetchForYouPostsNews(
        pageSize: PageWrapper.pageSize,
        fromCache: page.initialFetch,
      );

      switch (forYouHighlightResult) {
        case Success<List<NewsPost>?>():
          if (page.initialFetch) page.initialFetch = false;
          List<NewsPost> newItems = forYouHighlightResult.data ?? [];
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
          pagingController.error = forYouHighlightResult.failure.message;
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
        _opacityController = ScrollOpacityController(
          debugName: "For you",
          scrollController: mainPageScrollController,
          onScroll: (newOpacity) {
            log.info("From For you opacity is $newOpacity");
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
              future: widget.forYouViewModel.fetchForYouPostsNews(
                pageSize: 10,
                fromCache: true,
              ),
              builder: (_, snap) {
                if (snap.connectionState != ConnectionState.done) {
                  return const InfiniteLoader();
                }

                Result<List<NewsPost>?> forYouHighlightResult = snap.requireData;

                switch (forYouHighlightResult) {
                  case Success<List<NewsPost>?>():
                    return ForYouHighlightCarrousel(
                      newsPost: forYouHighlightResult.data ?? [],
                      currentUser: widget.currentUser,
                      fetchPostCommentsUseCase: widget.fetchPostCommentsUseCase,
                    );
                  case Error<List<NewsPost>?>():
                    return Text(forYouHighlightResult.failure.message);
                }
              },
            ),
            PagedListView<int, NewsPost>(
              shrinkWrap: true,
              pagingController: pagingController,
              physics: const ClampingScrollPhysics(),
              builderDelegate: pagedChildBuilderDelegate(
                context: context,
                itemBuilder: (_, news, i) => ForYouCard(
                  post: news,
                  newsCardViewModel: NewsCardViewModel(
                    newsPost: news,
                    newsChannel: NewsChannel.userPosts,
                    appUser: widget.currentUser,
                    getMediaUseCase: GetMediaUseCase(
                      localDataStorageService: GetIt.I(),
                      localFileStorageService: GetIt.I(),
                      remoteFileStorageService:GetIt.I(),
                    ),
                    postRepository: GetIt.I(),
                    fetchPostCommentsUseCase: widget.fetchPostCommentsUseCase,
                  ),
                  currentUser: widget.currentUser,
                ),
                fetchPageItems: _fetchPageItems,
              ),
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
    required this.currentUser,
    required this.fetchPostCommentsUseCase,
    super.key,
  });

  final FetchPostCommentsUseCase fetchPostCommentsUseCase;
  final AppUser currentUser;
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
                newsCardViewModel: NewsCardViewModel(
                  newsPost: newsPost[itemIndex],
                  newsChannel: NewsChannel.userPosts,
                  getMediaUseCase: GetMediaUseCase(
                    localDataStorageService: GetIt.I(),
                    localFileStorageService: GetIt.I(),
                    remoteFileStorageService:GetIt.I(),
                  ),
                  appUser: currentUser,
                  postRepository: GetIt.I(),
                  fetchPostCommentsUseCase: fetchPostCommentsUseCase,
                ),
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
        ),
      ],
    );
  }
}
