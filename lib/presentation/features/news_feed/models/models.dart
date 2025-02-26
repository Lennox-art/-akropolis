import 'dart:io';



enum NewsChannel {
  worldNews("world_news"),
  userPosts("news_posts"),
  newsHeadlines("news_headlines");

  const NewsChannel(this.collection);

  final String collection;

  static Map<String, NewsChannel> newsChannelEnumMap = {
    for (var e in values) e.collection: e
  };
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

  NewsPostDto(this.newsPost, this.channel);
}

class CommentReplyDto {
  final NewsPost newsPost;
  final File commentVideo;

  CommentReplyDto(this.newsPost, this.commentVideo);
}