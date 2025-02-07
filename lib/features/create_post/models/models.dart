import 'dart:io';
import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter/material.dart';

part 'models.freezed.dart';

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
}

class NewsPost {
  final String thumbnailUrl;
  final String postUrl;
  final String title;
  final String description;
  final Author author;
  final DateTime publishedAt;

  NewsPost({
    required this.thumbnailUrl,
    required this.postUrl,
    required this.title,
    required this.description,
    required this.author,
    required this.publishedAt,
  });
}

@freezed
class CreatePostForm with _$CreatePostForm {
  const factory CreatePostForm.create({
    required String userId,
    File? videoData,
    Uint8List? thumbnailData,
    String? title,
    String? description,
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