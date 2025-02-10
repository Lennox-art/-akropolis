import 'dart:io';
import 'dart:typed_data';
import 'package:akropolis/features/authentication/models/authentication_models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter/material.dart';

part 'models.freezed.dart';
part 'models.g.dart';

enum VideoEditingTools {
  trimVideo(
    "Trim",
    Icons.cut_outlined,
  ),
  thumbnailPicker(
    "Thumbnail",
    Icons.pages_outlined,
  );

  const VideoEditingTools(this.title, this.iconData);

  final String title;
  final IconData iconData;
}

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
  Set<String>? viewers;
  List<PostComment>? comments;
  PostReaction? reaction;

  NewsPost({
    required this.id,
    required this.thumbnailUrl,
    required this.postUrl,
    required this.title,
    required this.description,
    required this.author,
    this.comments,
    this.viewers,
    required this.publishedAt,
    this.reaction,
  });

  static const String collection = 'news_posts';

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

@freezed
class CreatePostForm with _$CreatePostForm {
  const factory CreatePostForm.create({
    required String postId,
    required AppUser appUser,
    File? videoData,
    @Default(false) bool videoDataUploaded,

    Duration? videoDuration,
    Uint8List? thumbnailData,
    @Default(false) bool thumbnailUploaded,
  }) = _CreatePostForm;
}

@freezed
class DurationTrim with _$DurationTrim {
  const factory DurationTrim.create({
    required Duration duration,
    @Default(0.0) double start,
    @Default(1.0) double end,
  }) = _DurationTrim;
}

extension TrimFunctionsX on DurationTrim {
  double getDurationRange(Duration d) => (d.inMilliseconds * 100) / duration.inMilliseconds;
}