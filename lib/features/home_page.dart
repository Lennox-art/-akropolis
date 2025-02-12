import 'package:akropolis/components/loader.dart';
import 'package:akropolis/features/authentication/view_model/authentication_cubit/authentication_cubit.dart';
import 'package:akropolis/features/create_post/view_model/create_post_cubit.dart';
import 'package:akropolis/features/news_feed/view/for_you.dart';
import 'package:akropolis/features/on_boarding/view_model/user_cubit/user_cubit.dart';
import 'package:akropolis/gen/assets.gen.dart';
import 'package:akropolis/features/news_feed/view/local_news.dart';
import 'package:akropolis/features/news_feed/view/headlines.dart';
import 'package:akropolis/features/news_feed/view/world_news.dart';
import 'package:akropolis/routes/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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
  post("New Post", Icons.add),
  chat("Chat", Icons.chat),
  profile("Profile", Icons.person_outline);

  final String title;
  final IconData icon;

  const BottomNavigationTabs(this.title, this.icon);
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<HomeTabs> tabs = HomeTabs.values;
  final List<BottomNavigationTabs> bottomTabs = BottomNavigationTabs.values;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<BottomNavigationTabs> bottomValue = ValueNotifier(
      BottomNavigationTabs.home,
    );

    return DefaultTabController(
      length: tabs.length,
      child: SafeArea(
        child: Scaffold(
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
                      expandedHeight: 200.0,
                      leading: FutureBuilder(
                        future: BlocProvider.of<UserCubit>(context).getCurrentUser(),
                        builder: (_, snap) {
                          if (snap.connectionState != ConnectionState.done) {
                            return const InfiniteLoader();
                          }
        
                          String? profilePhoto = snap.data?.profilePicture;
                          if (profilePhoto == null || profilePhoto.isEmpty) {
                            return const Icon(Icons.person);
                          }
        
                          return CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(profilePhoto),
                          );
                        },
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
                      child: SizedBox(
                        height: 150,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            SizedBox(
                              width: 150,
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text("Emblems"),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        const Text("0/38"),
                                        Assets.present.svg(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "See what's trending today",
                                      textAlign: TextAlign.center,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        const SizedBox(),
                                        Assets.flame.svg(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 150,
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Today's view count",
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "1.1K views",
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: BlocBuilder<CreatePostCubit, CreatePostState>(
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
                                  Builder(builder: (context) {
                                    if (l.progress == null) {
                                      return const SizedBox.shrink();
                                    }
                                    return FiniteLoader(progress: l.progress!);
                                  }),
                                ],
                              );
                            },
                            loaded: (l) => const SizedBox.shrink(),
                          );
                        },
                      ),
                    ),
                    SliverPersistentHeader(
                      floating: true,
                      pinned: true, // Pins the tab bar
                      delegate: _SliverAppBarDelegate(
                        TabBar(
                          isScrollable: true,
                          tabs: tabs.map(
                                (t) => Tab(
                              text: t.title,
                            ),
                          ).toList(),
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
            builder: (_, value, __) => BottomNavigationBar(
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
              items: bottomTabs.map(
                    (e) => BottomNavigationBarItem(
                      label: e.title,
                      icon: Icon(e.icon),
                      tooltip: e.title,
                    ),
                  ).toList(),
            ),
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
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
