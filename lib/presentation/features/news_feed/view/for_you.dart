import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/use_cases/fetch_post_comments_use_case.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:akropolis/presentation/features/news_feed/view/news_card.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/for_you_view_model.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/news_card_view_model.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:paged_list_view/paged_list_view.dart';

class ForYouContent extends StatelessWidget {
  const ForYouContent({
    required this.currentUser,
    required this.forYouViewModel,
    required this.fetchPostCommentsUseCase,
    super.key,
  });

  final AppUser currentUser;
  final ForYouViewModel forYouViewModel;
  final FetchPostCommentsUseCase fetchPostCommentsUseCase;

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
    final GlobalKey<PagedListState> pagedListKey = GlobalKey<PagedListState>();

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
              future: forYouViewModel.fetchForYouPostsNews(
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
                      currentUser: currentUser,
                      fetchPostCommentsUseCase: fetchPostCommentsUseCase,
                    );
                  case Error<List<NewsPost>?>():
                    return Text(forYouHighlightResult.failure.message);
                }
              },
            ),
            PagedList<NewsPost>(
              shrinkWrap: true,
              key: pagedListKey,
              scrollPhysics: const ClampingScrollPhysics(),
              firstPageProgressIndicatorBuilder: (_) => const InfiniteLoader(),
              newPageProgressIndicatorBuilder: (_) => const InfiniteLoader(),
              itemBuilder: (_, news, i) => ForYouCard(
                post: news,
                newsCardViewModel: NewsCardViewModel(
                  newsPost: news,
                  newsChannel: NewsChannel.userPosts,
                  appUser: currentUser,
                  postRepository: GetIt.I(),
                  fetchPostCommentsUseCase: fetchPostCommentsUseCase,
                ),
                currentUser: currentUser,
              ),
              fetchPage: (int page, int pageSize, bool initialFetch) async {
                Result<List<NewsPost>?> forYouHighlightResult = await forYouViewModel.fetchForYouPostsNews(
                  pageSize: pageSize,
                  fromCache: initialFetch,
                );

                switch (forYouHighlightResult) {
                  case Success<List<NewsPost>?>():
                    return forYouHighlightResult.data;
                  case Error<List<NewsPost>?>():
                    ToastError(message: forYouHighlightResult.failure.message).show();
                    return [];
                }
              },
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
