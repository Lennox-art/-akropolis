import 'dart:async';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/domain/gen/assets.gen.dart';
import 'package:akropolis/domain/use_cases/fetch_post_comments_use_case.dart';
import 'package:akropolis/domain/use_cases/fetch_threads_use_case.dart';
import 'package:akropolis/presentation/features/create_post/view_model/create_post_view_model.dart';

import 'package:akropolis/presentation/features/home/models/home_models.dart';
import 'package:akropolis/presentation/features/home/view_model/home_view_model.dart';
import 'package:akropolis/presentation/features/news_feed/view/news_feed_tab.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/news_feed_view_model.dart';
import 'package:akropolis/presentation/features/profile/view/profile_screen.dart';
import 'package:akropolis/presentation/features/profile/view_model/profile_view_model.dart';
import 'package:akropolis/presentation/features/threads/view/threads_screen.dart';
import 'package:akropolis/presentation/features/threads/view_model/thread_view_model.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:akropolis/presentation/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final ValueNotifier<double> bottomNavigationOpacity = ValueNotifier(1.0);

class HomePage extends StatefulWidget {
  const HomePage({
    required this.homeViewModel,
    required this.createPostViewModel,
    super.key,
  });

  final HomeViewModel homeViewModel;
  final CreatePostViewModel createPostViewModel;

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

  void _onStateChange(HomeState state) {
    state.mapOrNull(initial: (_) {
      //User has logged out
      GetIt.I<FetchPostCommentsUseCase>().reset();
      GetIt.I<CreatePostViewModel>().reset();
    });
  }

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
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Assets.background.image(
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill,
              ),
              ListenableBuilder(
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
                            homeViewModel: widget.homeViewModel,
                            newsFeedViewModel: NewsFeedViewModel(
                              GetIt.I(),
                            ),
                          ),
                        BottomNavigationTabs.search => const SizedBox.shrink(),
                        BottomNavigationTabs.post => const SizedBox.shrink(),
                        BottomNavigationTabs.chat => ThreadsScreen(
                            threadViewModel: ThreadViewModel(
                              fetchThreadsUseCase: FetchThreadsUseCase(
                                messageRepository: GetIt.I(),
                                userRepository: GetIt.I(),
                                authenticationRepository: GetIt.I(),
                              ),
                              messageRepository: GetIt.I(),
                              authenticationRepository: GetIt.I(),
                            ),
                          ),
                        BottomNavigationTabs.profile => ProfileScreen(
                            profileViewModel: ProfileViewModel(
                              userRepository: GetIt.I(),
                              authenticationRepository: GetIt.I(),
                              postRepository: GetIt.I(),
                            ),
                          ),
                      };
                    },
                  );
                },
              ),
              Align(
                alignment: Alignment.topCenter,
                child: ListenableBuilder(
                  listenable: widget.createPostViewModel,
                  builder: (_, __) {
                    return widget.createPostViewModel.createPostState.mapOrNull(
                          loading: (l) {
                            ProgressModel? progressModel = l.progress;
                            if (progressModel == null) return const InfiniteLoader();
                            return FiniteLoader(progress: progressModel);
                          },
                        ) ??
                        const SizedBox.shrink();
                  },
                ),
              )
            ],
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
