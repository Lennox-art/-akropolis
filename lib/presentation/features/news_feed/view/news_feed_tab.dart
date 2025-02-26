import 'package:akropolis/domain/gen/assets.gen.dart';
import 'package:akropolis/domain/use_cases/fetch_World_news_post_use_case.dart';
import 'package:akropolis/domain/use_cases/fetch_for_you_post_use_case.dart';
import 'package:akropolis/domain/use_cases/fetch_highlights_post_use_case.dart';
import 'package:akropolis/domain/use_cases/fetch_local_news_post_use_case.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/presentation/features/news_feed/models/enums.dart';
import 'package:akropolis/presentation/features/news_feed/view/for_you.dart';
import 'package:akropolis/presentation/features/news_feed/view/headlines.dart';
import 'package:akropolis/presentation/features/news_feed/view/local_news.dart';
import 'package:akropolis/presentation/features/news_feed/view/world_news.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/for_you_view_model.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/headlines_view_model.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/local_news_view_model.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/news_feed_view_model.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/world_news_view_model.dart';
import 'package:akropolis/presentation/ui/themes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

class NewsFeedTab extends StatefulWidget {
  const NewsFeedTab({
    required this.newsFeedViewModel,
    super.key,
  });

  final NewsFeedViewModel newsFeedViewModel;

  @override
  State<NewsFeedTab> createState() => _NewsFeedTabState();
}

class _NewsFeedTabState extends State<NewsFeedTab> {
  final InfiniteScrollController carrouselController = InfiniteScrollController();
  final ForYouViewModel forYouViewModel = ForYouViewModel(
    fetchForYouPostUseCase: FetchForYouPostUseCase(
      postRepository: GetIt.I(),
    ),
  );

  final WorldNewsViewModel worldNewsViewModel = WorldNewsViewModel(
    fetchWorldNewsPostUseCase: FetchWorldNewsPostUseCase(
      postRepository: GetIt.I(),
    ),
  );

  final HeadlinesViewModel headlinesViewModel = HeadlinesViewModel(
    fetchHeadlinesPostUseCase: FetchHeadlinesPostUseCase(
      postRepository: GetIt.I(),
    ),
  );

  final LocalNewsViewModel localNewsViewModel = LocalNewsViewModel(
    fetchLocalNewsPostUseCase: FetchLocalNewsPostUseCase(
      postRepository: GetIt.I(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return DefaultTabController(
      length: widget.newsFeedViewModel.allTabs.length,
      child: Scaffold(
        extendBody: true,
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: SearchBar(
                    leading: const Icon(Icons.search),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    hintStyle: const WidgetStatePropertyAll(
                      TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    hintText: "Search feeds",
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    bottom: 0.0,
                    top: 5.0,
                  ),
                  child: SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            bottom: 22.0,
                          ),
                          child: CircleAvatar(
                            backgroundColor: primaryColor,
                            radius: 33,
                            child: Icon(Icons.add),
                          ),
                        ),
                        ...widget.newsFeedViewModel.stories.map(
                          (i) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: primaryColor,
                                  backgroundImage: CachedNetworkImageProvider(i.url),
                                  radius: 33,
                                ),
                                Text(i.title),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Divider(
                  color: Colors.white12,
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 130,
                  child: InfiniteCarousel.builder(
                    itemCount: 3,
                    itemExtent: 170,
                    center: true,
                    anchor: 0.0,
                    velocityFactor: 0.2,
                    onIndexChanged: (index) {},
                    controller: carrouselController,
                    axisDirection: Axis.horizontal,
                    loop: true,
                    itemBuilder: (context, itemIndex, realIndex) {
                      return switch (itemIndex) {
                        0 => Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text("Emblems"),
                                        Text(
                                          "0/38",
                                          style: theme.textTheme.headlineSmall?.copyWith(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 12.0),
                                        child: Assets.present.svg(
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        1 => Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Expanded(
                                    flex: 3,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "See what's trending today",
                                        style: TextStyle(
                                          height: 1.54,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 12.0),
                                        child: Assets.flame.svg(
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        2 => Card(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                                right: 8.0,
                                top: 18.0,
                                bottom: 18.0,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Today View Count",
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    "1.1K views",
                                    textAlign: TextAlign.start,
                                    style: theme.textTheme.headlineSmall?.copyWith(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        _ => const SizedBox.shrink(),
                      };
                    },
                  ),
                ),
              ),

              /*SliverToBoxAdapter(
                      child: BlocConsumer<CreatePostCubit, CreatePostState>(
                        listener: (context, state) {
                          state.mapOrNull(
                            loaded: (l) {
                              NewsPost? newPost = l.newPost;
                              if (newPost == null) return;

                              if (isTopRoute(context)) {
                                l.toast?.show();
                              }

                              ForYouNewsFetcher.cachedNews.add(newPost);
                            },
                          );
                        },
                        builder: (context, state) {
                          return state.map(
                            loading: (l) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    l.message?.message ?? "...",
                                  ),
                                  Builder(
                                    builder: (context) {
                                      if (l.progress == null) {
                                        return const SizedBox.shrink();
                                      }
                                      return FiniteLoader(progress: l.progress!);
                                    },
                                  ),
                                ],
                              );
                            },
                            loaded: (l) => const SizedBox.shrink(),
                          );
                        },
                      ),
                    ),*/
              const SliverToBoxAdapter(
                child: Divider(
                  color: Colors.white12,
                ),
              ),
              SliverPersistentHeader(
                floating: true,
                pinned: false,
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    isScrollable: true,
                    tabs: widget.newsFeedViewModel.allTabs
                        .map(
                          (t) => Tab(
                            text: "${t.title} ${t == NewsFeedTabEnum.local ? "(${deviceCountry ?? ''})" : ""}",
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: widget.newsFeedViewModel.allTabs
                .map(
                  (t) => switch (t) {
                    NewsFeedTabEnum.forYou => ForYouContent(
                        forYouViewModel: forYouViewModel,
                      ),
                    NewsFeedTabEnum.worldNews => WorldNewsContent(
                        worldNewsViewModel: worldNewsViewModel,
                      ),
                    NewsFeedTabEnum.headlines => HeadlinesContent(
                        headlinesViewModel: headlinesViewModel,
                      ),
                    NewsFeedTabEnum.local => LocalNewsContent(
                        localNewsViewModel: localNewsViewModel,
                      ),
                  },
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

// Custom Delegate for SliverPersistentHeader
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: Colors.transparent,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
