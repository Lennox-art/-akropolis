// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'for_you_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaStackResponse _$MediaStackResponseFromJson(Map<String, dynamic> json) =>
    MediaStackResponse(
      pagination:
          Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>)
          .map(
              (e) => MediaStackArticleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MediaStackResponseToJson(MediaStackResponse instance) =>
    <String, dynamic>{
      'pagination': instance.pagination,
      'data': instance.data,
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      limit: (json['limit'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
      count: (json['count'] as num).toInt(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'offset': instance.offset,
      'count': instance.count,
      'total': instance.total,
    };

MediaStackArticleModel _$MediaStackArticleModelFromJson(
        Map<String, dynamic> json) =>
    MediaStackArticleModel(
      json['author'] as String?,
      json['title'] as String,
      json['description'] as String,
      json['url'] as String,
      json['source'] as String,
      json['image'] as String?,
      json['category'] as String,
      json['language'] as String,
      json['country'] as String,
      DateTime.parse(json['published_at'] as String),
    );

Map<String, dynamic> _$MediaStackArticleModelToJson(
        MediaStackArticleModel instance) =>
    <String, dynamic>{
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'source': instance.source,
      'image': instance.image,
      'category': instance.category,
      'language': instance.language,
      'country': instance.country,
      'published_at': instance.publishedAt.toIso8601String(),
    };
