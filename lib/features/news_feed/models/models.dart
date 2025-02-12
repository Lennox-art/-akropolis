import 'dart:io';

enum AuthorType {
  user,
  publisher;

  static Map<String, AuthorType> authorTypeEnumMap = {
    for (var e in values) e.name: e
  };
}

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

class Author {
  final String id;
  final String name;
  final String? imageUrl;
  final AuthorType type;

  Author({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.type,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json['id'] as String,
        name: json['name'] as String,
        imageUrl: json['imageUrl'] as String?,
        type: AuthorType.authorTypeEnumMap[json['type']]!,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'imageUrl': imageUrl,
        'type': type.name,
      };
}

class NewsPost {
  final String id;
  final String thumbnailUrl;
  final String postUrl;
  final String title;
  final String description;
  final Author author;
  final DateTime publishedAt;
  final Set<String> viewers;
  final PostReaction reaction;

  NewsPost({
    required this.id,
    required this.thumbnailUrl,
    required this.postUrl,
    required this.title,
    required this.description,
    required this.author,
    required this.viewers,
    required this.publishedAt,
    required this.reaction,
  });

  factory NewsPost.fromJson(Map<String, dynamic> json) => NewsPost(
        id: json['id'] as String,
        thumbnailUrl: json['thumbnailUrl'] as String,
        postUrl: json['postUrl'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        author: Author.fromJson(json['author'] as Map<String, dynamic>),
        viewers:
            (json['viewers'] as List<dynamic>).map((e) => e as String).toSet(),
        publishedAt: DateTime.parse(json['publishedAt'] as String),
        reaction:
            PostReaction.fromJson(json['reaction'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'thumbnailUrl': thumbnailUrl,
        'postUrl': postUrl,
        'title': title,
        'description': description,
        'author': author.toJson(),
        'publishedAt': publishedAt.toIso8601String(),
        'viewers': viewers.toList(),
        'reaction': reaction.toJson(),
      };
}

class PostReaction {
  final Set<String> log;
  final Set<String> emp;

  PostReaction({
    required this.log,
    required this.emp,
  });

  factory PostReaction.fromJson(Map<String, dynamic> json) => PostReaction(
        log: (json['log'] as List<dynamic>).map((e) => e as String).toSet(),
        emp: (json['emp'] as List<dynamic>).map((e) => e as String).toSet(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'log': log.toList(),
        'emp': emp.toList(),
      };
}

class PostComment {
  final String id;
  final String postId;
  final String thumbnailUrl;
  final String postUrl;
  final Author author;
  final DateTime commentedAt;
  final PostReaction reaction;

  PostComment({
    required this.id,
    required this.postId,
    required this.thumbnailUrl,
    required this.postUrl,
    required this.author,
    required this.commentedAt,
    required this.reaction,
  });

  static const collection = 'comments';

  factory PostComment.fromJson(Map<String, dynamic> json) => PostComment(
        id: json['id'] as String,
        postId: json['postId'] as String,
        thumbnailUrl: json['thumbnailUrl'] as String,
        postUrl: json['postUrl'] as String,
        author: Author.fromJson(json['author'] as Map<String, dynamic>),
        commentedAt: DateTime.parse(json['commentedAt'] as String),
        reaction: PostReaction.fromJson(json['reaction'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'postId': postId,
        'thumbnailUrl': thumbnailUrl,
        'postUrl': postUrl,
        'author': author.toJson(),
        'commentedAt': commentedAt.toIso8601String(),
        'reaction': reaction.toJson(),
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