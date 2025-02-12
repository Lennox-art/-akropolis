import 'dart:io';
import 'dart:typed_data';

import 'package:akropolis/components/duration_picker.dart';
import 'package:akropolis/components/news_post_components.dart';
import 'package:akropolis/components/toast/toast.dart';
import 'package:akropolis/components/video_player_controls.dart';
import 'package:akropolis/features/authentication/models/authentication_models.dart';
import 'package:akropolis/features/news_feed/models/models.dart';
import 'package:akropolis/features/news_feed/view_models/news_fetchers/post_comment_fetcher.dart';
import 'package:akropolis/features/news_feed/view_models/post_news_post_reply_cubit/post_news_post_reply_cubit.dart';
import 'package:akropolis/features/on_boarding/view_model/user_cubit/user_cubit.dart';
import 'package:akropolis/local_storage/media_cache.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/networking/media_type_network_request.dart';
import 'package:akropolis/routes/routes.dart';
import 'package:akropolis/utils/constants.dart';
import 'package:akropolis/utils/validations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paged_list_view/paged_list_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:akropolis/components/loader.dart';
import 'package:path/path.dart' as path;

import 'news_card.dart';

enum PostMenu {
  share("Share"),
  bookmark("Bookmark"),
  notInterested("Not interested"),
  report("Report");

  final String title;

  const PostMenu(this.title);
}

class NewsDetailedViewPage extends StatefulWidget {
  const NewsDetailedViewPage({super.key});

  @override
  State<NewsDetailedViewPage> createState() => _NewsDetailedViewPageState();
}

class _NewsDetailedViewPageState extends State<NewsDetailedViewPage> {
  late final NewsPostDto? newsPostDto = ModalRoute.of(context)?.settings.arguments as NewsPostDto?;
  VideoPlayerController? postVideoController;

