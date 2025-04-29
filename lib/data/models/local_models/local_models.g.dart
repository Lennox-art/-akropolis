// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalFileCacheAdapter extends TypeAdapter<LocalFileCache> {
  @override
  final int typeId = 3;

  @override
  LocalFileCache read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalFileCache(
      sha1: fields[0] as String,
      url: fields[1] as String,
      mediaType: fields[2] as MediaType,
    );
  }

  @override
  void write(BinaryWriter writer, LocalFileCache obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.sha1)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.mediaType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalFileCacheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LocalNotificationAdapter extends TypeAdapter<LocalNotification> {
  @override
  final int typeId = 29;

  @override
  LocalNotification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalNotification(
      id: fields[0] as int,
      title: fields[1] as String,
      subTitle: fields[2] as String,
      body: fields[3] as String,
      payload: fields[4] as String?,
      groupKey: fields[5] as String,
      channel: fields[6] as NotificationChannel,
      addedAt: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, LocalNotification obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.subTitle)
      ..writeByte(3)
      ..write(obj.body)
      ..writeByte(4)
      ..write(obj.payload)
      ..writeByte(5)
      ..write(obj.groupKey)
      ..writeByte(6)
      ..write(obj.channel)
      ..writeByte(7)
      ..write(obj.addedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalNotificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
