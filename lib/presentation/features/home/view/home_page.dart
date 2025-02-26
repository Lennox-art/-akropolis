import 'dart:async';

import 'package:akropolis/domain/gen/assets.gen.dart';
import 'package:akropolis/domain/use_cases/fetch_post_comments_use_case.dart';

import 'package:akropolis/presentation/features/home/models/home_models.dart';
import 'package:akropolis/presentation/features/home/view_model/home_view_model.dart';
import 'package:akropolis/presentation/features/news_feed/view/news_feed_tab.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/news_feed_view_model.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:akropolis/presentation/ui/themes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

final ValueNotifier<double> bottomNavigationOpacity = ValueNotifier(1.0);

class HomePage extends StatefulWidget {
  const HomePage({
    required this.homeViewModel,
    super.key,
  });

  final HomeViewModel homeViewModel;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final StreamSubscription<ToastMessage> toastStreamSubscription;
  late final StreamSubscription<HomeState> homeStateStreamSubscription;

  @override
  void initState() {
    toastStreamSubscription = widget.homeViewModel.toastStream.listen(_onToastMessage);
    homeStateStreamSubscription = widget.homeViewModel.homeStream.listen(_onStateChange);
    super.initState();
  }

  void _onToastMessage(ToastMessage toast) {
    toast.show();
  }

  void _onStateChange(HomeState state) {}

  @override
  void dispose() {
    toastStreamSubscription.cancel();
    homeStateStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return DefaultTabController(
      length: widget.homeViewModel.allTabs.length,
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
                top: 12.0,
              ),
              child: ListenableBuilder(
                listenable: widget.homeViewModel,
                builder: (_, __) {
                  return widget.homeViewModel.homeState.map(
                        initial: (_) => Assets.profilePic.svg(),
                        error: (e) => Text(e.failure.message),
                        loading: (_) => const InfiniteLoader(),
                        ready: (r) {
                          String? profilePicture = r.appUser.profilePicture;
                          if (profilePicture == null) {
                            return Assets.profilePic.svg();
                          }

                          return CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(profilePicture),
                          );
                        },
                      ) ??
                      const SizedBox.shrink();
                },
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  widget.homeViewModel.logout();
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
          ),
          body: ListenableBuilder(
            listenable: widget.homeViewModel,
            builder: (_, __) {
              return widget.homeViewModel.homeState.map(
                initial: (i) => const Text("Initial"),
                error: (e) => Text(e.failure.message),
                loading: (l) => const InfiniteLoader(),
                ready: (r) {
                  return switch (widget.homeViewModel.currentTab) {
                    BottomNavigationTabs.newsFeed => NewsFeedTab(
                        currentUser: r.appUser,
                        newsFeedViewModel: NewsFeedViewModel(
                          FetchPostCommentsUseCase(
                            postRepository: GetIt.I(),
                          ),
                        ),
                      ),
                    BottomNavigationTabs.search => const SizedBox.shrink(),
                    BottomNavigationTabs.post => const SizedBox.shrink(),
                    BottomNavigationTabs.chat => const SizedBox.shrink(),
                    BottomNavigationTabs.profile => const SizedBox.shrink(),
                  };
                },
              );
            },
          ),
          bottomNavigationBar: ListenableBuilder(
            listenable: widget.homeViewModel,
            builder: (_, __) {
              BottomNavigationTabs currentTab = widget.homeViewModel.currentTab;

              return ValueListenableBuilder(
                valueListenable: bottomNavigationOpacity,
                builder: (_, opacity, __) {
                  return AnimatedOpacity(
                    opacity: opacity,
                    duration: const Duration(
                      seconds: 1,
                    ),
                    child: BottomNavigationBar(
                      currentIndex: widget.homeViewModel.currentTab.index,
                      onTap: (i) {
                        BottomNavigationTabs tab = widget.homeViewModel.allTabs[i];
                        switch (tab) {
                          case BottomNavigationTabs.post:
                            Navigator.of(context).pushNamed(
                              AppRoutes.createPost.path,
                            );
                            break;
                          default:
                            widget.homeViewModel.changeTab(tab);
                            break;
                        }
                      },
                      items: widget.homeViewModel.allTabs
                          .map(
                            (e) => BottomNavigationBarItem(
                              backgroundColor: theme.bottomNavigationBarTheme.backgroundColor?.withValues(alpha: opacity),
                              label: e.title,
                              icon: switch (e) {
                                BottomNavigationTabs.chat => Assets.chatsCircle.svg(
                                    color: currentTab == BottomNavigationTabs.chat ? primaryColor : null,
                                  ),
                                BottomNavigationTabs.profile => Assets.userIcon.svg(
                                    color: currentTab == BottomNavigationTabs.profile ? primaryColor : null,
                                  ),
                                _ => Icon(e.icon),
                              },
                              tooltip: e.title,
                            ),
                          )
                          .toList(),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
