import 'dart:ui';

import 'package:akropolis/components/loader.dart';
import 'package:akropolis/components/scroll_opacity_controller.dart';
import 'package:akropolis/components/toast/toast.dart';
import 'package:akropolis/features/authentication/view_model/authentication_cubit/authentication_cubit.dart';
import 'package:akropolis/features/create_post/view_model/create_post_cubit.dart';
import 'package:akropolis/features/news_feed/models/models.dart';
import 'package:akropolis/features/news_feed/view/for_you.dart';
import 'package:akropolis/features/news_feed/view_models/news_fetchers/for_you_news_fetcher.dart';
import 'package:akropolis/features/on_boarding/view_model/user_cubit/user_cubit.dart';
import 'package:akropolis/gen/assets.gen.dart';
import 'package:akropolis/features/news_feed/view/local_news.dart';
import 'package:akropolis/features/news_feed/view/headlines.dart';
import 'package:akropolis/features/news_feed/view/world_news.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/routes/routes.dart';
import 'package:akropolis/theme/themes.dart';
import 'package:akropolis/utils/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

enum HomeTabs {
  forYou("For you"),
  worldNews("World News"),
  headlines("Headlines"),
  local("Local");

  final String title;

  const HomeTabs(this.title);
}

enum BottomNavigationTabs {
  home("Home", Icons.home),
  search("Search", Icons.search),
  post("New Post", Icons.add_box),
  chat("Chat", Icons.chat),
  profile("Profile", Icons.person_outline);

  final String title;
  final IconData icon;

  const BottomNavigationTabs(this.title, this.icon);
}

final ValueNotifier<double> bottomNavigationOpacity = ValueNotifier(1.0);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ValueNotifier<BottomNavigationTabs> bottomValue = ValueNotifier(
    BottomNavigationTabs.home,
  );



  final InfiniteScrollController carrouselController = InfiniteScrollController();

  final List<HomeTabs> tabs = HomeTabs.values;

  final List<BottomNavigationTabs> bottomTabs = BottomNavigationTabs.values;

  final List<({String imageurl, String title})> stories = const [
    (
      imageurl: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/CNN_International_logo.svg/2048px-CNN_International_logo.svg.png",
      title: "CNN"
    ),
    (
      imageurl: "https://play-lh.googleusercontent.com/-kP0io9_T-LULzdpmtb4E-nFYFwDIKW7cwBhOSRwjn6T2ri0hKhz112s-ksI26NFCKOg",
      title: "Sky Sports",
    ),
    (
      imageurl: "https://mymodernmet.com/wp/wp-content/uploads/2019/09/100k-ai-faces-4.jpg",
      title: "Jhane k",
    ),
    (
      imageurl:
          "https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://media.easy-peasy.ai/cd6f334c-db74-42d9-882b-b99d9e810dc0/e933bb79-b9b4-40a3-8417-2b15f44d5c45.png",
      title: "Keliim.n"
    ),
  ];



  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return DefaultTabController(
      length: tabs.length,
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          body: Stack(
            children: [
              Assets.background.image(
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill,
              ),
              NestedScrollView(
                headerSliverBuilder: (_, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      title: null,
                      expandedHeight: 170.0,
                      leading: Padding(
                        padding: const EdgeInsets.only(
                          left: 12.0,
                          top: 12.0,
                        ),
                        child: FutureBuilder(
                          future: BlocProvider.of<UserCubit>(context).getCurrentUser(),
                          builder: (_, snap) {
                            if (snap.connectionState != ConnectionState.done) {
                              return const InfiniteLoader();
                            }

                            String? profilePhoto = snap.data?.profilePicture;
                            if (profilePhoto == null || profilePhoto.isEmpty) {
                              return Assets.profilePic.svg();
                            }

                            return CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(profilePhoto),
                            );
                          },
                        ),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<AuthenticationCubit>(context).logout();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRoutes.login.path,
                              (_) => false,
                            );
                          },
                          icon: const Icon(
                            Icons.logout_outlined,
                            color: Colors.red,
                          ),
                        ),
                      ],
                      floating: false,
                      pinned: false,
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                        ),
                        child: SearchBar(
                          leading: const Icon(Icons.search),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          hintStyle: WidgetStatePropertyAll(
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
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 22.0,
                                ),
                                child: const CircleAvatar(
                                  backgroundColor: primaryColor,
                                  radius: 33,
                                  child: Icon(Icons.add),
                                ),
                              ),
                              ...stories.map(
                                (i) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: primaryColor,
                                        backgroundImage: CachedNetworkImageProvider(i.imageurl),
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
                    SliverToBoxAdapter(
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
                    ),
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
                          tabs: tabs
                              .map(
                                (t) => Tab(
                                  text: "${t.title} ${t == HomeTabs.local ? "(${deviceCountry ?? ''})" : ""}",
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children: tabs
                      .map(
                        (t) => switch (t) {
                          HomeTabs.forYou => const ForYouContent(),
                          HomeTabs.worldNews => const WorldNewsContent(),
                          HomeTabs.headlines => const HeadlinesContent(),
                          HomeTabs.local => const LocalNewsContent(),
                        },
                      )
                      .toList(),
                ),
              ),
            ],
          ),
          bottomNavigationBar: ValueListenableBuilder(
            valueListenable: bottomValue,
            builder: (_, value, __) => ValueListenableBuilder(
                valueListenable: bottomNavigationOpacity,
                builder: (_, opacity, __) {
                  return AnimatedOpacity(
                    opacity: opacity,
                    duration: const Duration(
                      seconds: 1,
                    ),
                    child: BottomNavigationBar(
                      currentIndex: value.index,
                      onTap: (i) {
                        switch (bottomTabs[i]) {
                          case BottomNavigationTabs.post:
                            Navigator.of(context).pushNamed(
                              AppRoutes.createPost.path,
                            );
                            break;
                          default:
                            bottomValue.value = bottomTabs[i];
                            break;
                        }
                      },
                      items: bottomTabs
                          .map(
                            (e) => BottomNavigationBarItem(
                              backgroundColor: theme.bottomNavigationBarTheme.backgroundColor?.withValues(alpha: opacity),
                              label: e.title,
                              icon: switch (e) {
                                BottomNavigationTabs.chat => Assets.chatsCircle.svg(
                                    color: value == BottomNavigationTabs.chat ? primaryColor : null,
                                  ),
                                BottomNavigationTabs.profile => Assets.userIcon.svg(
                                    color: value == BottomNavigationTabs.profile ? primaryColor : null,
                                  ),
                                _ => Icon(e.icon),
                              },
                              tooltip: e.title,
                            ),
                          )
                          .toList(),
                    ),
                  );
                }),
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
