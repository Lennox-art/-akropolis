import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/gen/assets.gen.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/domain/utils/functions.dart';
import 'package:akropolis/presentation/features/news_feed/models/enums.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/news_card_view_model.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/post_comment_card_view_model.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/components/app_video_player.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/news_post_components.dart';
import 'package:akropolis/presentation/ui/themes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final NewsPost post;
  final NewsCardViewModel newsCardViewModel;

  const NewsCard({
    super.key,
    required this.post,
    required this.newsCardViewModel,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.newsDetailsPage.path,
          arguments: NewsPostDto(post, newsCardViewModel.newsChannel, newsCardViewModel.currentUser),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: post.thumbnailUrl.isNotEmpty,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16.0),
                ),
                child: CachedNetworkImage(
                  imageUrl: post.thumbnailUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    log.error(error.toString());
                    return const Icon(
                      Icons.broken_image,
                      size: 180,
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: post.author.imageUrl != null,
                        replacement: const CircleAvatar(
                          radius: 12,
                          child: Icon(Icons.person),
                        ),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundImage: CachedNetworkImageProvider(
                            post.author.imageUrl ?? '',
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          post.author.name,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        timeAgo(post.publishedAt),
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    post.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Visibility(
                        visible: post.author.imageUrl != null,
                        replacement: const CircleAvatar(
                          radius: 12,
                          child: Icon(Icons.person),
                        ),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundImage: CachedNetworkImageProvider(
                            post.author.imageUrl ?? '',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ListenableBuilder(
                        listenable: newsCardViewModel,
                        builder: (_, __) {
                          return Visibility(
                            visible: !newsCardViewModel.loadingComments,
                            replacement: const InfiniteLoader(),
                            child: Visibility(
                              visible: (newsCardViewModel.commentsCount ?? 0) > 0,
                              replacement: const Text(
                                "Be the first to reply",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              child: Text(
                                "+${newsCardViewModel.commentsCount ?? 0} Replies",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.share, size: 18),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert, size: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostCommentCard extends StatelessWidget {
  const PostCommentCard({
    required this.currentUser,
    required this.post,
    required this.comment,
    required this.postCommentCardViewModel,
    super.key,
  });

  final AppUser currentUser;
  final NewsPost post;
  final PostComment comment;
  final PostCommentCardViewModel postCommentCardViewModel;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    postCommentCardViewModel.downloadThumbnail();

    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ListenableBuilder(
            listenable: postCommentCardViewModel,
            builder: (_, __) {
              return postCommentCardViewModel.thumbnailMediaState.map(
                initial: (_) => const SizedBox.shrink(),
                downloadingMedia: (d) {
                  if (d.progress == null) {
                    return const InfiniteLoader();
                  }

                  return CircularFiniteLoader(progress: d.progress!);
                },
                downloadedMedia: (d) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                      image: DecorationImage(
                        image: FileImage(
                          d.media.file,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
                errorDownloadingMedia: (e) => IconButton(
                  onPressed: postCommentCardViewModel.downloadThumbnail,
                  icon: const Icon(
                    Icons.broken_image_outlined,
                  ),
                ),
              );
            },
          ),
        ),
        Text(comment.author.name),
        Text(timeAgo(comment.commentedAt)),
      ],
    );
  }
}

class ForYouHighlightCard extends StatelessWidget {
  final NewsCardViewModel newsCardViewModel;

  const ForYouHighlightCard({
    super.key,
    required this.newsCardViewModel,
  });

  NewsPost get post => newsCardViewModel.newsPost;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.newsDetailsPage.path,
          arguments: NewsPostDto(
            post,
            newsCardViewModel.newsChannel,
            newsCardViewModel.currentUser,
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(5.0),
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Visibility(
                visible: post.thumbnailUrl.isNotEmpty,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16.0),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: post.thumbnailUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) {
                      log.error(error.toString());
                      return const Icon(
                        Icons.broken_image,
                        size: 180,
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          post.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        timeAgo(post.publishedAt),
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Flex(
                    mainAxisSize: MainAxisSize.max,
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Visibility(
                              visible: post.author.imageUrl != null,
                              replacement: const CircleAvatar(
                                radius: 12,
                                child: Icon(
                                  Icons.person,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 12,
                                backgroundImage: CachedNetworkImageProvider(
                                  post.author.imageUrl ?? '',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                post.author.name,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.labelLarge?.copyWith(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Visibility(
                              visible: post.author.imageUrl != null,
                              replacement: const CircleAvatar(
                                radius: 12,
                                child: Icon(
                                  Icons.person,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 12,
                                backgroundImage: CachedNetworkImageProvider(
                                  post.author.imageUrl ?? '',
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: ListenableBuilder(
                                  listenable: newsCardViewModel,
                                  builder: (_, __) {
                                    return Visibility(
                                      visible: !newsCardViewModel.loadingComments,
                                      replacement: const InfiniteLoader(),
                                      child: Visibility(
                                        visible: (newsCardViewModel.commentsCount ?? 0) > 0,
                                        replacement: const Text(
                                          "Be the first to reply",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        child: Text(
                                          "+${newsCardViewModel.commentsCount ?? 0} Replies",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 3.0, right: 3.0),
                                    child: Icon(
                                      Icons.circle,
                                      size: 6,
                                    ),
                                  ),
                                  Icon(
                                    Icons.share,
                                  ),
                                  Icon(
                                    Icons.more_vert,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForYouCard extends StatelessWidget {
  final AppUser currentUser;
  final NewsPost post;
  final NewsCardViewModel newsCardViewModel;

  const ForYouCard({
    super.key,
    required this.currentUser,
    required this.post,
    required this.newsCardViewModel,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool alreadyVoted = post.reaction.log.contains(currentUser.id) || post.reaction.emp.contains(currentUser.id);
    ReactionDistribution distribution = ReactionDistribution(post.reaction);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.newsDetailsPage.path,
          arguments: NewsPostDto(post, newsCardViewModel.newsChannel, currentUser),
        );
      },
      child: Container(
        height: 400,
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.white12,
            ),
          ),
        ),
        child: Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Visibility(
                    visible: post.author.imageUrl != null,
                    replacement: const CircleAvatar(
                      radius: 12,
                      child: Icon(
                        Icons.person,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 12,
                      backgroundImage: CachedNetworkImageProvider(
                        post.author.imageUrl ?? '',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      post.author.name,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Visibility(
                visible: post.thumbnailUrl.isNotEmpty,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: post.thumbnailUrl,
                    height: 50,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) {
                      log.error(error.toString());
                      return const Icon(
                        Icons.broken_image,
                        size: 180,
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                post.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: distribution.logFlex,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      "${distribution.logPercent} % (${distribution.logCount})",
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: distribution.empFlex,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                    decoration: const BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      "${distribution.empPercent} % (${distribution.empCount})",
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: alreadyVoted ? null : () {},
                      child: Flex(
                        direction: Axis.horizontal,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Assets.fatArrowUp.svg(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Text(
                              "LGN",
                              style: theme.textTheme.labelSmall?.copyWith(color: secondaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(
                        color: Colors.orange,
                        width: 1.0,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: alreadyVoted ? null : () {},
                      child: Flex(
                        direction: Axis.horizontal,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Assets.fatArrowUp.svg(
                              color: Colors.orange,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Text(
                              "Emp",
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListenableBuilder(
              listenable: newsCardViewModel,
              builder: (_, __) {
                int? commentsCount = newsCardViewModel.commentsCount;
                if (commentsCount == null) {
                  return const Text("Replies");
                }

                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Replies ($commentsCount)",
                    textAlign: TextAlign.start,
                  ),
                );
              },
            ),
            ListenableBuilder(
              listenable: newsCardViewModel,
              builder: (_, __) {
                return newsCardViewModel.newsCardRepliesState.map(
                  initial: (_) => const SizedBox.shrink(),
                  loading: (_) => const InfiniteLoader(),
                  errorState: (e) => IconButton(
                    onPressed: newsCardViewModel.fetchPostComments,
                    icon: const Icon(
                      Icons.refresh,
                    ),
                  ),
                  loaded: (e) {
                    bool hasReplies = (newsCardViewModel.commentsThumbnails?.entries ?? {}).isNotEmpty;
                    if (!hasReplies) return const SizedBox.shrink();

                    return SizedBox(
                      height: 70,
                      child: Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: newsCardViewModel.commentsThumbnails?.entries.map((e) {
                              return Flexible(
                                fit: FlexFit.loose,
                                child: e.value.map(
                                  initial: (i) => const Icon(Icons.image),
                                  downloadingMedia: (i) => const InfiniteLoader(),
                                  downloadedMedia: (d) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxHeight: 70,
                                          maxWidth: 50,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(12)),
                                          image: DecorationImage(
                                            image: FileImage(d.media.file),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  errorDownloadingMedia: (e) => IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.refresh,
                                    ),
                                  ),
                                ),
                              );
                            }).toList() ??
                            [],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
