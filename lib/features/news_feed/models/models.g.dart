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
      comments: (json['comments'] as List<dynamic>)
          .map((e) => PostComment.fromJson(e as Map<String, dynamic>))
          .toList(),
      viewers:
          (json['viewers'] as List<dynamic>).map((e) => e as String).toSet(),
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      reaction: PostReaction.fromJson(json['reaction'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NewsPostToJson(NewsPost instance) => <String, dynamic>{
      'id': instance.id,
      'thumbnailUrl': instance.thumbnailUrl,
      'postUrl': instance.postUrl,
      'title': instance.title,
      'description': instance.description,
      'author': instance.author,
      'publishedAt': instance.publishedAt.toIso8601String(),
      'viewers': instance.viewers.toList(),
      'comments': instance.comments,
      'reaction': instance.reaction,
    };

PostReaction _$PostReactionFromJson(Map<String, dynamic> json) => PostReaction(
      log: (json['log'] as List<dynamic>).map((e) => e as String).toSet(),
      emp: (json['emp'] as List<dynamic>).map((e) => e as String).toSet(),
    );

Map<String, dynamic> _$PostReactionToJson(PostReaction instance) =>
    <String, dynamic>{
      'log': instance.log.toList(),
      'emp': instance.emp.toList(),
    };

PostComment _$PostCommentFromJson(Map<String, dynamic> json) => PostComment(
      id: json['id'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      postUrl: json['postUrl'] as String,
      userId: json['userId'] as String,
      replies: (json['replies'] as List<dynamic>)
          .map((e) => PostComment.fromJson(e as Map<String, dynamic>))
          .toList(),
      commentedAt: DateTime.parse(json['commentedAt'] as String),
      reaction: json['reaction'] == null
          ? null
          : PostReaction.fromJson(json['reaction'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostCommentToJson(PostComment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'thumbnailUrl': instance.thumbnailUrl,
      'postUrl': instance.postUrl,
      'userId': instance.userId,
      'replies': instance.replies,
      'commentedAt': instance.commentedAt.toIso8601String(),
      'reaction': instance.reaction,
    };
