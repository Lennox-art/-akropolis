// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      profilePicture: json['profilePicture'] as String?,
      bio: json['bio'] as String?,
      logicianCount: (json['logicianCount'] as num?)?.toInt(),
      empathCount: (json['empathCount'] as num?)?.toInt(),
      topics:
          (json['topics'] as List<dynamic>?)?.map((e) => e as String).toSet(),
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'username': instance.username,
      'email': instance.email,
      'bio': instance.bio,
      'profilePicture': instance.profilePicture,
      'topics': instance.topics?.toList(),
      'logicianCount': instance.logicianCount,
      'empathCount': instance.empathCount,
    };

ThreadRemote _$ThreadRemoteFromJson(Map<String, dynamic> json) => ThreadRemote(
      id: json['id'] as String,
      participant1: json['participant1'] as String,
      participant2: json['participant2'] as String,
      accepted: json['accepted'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: (json['updatedAt'] as Timestamp).toDate(),
    );

Map<String, dynamic> _$ThreadRemoteToJson(ThreadRemote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'participant1': instance.participant1,
      'participant2': instance.participant2,
      'accepted': instance.accepted,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

MessageRemote _$MessageRemoteFromJson(Map<String, dynamic> json) =>
    MessageRemote(
      id: json['id'] as String,
      sendByUserId: json['sendByUserId'] as String,
      sendToUserId: json['sendToUserId'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      videoUrl: json['videoUrl'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      mediaType: $enumDecode(_$MediaTypeEnumMap, json['mediaType']),
    );

Map<String, dynamic> _$MessageRemoteToJson(MessageRemote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sendByUserId': instance.sendByUserId,
      'sendToUserId': instance.sendToUserId,
      'thumbnailUrl': instance.thumbnailUrl,
      'videoUrl': instance.videoUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'mediaType': _$MediaTypeEnumMap[instance.mediaType]!,
    };

const _$MediaTypeEnumMap = {
  MediaType.image: 'image',
  MediaType.video: 'video',
};
