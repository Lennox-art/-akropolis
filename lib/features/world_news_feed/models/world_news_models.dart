import 'package:akropolis/features/create_post/models/models.dart';
import 'package:akropolis/features/world_news_feed/models/enums.dart';
import 'package:common_fn/common_fn.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'world_news_models.g.dart';

@JsonSerializable()
class NewsApiResponse {
  final String status;
  final int totalResults;
  final List<NewsApiArticleModel> articles;

  NewsApiResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });


  factory NewsApiResponse.fromJson(Map<String, dynamic> json) => _$NewsApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NewsApiResponseToJson(this);
}

@JsonSerializable()
class NewsApiArticleModel {
  final NewsSource source;
  final String? author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;

  NewsApiArticleModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });


  NewsSourceEnum? get sourceEnum => NewsSourceEnum.sourceMap[source.id];

  factory NewsApiArticleModel.fromJson(Map<String, dynamic> json) =>
      _$NewsApiArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsApiArticleModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NewsApiArticleModel &&
              runtimeType == other.runtimeType &&
              source == other.source &&
              author == other.author &&
              title == other.title &&
              description == other.description &&
              url == other.url &&
              urlToImage == other.urlToImage &&
              publishedAt == other.publishedAt &&
              content == other.content;

  @override
  int get hashCode =>
      source.hashCode ^
      author.hashCode ^
      title.hashCode ^
      publishedAt.hashCode;

  @override
  String toString() => """
  
  source => $source,
  sourceEnum => $sourceEnum
  author => $author,
  title => $title,
  description => $description,
  url => $url,
  urlToImage => $urlToImage,
  publishedAt => $publishedAt
  """;
}

@JsonSerializable()
class NewsSource {
  final String id;
  final String name;

  NewsSource({required this.id, required this.name});

  factory NewsSource.fromJson(Map<String, dynamic> json) => _$NewsSourceFromJson(json);

  Map<String, dynamic> toJson() => _$NewsSourceToJson(this);

  @override
  String toString() => "id : $id, name : $name";
}

