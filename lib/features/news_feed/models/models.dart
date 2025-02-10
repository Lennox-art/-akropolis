
import 'package:freezed_annotation/freezed_annotation.dart';
part 'models.g.dart';

enum AuthorType { user, publisher }

@JsonSerializable()
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

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}

@JsonSerializable()
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
  });


  factory NewsPost.fromJson(Map<String, dynamic> json) => _$NewsPostFromJson(json);

  Map<String, dynamic> toJson() => _$NewsPostToJson(this);
}

@JsonSerializable()
class PostReaction {
  final Set<String> log;
  final Set<String> emp;

  PostReaction({
    required this.log,
    required this.emp,
  });

  factory PostReaction.fromJson(Map<String, dynamic> json) => _$PostReactionFromJson(json);

  Map<String, dynamic> toJson() => _$PostReactionToJson(this);
}

@JsonSerializable()
class PostComment {
  final String id;
  final String thumbnailUrl;
  final String postUrl;
  final String userId;
  final List<PostComment> replies;
  final DateTime commentedAt;
  PostReaction? reaction;

  PostComment({
    required this.id,
    required this.thumbnailUrl,
    required this.postUrl,
    required this.userId,
    required this.replies,
    required this.commentedAt,
    required this.reaction,
  });

  factory PostComment.fromJson(Map<String, dynamic> json) => _$PostCommentFromJson(json);

  Map<String, dynamic> toJson() => _$PostCommentToJson(this);
}