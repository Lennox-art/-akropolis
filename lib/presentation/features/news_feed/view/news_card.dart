import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/gen/assets.gen.dart';
import 'package:akropolis/domain/models/news_card_model.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/domain/utils/functions.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/news_card_view_model.dart';
import 'package:akropolis/presentation/features/news_feed/view_models/post_comment_card_view_model.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/themes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final NewsCardPostModel post;
  final AppUser user;
  final NewsCardViewModel newsCardViewModel;

  const NewsCard({
    super.key,
    required this.post,
    required this.user,
    required this.newsCardViewModel,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.newsDetailsPage.path,
          arguments: NewsPostDto(post, user),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16.0),
              ),
              child: post.thumbnail.map(
                success: (s) {
                  return Image.file(
                    s.data.value.file,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
                error: (e) {
                  return const Icon(
                    Icons.broken_image,
                    size: 180,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.newsPost.title,
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
                        visible: post.newsPost.author.imageUrl != null,
                        replacement: const CircleAvatar(
                          radius: 12,
                          child: Icon(Icons.person),
                        ),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundImage: CachedNetworkImageProvider(
                            post.newsPost.author.imageUrl ?? '',
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          post.newsPost.author.name,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        timeAgo(post.newsPost.publishedAt),
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    post.newsPost.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Visibility(
                        visible: post.newsPost.author.imageUrl != null,
                        replacement: const CircleAvatar(
                          radius: 12,
                          child: Icon(Icons.person),
                        ),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundImage: CachedNetworkImageProvider(
                            post.newsPost.author.imageUrl ?? '',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      post.comments.map(
                        success: (s) {
                          return Visibility(
                            visible: s.data.isNotEmpty,
                            replacement: const Text(
                              "Be the first to reply",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            child: Text(
                              "+${s.data.length} Replies",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                        error: (e) {
                          return Text(e.failure.message);
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
    required this.postCommentCardViewModel,
    super.key,
  });

  AppUser get currentUser => postCommentCardViewModel.currentUser;
  NewsPost get post => postCommentCardViewModel.post;
  PostComment get comment => postCommentCardViewModel.comment;
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

///ForYouHighlightCard
class ForYouHighlightCard extends StatefulWidget {
  final NewsCardViewModel newsCardViewModel;
  final NewsCardPostModel post;
  final AppUser user;

  const ForYouHighlightCard({
    super.key,
    required this.post,
    required this.user,
    required this.newsCardViewModel,
  });

  @override
  State<ForYouHighlightCard> createState() => _ForYouHighlightCardState();
}

class _ForYouHighlightCardState extends State<ForYouHighlightCard> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.newsCardViewModel.addNewsPost(
        newsPost: widget.post,
        appUser: widget.user,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.newsDetailsPage.path,
          arguments: NewsPostDto(
            widget.post,
            widget.user,
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
            widget.post.thumbnail.map(
              success: (s) {
                return Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16.0),
                    ),
                    child: Image.file(
                      s.data.value.file,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              error: (e) => Text(e.failure.message),
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
                          widget.post.newsPost.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        timeAgo(widget.post.newsPost.publishedAt),
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
                              visible: widget.post.newsPost.author.imageUrl != null,
                              replacement: const CircleAvatar(
                                radius: 12,
                                child: Icon(
                                  Icons.person,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 12,
                                backgroundImage: CachedNetworkImageProvider(
                                  widget.post.newsPost.author.imageUrl ?? '',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                widget.post.newsPost.author.name,
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
                              visible: widget.post.newsPost.author.imageUrl != null,
                              replacement: const CircleAvatar(
                                radius: 12,
                                child: Icon(
                                  Icons.person,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 12,
                                backgroundImage: CachedNetworkImageProvider(
                                  widget.post.newsPost.author.imageUrl ?? '',
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: widget.post.comments.map(
                                  success: (s) {
                                    return Visibility(
                                      visible: s.data.isNotEmpty,
                                      replacement: const Text(
                                        "Be the first to reply",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      child: Text(
                                        "+${s.data.length} Replies",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                  error: (e) => Text(
                                    e.failure.message,
                                  ),
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

///ForYouCard
class ForYouCard extends StatefulWidget {
  final AppUser currentUser;
  final NewsCardPostModel post;
  final NewsCardViewModel newsCardViewModel;

  const ForYouCard({
    super.key,
    required this.currentUser,
    required this.post,
    required this.newsCardViewModel,
  });

  @override
  State<ForYouCard> createState() => _ForYouCardState();
}

class _ForYouCardState extends State<ForYouCard> {
  bool get alreadyVoted => widget.newsCardViewModel.getAlreadyReacted(widget.post.newsPost, widget.currentUser);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.newsCardViewModel.addNewsPost(
        newsPost: widget.post,
        appUser: widget.currentUser,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.newsDetailsPage.path,
          arguments: NewsPostDto(widget.post, widget.currentUser),
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Visibility(
                    visible: widget.post.newsPost.author.imageUrl != null,
                    replacement: const CircleAvatar(
                      radius: 12,
                      child: Icon(
                        Icons.person,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 12,
                      backgroundImage: CachedNetworkImageProvider(
                        widget.post.newsPost.author.imageUrl ?? '',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      widget.post.newsPost.author.name,
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
                visible: widget.post.newsPost.thumbnailUrl.isNotEmpty,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.post.newsPost.thumbnailUrl,
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
                widget.post.newsPost.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: 12,
                  color: Colors.white,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            ListenableBuilder(
              listenable: widget.newsCardViewModel,
              builder: (_, child) => Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: widget.newsCardViewModel.getDistribution(widget.post.newsPost).logFlex,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                      decoration: const BoxDecoration(
                        color: logicianColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        "${widget.newsCardViewModel.getDistribution(widget.post.newsPost).logPercent.toStringAsFixed(0)} % (${widget.newsCardViewModel.getDistribution(widget.post.newsPost).logCount})",
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: widget.newsCardViewModel.getDistribution(widget.post.newsPost).empFlex,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                      decoration: const BoxDecoration(
                        color: empathyColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        "${widget.newsCardViewModel.getDistribution(widget.post.newsPost).empPercent.toStringAsFixed(0)} % (${widget.newsCardViewModel.getDistribution(widget.post.newsPost).empCount})",
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListenableBuilder(
              listenable: widget.newsCardViewModel,
              builder: (_, __) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        decoration: BoxDecoration(
                          color: widget.newsCardViewModel.getIsLogReaction(widget.post.newsPost, widget.currentUser)
                              ? logicianColor
                              : Colors.transparent,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(
                            color: logicianColor,
                            width: 1.0,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: widget.newsCardViewModel.getAlreadyReacted(widget.post.newsPost, widget.currentUser)
                              ? null
                              : () => widget.newsCardViewModel.log(widget.post, widget.currentUser),
                          child: Flex(
                            direction: Axis.horizontal,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Assets.fatArrowUp.svg(
                                  color: widget.newsCardViewModel.getIsLogReaction(widget.post.newsPost, widget.currentUser)
                                      ? secondaryColor
                                      : logicianColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(
                                  "LGN",
                                  style: theme.textTheme.labelSmall?.copyWith(
                                      color: widget.newsCardViewModel.getIsLogReaction(widget.post.newsPost, widget.currentUser)
                                          ? secondaryColor
                                          : logicianColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        decoration: BoxDecoration(
                          color:
                              widget.newsCardViewModel.getIsEmpReaction(widget.post.newsPost, widget.currentUser) ? empathyColor : Colors.transparent,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(
                            color: empathyColor,
                            width: 1.0,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: widget.newsCardViewModel.getAlreadyReacted(widget.post.newsPost, widget.currentUser)
                              ? null
                              : () => widget.newsCardViewModel.emp(widget.post, widget.currentUser),
                          child: Flex(
                            direction: Axis.horizontal,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Assets.fatArrowUp.svg(
                                  color: widget.newsCardViewModel.getIsEmpReaction(widget.post.newsPost, widget.currentUser)
                                      ? secondaryColor
                                      : empathyColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(
                                  "Emp",
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: widget.newsCardViewModel.getIsEmpReaction(widget.post.newsPost, widget.currentUser)
                                        ? secondaryColor
                                        : empathyColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: widget.post.comments.map(
                success: (s) {
                  return Text(
                    "Replies (${s.data.length})",
                    textAlign: TextAlign.start,
                  );
                },
                error: (e) {
                  return Text(e.failure.message);
                },
              ),
            ),
            widget.post.comments.map(
              success: (s) {
                if (s.data.isEmpty) return const SizedBox.shrink();
                return SizedBox(
                  height: 70,
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: s.data.entries.map((e) {
                      return e.value.thumbnail.map(
                        success: (s) {
                          return Flexible(
                            fit: FlexFit.loose,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                constraints: const BoxConstraints(
                                  maxHeight: 70,
                                  maxWidth: 50,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                  image: DecorationImage(
                                    image: FileImage(s.data.value.file),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        error: (e) => SizedBox.shrink(),
                      );
                    }).toList(),
                  ),
                );
              },
              error: (e) => const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
