import 'package:akropolis/features/create_post/models/models.dart';
import 'package:common_fn/common_fn.dart';
import 'package:json_annotation/json_annotation.dart';

part 'for_you_models.g.dart';

@JsonSerializable()
class MediaStackResponse {
  final Pagination pagination;
  final List<MediaStackArticleModel> data;

  const MediaStackResponse({
    required this.pagination,
    required this.data,
  });

  factory MediaStackResponse.fromJson(Map<String, dynamic> json) =>
      _$MediaStackResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MediaStackResponseToJson(this);
}

@JsonSerializable()
class Pagination {
  final int limit;
  final int offset;
  final int count;
  final int total;

  Pagination({
    required this.limit,
    required this.offset,
    required this.count,
    required this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

@JsonSerializable()
class MediaStackArticleModel {
  final String? author;
  final String title;
  final String description;
  final String url;
  final String source;
  final String? image;
  final String category;
  final String language;
  final String country;
  @JsonKey(name: 'published_at')
  final DateTime publishedAt;

  MediaStackArticleModel(
    this.author,
    this.title,
    this.description,
    this.url,
    this.source,
    this.image,
    this.category,
    this.language,
    this.country,
    this.publishedAt,
  );

  factory MediaStackArticleModel.fromJson(Map<String, dynamic> json) =>
      _$MediaStackArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$MediaStackArticleModelToJson(this);

  @override
  String toString() => """
  
  author => $author,
  title => $title,
  description => $description,
  url => $url,
  source => $source,
  image => $image,
  category => $category,
  language => $language,
  country => $country,
  publishedAt => $publishedAt,
  """;
}

