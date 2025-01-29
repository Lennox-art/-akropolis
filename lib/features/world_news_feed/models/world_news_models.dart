import 'package:akropolis/features/world_news_feed/models/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'world_news_models.g.dart';

@JsonSerializable()
class NewsApiResponse {
  final String status;
  final int totalResults;
  final List<WorldNewsModel> articles;

  NewsApiResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });


  factory NewsApiResponse.fromJson(Map<String, dynamic> json) => _$NewsApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NewsApiResponseToJson(this);
}

@JsonSerializable()
class WorldNewsModel {
  final NewsSource source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;

  WorldNewsModel({
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

  factory WorldNewsModel.fromJson(Map<String, dynamic> json) =>
      _$WorldNewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$WorldNewsModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is WorldNewsModel &&
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