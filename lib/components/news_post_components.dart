import 'package:akropolis/features/authentication/models/authentication_models.dart';
import 'package:akropolis/features/news_feed/models/models.dart';
import 'package:akropolis/features/on_boarding/view_model/user_cubit/user_cubit.dart';
import 'package:akropolis/gen/assets.gen.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/theme/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsPostReactionWidget extends StatelessWidget {
  const NewsPostReactionWidget({
    required this.newsPost,
    required this.postsCollectionRef,
    super.key,
  });

  final NewsPost newsPost;
  final DocumentReference postsCollectionRef;

  Future<void> setLogicReaction(AppUser user) async {
    log.info("User clicked logic reaction for post ${newsPost.id}");


    newsPost.reaction.log.add(user.id);

    await postsCollectionRef.update({
      'reaction.log': FieldValue.arrayUnion([user.id])
    });
    /*   await postsCollectionRef.update({
      'reaction.emp': FieldValue.arrayRemove([user.id])
    });*/
  }

  Future<void> setEmpathyReaction(AppUser user) async {
    log.info("User clicked emp reaction for post ${newsPost.id}");

    newsPost.reaction.emp.add(user.id);

    await postsCollectionRef.update({
      'reaction.emp': FieldValue.arrayUnion([user.id])
    });

    /*await postsCollectionRef.update({
      'reaction.log': FieldValue.arrayRemove([user.id])
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: BlocProvider.of<UserCubit>(context).getCurrentUser(),
        builder: (_, snap) {

          if (!snap.hasData) return const SizedBox.shrink();

          AppUser currentUser = snap.data!;

          bool alreadyVoted = newsPost.reaction.log.contains(currentUser.id) || newsPost.reaction.emp.contains(currentUser.id);

          return PostReactionWidget(
          alreadyVoted: alreadyVoted,
          empathyCount: newsPost.reaction.emp.length,
          onEmpathy: () => setEmpathyReaction(currentUser),
          logicCount: newsPost.reaction.log.length,
          onLogic: () => setLogicReaction(currentUser),
        );
      }
    );
  }
}

class CommentReactionWidget extends StatelessWidget {
  const CommentReactionWidget({
    required this.newsPost,
    required this.postComment,
    required this.postsCollectionRef,
    super.key,
  });

  final NewsPost newsPost;
  final PostComment postComment;
  final DocumentReference postsCollectionRef;

  Future<void> setLogicReaction(AppUser user) async {
    log.info("User clicked logic reaction for comment ${postComment.id}");

    bool hasReacted = postComment.reaction.log.contains(user.id) || postComment.reaction.emp.contains(user.id);
    if (hasReacted) return;

    postComment.reaction.log.add(user.id);

    await postsCollectionRef.collection(PostComment.collection).doc(postComment.id).update({
      'reaction.log': FieldValue.arrayUnion([user.id])
    });

  }

  Future<void> setEmpathyReaction(AppUser user) async {
    log.info("User clicked emp reaction for comment ${postComment.id}");

    bool hasReacted = postComment.reaction.emp.contains(user.id) || postComment.reaction.log.contains(user.id);
    if (hasReacted) return;

    postComment.reaction.emp.add(user.id);


    await postsCollectionRef.collection(PostComment.collection).doc(postComment.id).update({
      'reaction.emp': FieldValue.arrayUnion([user.id])
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BlocProvider.of<UserCubit>(context).getCurrentUser(),
      builder: (_, snap) {

        if (!snap.hasData) return const SizedBox.shrink();

        AppUser currentUser = snap.data!;

        bool alreadyVoted = postComment.reaction.log.contains(currentUser.id) || postComment.reaction.emp.contains(currentUser.id);

        return PostReactionWidget(
          alreadyVoted: alreadyVoted,
          empathyCount: postComment.reaction.emp.length,
          onEmpathy: () => setEmpathyReaction(currentUser),
          logicCount: postComment.reaction.log.length,
          onLogic: () => setLogicReaction(currentUser),
        );
      }
    );
  }
}

class PostReactionWidget extends StatelessWidget {
  const PostReactionWidget({
    required this.alreadyVoted,
    required this.empathyCount,
    required this.logicCount,
    required this.onEmpathy,
    required this.onLogic,
    super.key,
  });

  final bool alreadyVoted;
  final Function() onEmpathy;
  final int empathyCount;

  final Function() onLogic;
  final int logicCount;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: alreadyVoted ? null : onLogic,
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Assets.fatArrowUp.svg(),
                    ),
                    Text(
                      "LOG",
                      style: theme.textTheme.labelSmall?.copyWith(color: Colors.orange),
                    ),
                    Flexible(
                      child: Text(
                        logicCount.toString(),
                        style: theme.textTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: alreadyVoted ? null : onEmpathy,
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "EMP",
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: primaryColor,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        empathyCount.toString(),
                        style: theme.textTheme.labelSmall,
                      ),
                    ),
                    Flexible(
                      child: Assets.fatArrowUp.svg(),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
