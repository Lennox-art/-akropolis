import 'dart:collection';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/use_cases/get_media_use_case.dart';
import 'package:akropolis/presentation/features/story_viewer/model/story_viewer_model.dart';
import 'package:akropolis/presentation/features/user_stories/model/user_stories_state.dart';
import 'package:akropolis/presentation/features/user_stories/view_model/user_stories_view_model.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/themes.dart';
import 'package:flutter/material.dart';

class UserStoriesScreen extends StatelessWidget {
  const UserStoriesScreen({
    required this.userStoriesViewModel,
    required this.getMediaUseCase,
    super.key,
  });

  final UserStoriesViewModel userStoriesViewModel;
  final GetMediaUseCase getMediaUseCase;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: userStoriesViewModel,
      builder: (context, __) {
        MyUserStoryState myUserStoryState = userStoriesViewModel.myUserStoryState;
        UserStoryState userStoryState = userStoriesViewModel.userStoryState;

        List<UserStory> myUserStories = userStoriesViewModel.myUserStoriesList;
        List<List<UserStory>> storyItems = userStoriesViewModel.userStoriesList.values.toList();
        bool isLoading = userStoryState is LoadingUserStoryState;
        AppUser currentUser = userStoriesViewModel.currentUser;

        print("IsLoading : $isLoading");

        return RefreshIndicator(
          onRefresh: () => userStoriesViewModel.refresh(),
          child: Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.createUserPostPage.path,
                    );
                  },
                  child: const CircleAvatar(
                    backgroundColor: primaryColor,
                    radius: 33,
                    child: Icon(Icons.add),
                  ),
                ),
              ),
              Expanded(
                child: Visibility(
                  visible: myUserStories.isNotEmpty || storyItems.isNotEmpty,
                  replacement: GestureDetector(
                    onTap: () {
                      userStoriesViewModel.loadMyUserStories();
                      userStoriesViewModel.loadUserStories();
                    },
                    child: const Text(
                      "Be the first to post a story",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      bool isAtEndOfList = scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent;
                      if (!isLoading && isAtEndOfList) {
                        userStoriesViewModel.loadUserStories();
                      }

                      return true;
                    },
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      //1 -> my user story
                      //userStories list length
                      //isLoading ? 1 : 0
                      itemCount: 1 + storyItems.length + (userStoryState is LoadingUserStoryState ? 1 : 0),
                      itemBuilder: (context, index) {

                        // My user story
                        if (index == 0) {
                          return myUserStoryState.map(
                            loading: (_) => const InfiniteLoader(),
                            loaded: (_) {
                              if (myUserStories.isEmpty) return const SizedBox.shrink();
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    AppRoutes.storyViewer.path,
                                    arguments: StoryViewerDto(
                                      initialStories: [...myUserStories, ...storyItems.expand((e) => e)],
                                      initialStory: myUserStories.first,
                                      currentUser: currentUser,
                                    ),
                                  );
                                },
                                child: StoryItem(
                                  storyItem: myUserStories.first,
                                  getMediaUseCase: getMediaUseCase,
                                  color: Colors.pink,
                                ),
                              );
                            },
                          );
                        }

                        // Loading indicator at the end
                        int lastItemInListIndex = isLoading ? storyItems.length + 1 : storyItems.length;
                        bool isLastItemWhileLoading = index == lastItemInListIndex;
                        if (isLastItemWhileLoading && isLoading) return CircularFiniteLoader(progress: ProgressModel(sent: 60, total: 100));

                        // Other user stories
                        final storyItem = storyItems[index - 1];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              AppRoutes.storyViewer.path,
                              arguments: StoryViewerDto(
                                initialStories: storyItems.expand((e) => e).toList(),
                                initialStory: storyItem.first,
                                currentUser: currentUser,
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: StoryItem(
                              storyItem: storyItem.first,
                              getMediaUseCase: getMediaUseCase,
                              color: storyItem.any((e) => e.viewers.contains(currentUser.id)) ? Colors.grey : Colors.green,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class StoryItem extends StatefulWidget {
  const StoryItem({
    required this.storyItem,
    required this.getMediaUseCase,
    required this.color,
    super.key,
  });

  final UserStory storyItem;
  final GetMediaUseCase getMediaUseCase;
  final Color color;

  @override
  State<StoryItem> createState() => _StoryItemState();
}

class _StoryItemState extends State<StoryItem> {
  final ValueNotifier<ProgressModel?> progressNotifier = ValueNotifier(null);
  final ValueNotifier<MediaData?> mediaDataNotifier = ValueNotifier(null);

  @override
  void initState() {
    widget.getMediaUseCase.getMediaFromUrl(
      widget.storyItem.thumbnailUrl,
      onProgress: (p) {
        progressNotifier.value = p;
      },
    ).then(
      (result) {
        progressNotifier.value = null;

        switch (result) {
          case Success<MapEntry<String, MediaData>>():
            mediaDataNotifier.value = result.data.value;
            break;
          case Error<MapEntry<String, MediaData>>():
            break;
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: progressNotifier,
      builder: (_, progress, __) {
        return CircleAvatar(
          backgroundColor: widget.color,
          radius: 32,
          child: Builder(
            builder: (context) {
              if (progress != null) return CircularFiniteLoader(progress: progress);

              return ValueListenableBuilder(
                valueListenable: mediaDataNotifier,
                builder: (_, mediaData, __) {
                  if (mediaData == null) {
                    return IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.refresh),
                    );
                  }
                  return CircleAvatar(
                    radius: 30,
                    backgroundColor: primaryColor,
                    backgroundImage: FileImage(mediaData.file),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
