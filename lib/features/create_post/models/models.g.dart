// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
      type: $enumDecode(_$AuthorTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'type': _$AuthorTypeEnumMap[instance.type]!,
    };

const _$AuthorTypeEnumMap = {
  AuthorType.user: 'user',
  AuthorType.publisher: 'publisher',
};

NewsPost _$NewsPostFromJson(Map<String, dynamic> json) => NewsPost(
      id: json['id'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      postUrl: json['postUrl'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      author: Author.fromJson(json['author'] as Map<String, dynamic>),
      publishedAt: DateTime.parse(json['publishedAt'] as String),
    );

Map<String, dynamic> _$NewsPostToJson(NewsPost instance) => <String, dynamic>{
      'id': instance.id,
      'thumbnailUrl': instance.thumbnailUrl,
      'postUrl': instance.postUrl,
      'title': instance.title,
      'description': instance.description,
      'author': instance.author.toJson(),
      'publishedAt': instance.publishedAt.toIso8601String(),
    };
