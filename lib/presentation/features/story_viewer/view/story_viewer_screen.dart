import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/use_cases/get_media_use_case.dart';
import 'package:akropolis/presentation/features/story_viewer/view_model/story_viewer_item_view_model.dart';
import 'package:akropolis/presentation/features/story_viewer/view_model/story_viewer_view_model.dart';
import 'package:akropolis/presentation/ui/components/app_video_player.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/name_extension.dart';
import 'package:akropolis/presentation/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class StoryViewerScreen extends StatefulWidget {
  const StoryViewerScreen({
    required this.storyViewerViewModel,
    required this.getMediaUseCase,
    super.key,
  });

  final StoryViewerViewModel storyViewerViewModel;
  final GetMediaUseCase getMediaUseCase;

  @override
  State<StoryViewerScreen> createState() => _StoryViewerScreenState();
}

class _StoryViewerScreenState extends State<StoryViewerScreen> {
  late final PageController pageController = PageController(initialPage: widget.storyViewerViewModel.initialIndex);

  @override
  void initState() {
    pageController.addListener(loadMoreItems);
    WidgetsBinding.instance.addPostFrameCallback((_) => loadMoreItems());
    super.initState();
  }

  void loadMoreItems() {
    int currentIndex = pageController.page?.toInt() ?? 0;
    int finalIndex = widget.storyViewerViewModel.noOfItems - 1;
    print("currentIndex = $currentIndex : finalIndex = $finalIndex");
    if (currentIndex + 1 >= finalIndex) widget.storyViewerViewModel.loadUserStories();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: ListenableBuilder(
          listenable: widget.storyViewerViewModel,
          builder: (_, __) {
            return PageView.builder(
              controller: pageController,
              pageSnapping: true,
              itemCount: widget.storyViewerViewModel.noOfItems,
              itemBuilder: (_, i) {
                List<UserStory> usersStories = widget.storyViewerViewModel.getUserStories(i);
                print("Getting stories for $i / ${widget.storyViewerViewModel.noOfItems}");

                return StoryItemView(
                  storyViewerItemViewModel: StoryViewerItemViewModel(
                    stories: usersStories,
                    getMediaUseCase: widget.getMediaUseCase,
                    userStoryRepository: GetIt.I(),
                    currentUser: widget.storyViewerViewModel.currentUser,
                  ),
                  onNextUser: () {
                    bool isLastPage = i == widget.storyViewerViewModel.noOfItems - 1;
                    if (isLastPage) {
                      return;
                    }

                    pageController.nextPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOutQuad,
                    );
                  },
                  onPreviousUser: () {
                    bool isFirstPage = i == 0;
                    if (isFirstPage) {
                      return;
                    }

                    pageController.previousPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOutQuad,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class StoryItemView extends StatelessWidget {
  const StoryItemView({
    required this.storyViewerItemViewModel,
    required this.onNextUser,
    required this.onPreviousUser,
    super.key,
  });

  final Function() onNextUser;
  final Function() onPreviousUser;
  final StoryViewerItemViewModel storyViewerItemViewModel;

  void onNext() {
    if (storyViewerItemViewModel.isLastIndex) {
      print("Last video for user");
      onNextUser();
      return;
    }

    print("Next video for user");
    storyViewerItemViewModel.goToNextStory();
  }

  void onPrevious() {
    if (storyViewerItemViewModel.isFirstIndex) {
      print("First video for user");
      onPreviousUser();
      return;
    }

    print("Previous video for user");
    storyViewerItemViewModel.goToPreviousStory();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: storyViewerItemViewModel,
      builder: (_, __) {
        UserStory story = storyViewerItemViewModel.currentStory;
        return Flex(
          direction: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flex(
                direction: Axis.horizontal,
                children: List.generate(
                  storyViewerItemViewModel.noOfItems,
                  (i) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Container(
                          height: 5,
                          decoration: BoxDecoration(
                            color: i <= storyViewerItemViewModel.currentIndex ? Colors.white : Colors.grey,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: CircleAvatar(
                          child: storyViewerItemViewModel.profilePicState.map(
                            initial: (_) => const Icon(Icons.person),
                            downloadingMedia: (p) {
                              ProgressModel? progress = p.progress;
                              if (progress == null) return const InfiniteLoader();
                              return CircularFiniteLoader(progress: progress);
                            },
                            downloadedMedia: (d) {
                              return CircleAvatar(
                                radius: 18,
                                backgroundImage: FileImage(d.media.file),
                              );
                            },
                            errorDownloadingMedia: (_) => const Icon(Icons.broken_image_outlined),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(story.author.name.capitalize),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: Navigator.of(context).pop,
                    child: const Text(
                      'X',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: storyViewerItemViewModel.thumbnailState.map(
                          initial: (_) => IconButton(
                            onPressed: storyViewerItemViewModel.downloadData,
                            icon: const Icon(Icons.touch_app),
                          ),
                          downloadingMedia: (d) {
                            ProgressModel? progress = d.progress;
                            if (progress == null) {
                              return const InfiniteLoader();
                            }

                            return CircularFiniteLoader(progress: progress);
                          },
                          downloadedMedia: (d) {
                            return storyViewerItemViewModel.videoState.map(
                              initial: (_) {
                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.file(
                                      d.media.file,
                                      fit: BoxFit.fill,
                                    ),
                                    IconButton(
                                      onPressed: storyViewerItemViewModel.downloadData,
                                      icon: const Icon(Icons.refresh),
                                    ),
                                  ],
                                );
                              },
                              downloadingMedia: (d) {
                                ProgressModel? progress = d.progress;
                                if (progress == null) {
                                  return const InfiniteLoader();
                                }

                                return CircularFiniteLoader(progress: progress);
                              },
                              downloadedMedia: (d) {
                                return CachedVideoPlayer(
                                  key: UniqueKey(),
                                  file: d.media.file,
                                  autoPlay: true,
                                  onComplete: () {
                                    print("Video has been complete ${storyViewerItemViewModel.currentIndex}");
                                    onNext();
                                  },
                                  showControls: false,
                                );
                              },
                              errorDownloadingMedia: (e) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      e.failure.message,
                                      style: const TextStyle(color: errorColor),
                                    ),
                                    IconButton(
                                      onPressed: storyViewerItemViewModel.downloadData,
                                      icon: const Icon(Icons.refresh),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          errorDownloadingMedia: (e) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  e.failure.message,
                                  style: const TextStyle(color: errorColor),
                                ),
                                IconButton(
                                  onPressed: storyViewerItemViewModel.downloadData,
                                  icon: const Icon(Icons.refresh),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: onPrevious,
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: onNext,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              story.viewers.length.toString(),
              textAlign: TextAlign.center,
            )
          ],
        );
      },
    );
  }
}
