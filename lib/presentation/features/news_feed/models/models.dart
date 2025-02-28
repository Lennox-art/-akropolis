import 'dart:io';

import 'package:akropolis/data/models/remote_models/remote_models.dart';

enum NewsChannel {
  worldNews("world_news"),
  userPosts("news_posts"),
  newsHeadlines("news_headlines");

  const NewsChannel(this.collection);

  final String collection;

  static Map<String, NewsChannel> newsChannelEnumMap = {for (var e in values) e.collection: e};
}

/*
  TODO nested replies
class PostReply {
  final String id;
  final String commentId; // ID of the parent comment
  final String text;
  final Author author;
  final DateTime repliedAt;
  final PostReaction reaction;

  PostReply({
    required this.id,
    required this.commentId,
    required this.text,
    required this.author,
    required this.repliedAt,
    required this.reaction,
  });

  factory PostReply.fromJson(Map<String, dynamic> json) => PostReply(
    id: json['id'] as String,
    commentId: json['commentId'] as String,
    text: json['text'] as String,
    author: Author.fromJson(json['author'] as Map<String, dynamic>),
    repliedAt: DateTime.parse(json['repliedAt'] as String),
    reaction: PostReaction.fromJson(json['reaction'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'commentId': commentId,
    'text': text,
    'author': author.toJson(),
    'repliedAt': repliedAt.toIso8601String(),
    'reaction': reaction.toJson(),
  };
}*/

class NewsPostDto {
  final NewsPost newsPost;
  final NewsChannel channel;
  final AppUser currentUser;

  NewsPostDto(this.newsPost, this.channel, this.currentUser);
}

class NewsPostCommentDto {
  final NewsPost newsPost;
  final NewsChannel channel;
  final AppUser currentUser;
  final PostComment comment;

  NewsPostCommentDto(this.newsPost, this.channel, this.currentUser, this.comment);
}


class CommentReplyDto {
  final NewsPost newsPost;
  final File commentVideo;

  CommentReplyDto(this.newsPost, this.commentVideo);
}


class ReactionDistribution {
  final PostReaction postReaction;

  ReactionDistribution(this.postReaction);

  int get _total => postReaction.log.length + postReaction.emp.length;

  int get logCount => postReaction.log.length;

  int get empCount => postReaction.emp.length;

  int get logFlex => _total == 0 ? 1 : (postReaction.log.length / _total).toInt();

  int get empFlex => _total == 0 ? 1: (postReaction.emp.length / _total).toInt();

  double get logPercent => _total == 0 ? 0 : (postReaction.log.length / _total) * 100;

  double get empPercent => _total == 0 ? 0 : (postReaction.emp.length / _total) * 100;


}