  @override
  void dispose() {
    postVideoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (newsPostDto == null) {
      return TextButton(
        onPressed: Navigator.of(context).pop,
        child: const Text("Back"),
      );
    }

    NewsPost newsPost = newsPostDto!.newsPost;
    NewsChannel channel = newsPostDto!.channel;
    final GlobalKey<PagedListState> commentPagedListKey = GlobalKey<PagedListState>();

    final DocumentReference newsPostRef = FirebaseFirestore.instance.collection(channel.collection).doc(newsPost.id).withConverter<NewsPost>(
          fromFirestore: (snapshot, _) => NewsPost.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );

    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: null,
        actions: [
          ElevatedButton(
            onPressed: () async {
              Duration? videoDuration = await showDurationPickerDialog(
                context,
                maxDuration: maxVideoDuration,
              );
              if (videoDuration == null || !context.mounted) return;

              XFile? videoData = await getIt<ImagePicker>().pickVideo(
                source: ImageSource.camera,
                preferredCameraDevice: CameraDevice.rear,
                maxDuration: videoDuration,
              );
              if (videoData == null || !context.mounted) return;

              AppUser? user = await BlocProvider.of<UserCubit>(context).getCurrentUser();
              if (user == null || !context.mounted) return;

              String? videoError = await validateVideo(videoData.path);
              if (!context.mounted) return;

              if (videoError != null) {
                ToastError(title: "Post Video", message: videoError).show();
                return;
              }

              await BlocProvider.of<PostVideoReplyCubit>(context).createVideoReply(
                post: newsPost,
                file: File(videoData.path)..writeAsBytesSync(await videoData.readAsBytes()),
                user: user,
              );

              if (!context.mounted) return;

              Navigator.of(context).pushNamed(
                AppRoutes.postReplyScreen.path,
              );
            },
            style: theme.elevatedButtonTheme.style?.copyWith(
              fixedSize: const WidgetStatePropertyAll(
                Size(100, 40),
              ),
            ),
            child: const Text("Reply"),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Builder(
              builder: (context) {
                if (newsPost.author.imageUrl == null) {
                  return const Icon(Icons.person);
                }

                return CircleAvatar(
                  backgroundImage: NetworkImage(newsPost.author.imageUrl!),
                );
              },
            ),
            title: Text(newsPost.author.name),
            trailing: MenuAnchor(
              builder: (_, controller, __) {
                return IconButton(
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                      return;
                    }
                    controller.open();
                  },
                  icon: const Icon(Icons.more_vert),
                  tooltip: 'Post options',
                );
              },
              menuChildren: PostMenu.values
                  .map(
                    (menu) => MenuItemButton(
                      onPressed: () {},
                      style: theme.menuButtonTheme.style?.copyWith(
                        backgroundColor: WidgetStatePropertyAll(
                          menu == PostMenu.report ? Colors.red : null,
                        ),
                      ),
                      child: Text(menu.title),
                    ),
                  )
                  .toList(),
            ),
          ),
          BlocConsumer<PostVideoReplyCubit, PostVideoReplyState>(
            listener: (context, state) {
              state.mapOrNull(
                loaded: (l) {
                  l.message?.show();
                },
              );
            },
            builder: (context, state) {
              return state.mapOrNull(
                    loading: (l) {
                      if (newsPost.id != l.postId) return null;

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
                  ) ??
                  const SizedBox.shrink();
            },
          ),
          Container(
            height: 400,
            color: Colors.black12,
            child: FutureBuilder(
              future: whichMediaType(newsPost.postUrl),
              builder: (_, mediaTypeSnap) {
                if (mediaTypeSnap.connectionState != ConnectionState.done) {
                  return const InfiniteLoader();
                }

                MediaType mediaType = mediaTypeSnap.data ?? MediaType.unknown;
                if (mediaType == MediaType.unknown) {
                  return const Icon(
                    Icons.question_mark,
                    size: 350,
                  );
                }

                return StreamBuilder(
                  stream: MediaCache.downloadMedia(newsPost.postUrl),
                  builder: (_, mediaSnap) {
                    log.info("${newsPost.id} => ${mediaSnap.connectionState.name}");

                    if (mediaSnap.connectionState != ConnectionState.done) {
                      return const InfiniteLoader();
                    }

                    Uint8List? mediaData = mediaSnap.data;
                    if (mediaData == null) {
                      return const Icon(
                        Icons.question_mark,
                        size: 350,
                      );
                    }

                    if (mediaType == MediaType.image) {
                      return Image.memory(
                        mediaData,
                        height: 350,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          log.error(error.toString(), trace: stackTrace);
                          return const Icon(
                            Icons.broken_image,
                            size: 180,
                          );
                        },
                      );
                    }

                    String tempMediaFilePath = path.join(temporaryDirectory.path, newsPost.id);
                    File tempMediaFile = File(tempMediaFilePath)..writeAsBytesSync(mediaData);
                    final VideoPlayerController postVideoController = VideoPlayerController.file(
                      tempMediaFile,
                    );

                    this.postVideoController = postVideoController;

                    return FutureBuilder(
                      future: postVideoController.initialize(),
                      builder: (_, snap) {
                        if (snap.connectionState != ConnectionState.done) {
                          return const InfiniteLoader();
                        }

                        postVideoController.pause();

                        return ValueListenableBuilder(
                          valueListenable: postVideoController,
                          builder: (_, videoValue, __) {
                            return AspectRatio(
                              aspectRatio: videoValue.aspectRatio,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  VideoPlayer(postVideoController),
                                  VideoPlayerControls(
                                    isPlaying: videoValue.isPlaying,
                                    progress: videoValue.position,
                                    videoDuration: videoValue.duration,
                                    play: () => postVideoController.play(),
                                    pause: () => postVideoController.pause(),
                                    onSeek: (d) => postVideoController.seekTo(d),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          Text(
            newsPost.description,
            style: theme.textTheme.labelLarge,
          ),
          Text(
            newsPost.publishedAt.toIso8601String(),
            style: theme.textTheme.labelMedium?.copyWith(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Flex(
            direction: Axis.horizontal,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: StreamBuilder(
                        stream: newsPostRef.snapshots(includeMetadataChanges: true),
                        builder: (_, snap) {
                          NewsPost updatedPost = snap.data?.data() as NewsPost? ?? newsPost;
                          return NewsPostReactionWidget(
                            newsPost: updatedPost,
                            postsCollectionRef: newsPostRef,
                          );
                        },
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(Icons.chat_outlined),
                            FutureBuilder(
                              future: newsPostRef.collection(PostComment.collection).count().get(),
                              builder: (_, commentsCountSnap) {
                                if (commentsCountSnap.connectionState != ConnectionState.done) {
                                  return const InfiniteLoader();
                                }

                                int? commentsCount = commentsCountSnap.data?.count;

                                if (commentsCount == null) {
                                  return const Icon(Icons.question_mark);
                                }

                                return Text(commentsCount.toString());
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Card(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.circle_outlined),
                      ),
                    ),
                  ],
                ),
              ),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(
                    8.0,
                  ),
                  child: Icon(Icons.share),
                ),
              ),
            ],
          ),
          const Divider(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Replies"),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("View Activity"),
              ),
            ],
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: PagedList<PostComment>(
              shrinkWrap: true,
              key: commentPagedListKey,
              firstPageProgressIndicatorBuilder: (_) => const InfiniteLoader(),
              newPageProgressIndicatorBuilder: (_) => const InfiniteLoader(),
              itemBuilder: (_, comment, i) => PostCommentCard(
                post: newsPost,
                comment: comment,
                newsPostRef: newsPostRef,
              ),
              fetchPage: (_, int pageSize, bool initialFetch) async {
                return PostCommentFetcher.fetchPostsCommentsNews(
                  postCollection: channel.collection,
                  postId: newsPost.id,
                  pageSize: pageSize,
                  fromCache: initialFetch,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
