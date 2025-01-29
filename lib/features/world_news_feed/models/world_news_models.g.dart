// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world_news_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsApiResponse _$NewsApiResponseFromJson(Map<String, dynamic> json) =>
    NewsApiResponse(
      status: json['status'] as String,
      totalResults: (json['totalResults'] as num).toInt(),
      articles: (json['articles'] as List<dynamic>)
          .map((e) => WorldNewsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NewsApiResponseToJson(NewsApiResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'articles': instance.articles,
    };

WorldNewsModel _$WorldNewsModelFromJson(Map<String, dynamic> json) =>
    WorldNewsModel(
      source: NewsSource.fromJson(json['source'] as Map<String, dynamic>),
      author: json['author'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      urlToImage: json['urlToImage'] as String,
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      content: json['content'] as String,
    );

Map<String, dynamic> _$WorldNewsModelToJson(WorldNewsModel instance) =>
    <String, dynamic>{
      'source': instance.source,
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt.toIso8601String(),
      'content': instance.content,
    };

NewsSource _$NewsSourceFromJson(Map<String, dynamic> json) => NewsSource(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$NewsSourceToJson(NewsSource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
