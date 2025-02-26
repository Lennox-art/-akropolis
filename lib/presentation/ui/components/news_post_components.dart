
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/domain/gen/assets.gen.dart';
import 'package:akropolis/presentation/ui/themes.dart';
import 'package:flutter/material.dart';

class NewsPostReactionWidget extends StatelessWidget {
  const NewsPostReactionWidget({
    required this.newsPost,
    required this.currentUser,
    required this.onEmpathy,
    required this.onLogician,
    super.key,
  });

  final NewsPost newsPost;
  final AppUser currentUser;
  final Function() onEmpathy;
  final Function() onLogician;



  @override
  Widget build(BuildContext context) {
    bool alreadyVoted = newsPost.reaction.log.contains(currentUser.id) || newsPost.reaction.emp.contains(currentUser.id);
    return PostReactionWidget(
      alreadyVoted: alreadyVoted,
      empathyCount: newsPost.reaction.emp.length,
      onEmpathy: onEmpathy,
      logicCount: newsPost.reaction.log.length,
      onLogic: onLogician,
    );
  }
}

class CommentReactionWidget extends StatelessWidget {
  const CommentReactionWidget({
    required this.newsPost,
    required this.postComment,
    required this.currentUser,
    required this.onEmpathy,
    required this.onLogician,
    super.key,
  });

  final NewsPost newsPost;
  final AppUser currentUser;
  final PostComment postComment;
  final Function() onEmpathy;
  final Function() onLogician;


  @override
  Widget build(BuildContext context) {
    bool alreadyVoted = postComment.reaction.log.contains(currentUser.id) || postComment.reaction.emp.contains(currentUser.id);

    return PostReactionWidget(
      alreadyVoted: alreadyVoted,
      empathyCount: postComment.reaction.emp.length,
      onEmpathy: onEmpathy,
      logicCount: postComment.reaction.log.length,
      onLogic: onLogician,
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
