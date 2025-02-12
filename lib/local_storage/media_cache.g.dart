// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_cache.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedMediaAdapter extends TypeAdapter<CachedMedia> {
  @override
  final int typeId = 0;

  @override
  CachedMedia read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedMedia(
      fields[0] as String,
      fields[1] as Uint8List,
      fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CachedMedia obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.cachedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedMediaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
