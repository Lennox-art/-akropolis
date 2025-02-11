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
  final List<PostComment> comments;
  final PostReaction reaction;
  final NewsChannel channel;

  NewsPost({
    required this.id,
    required this.thumbnailUrl,
    required this.postUrl,
    required this.title,
    required this.description,
    required this.author,
    required this.comments,
    required this.viewers,
    required this.publishedAt,
    required this.reaction,
    required this.channel,
  });

  factory NewsPost.fromJson(Map<String, dynamic> json) => NewsPost(
        id: json['id'] as String,
        thumbnailUrl: json['thumbnailUrl'] as String,
        postUrl: json['postUrl'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        author: Author.fromJson(json['author'] as Map<String, dynamic>),
        comments: (json['comments'] as List<dynamic>)
            .map((e) => PostComment.fromJson(e as Map<String, dynamic>))
            .toList(),
        viewers:
            (json['viewers'] as List<dynamic>).map((e) => e as String).toSet(),
        publishedAt: DateTime.parse(json['publishedAt'] as String),
        reaction:
            PostReaction.fromJson(json['reaction'] as Map<String, dynamic>),
        channel: NewsChannel.newsChannelEnumMap[json['channel']]!,
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
        'comments': comments.map((c) => c.toJson()).toList(),
        'reaction': reaction.toJson(),
        'channel': channel.collection,
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
  final String thumbnailUrl;
  final String postUrl;
  final Author author;
  final List<PostComment> replies;
  final DateTime commentedAt;
  PostReaction? reaction;

  PostComment({
    required this.id,
    required this.thumbnailUrl,
    required this.postUrl,
    required this.author,
    required this.replies,
    required this.commentedAt,
    required this.reaction,
  });

  factory PostComment.fromJson(Map<String, dynamic> json) => PostComment(
        id: json['id'] as String,
        thumbnailUrl: json['thumbnailUrl'] as String,
        postUrl: json['postUrl'] as String,
        author: Author.fromJson(json['author'] as Map<String, dynamic>),
        replies: (json['replies'] as List<dynamic>)
            .map((e) => PostComment.fromJson(e as Map<String, dynamic>))
            .toList(),
        commentedAt: DateTime.parse(json['commentedAt'] as String),
        reaction: json['reaction'] == null
            ? null
            : PostReaction.fromJson(json['reaction'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'thumbnailUrl': thumbnailUrl,
        'postUrl': postUrl,
        'author': author.toJson(),
        'replies': replies.map((r) => r.toJson()).toList(),
        'commentedAt': commentedAt.toIso8601String(),
        'reaction': reaction,
      };
}
