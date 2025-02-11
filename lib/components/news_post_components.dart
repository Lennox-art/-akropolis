import 'package:akropolis/features/authentication/models/authentication_models.dart';
import 'package:akropolis/features/news_feed/models/models.dart';
import 'package:akropolis/features/on_boarding/view_model/user_cubit/user_cubit.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/theme/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostReactionWidget extends StatelessWidget {
  const PostReactionWidget({
    required this.newsPost,
    required this.postsCollectionRef,
    super.key,
  });

  final NewsPost newsPost;
  final DocumentReference postsCollectionRef;

  Future<void> setLogicReaction(AppUser user) async {
    log.info("User clicked logic reaction for post ${newsPost.id}");

    bool hasReacted = newsPost.reaction.log.contains(user.id);
    if (hasReacted) return;

    newsPost.reaction.log.add(user.id);

    await postsCollectionRef.update({
      'reaction.log': FieldValue.arrayUnion([user.id])
    });
    await postsCollectionRef.update({
      'reaction.emp': FieldValue.arrayRemove([user.id])
    });
  }

  Future<void> setEmpathyReaction(AppUser user) async {
    log.info("User clicked emp reaction for post ${newsPost.id}");
    
    bool hasReacted = newsPost.reaction.emp.contains(user.id);
    if (hasReacted) return;

    newsPost.reaction.emp.add(user.id);

    await postsCollectionRef.update({
      'reaction.log': FieldValue.arrayRemove([user.id])
    });

    await postsCollectionRef.update({
      'reaction.emp': FieldValue.arrayUnion([user.id])
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Card(
      child: Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  AppUser? currentUser = await BlocProvider.of<UserCubit>(context).getCurrentUser();
                  if (currentUser == null) return;
                  setLogicReaction(currentUser);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.arrow_upward),
                    Text(
                      "LOG",
                      style: theme.textTheme.labelSmall?.copyWith(color: Colors.orange),
                    ),
                    Text(
                      newsPost.reaction.log.length.toString(),
                      style: theme.textTheme.labelSmall,
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
                onTap: () async {
                  AppUser? currentUser = await BlocProvider.of<UserCubit>(context).getCurrentUser();
                  if (currentUser == null) return;
                  setEmpathyReaction(currentUser);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "EMP",
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      newsPost.reaction.emp.length.toString(),
                      style: theme.textTheme.labelSmall,
                    ),
                    const Icon(
                      Icons.arrow_upward,
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
