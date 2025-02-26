import 'package:hive/hive.dart';

part 'local_models.g.dart';

@HiveType(typeId: 3)
class LocalFileCache extends HiveObject {

  @HiveField(0)
  final String sha1;

  @HiveField(1)
  final String url;

  LocalFileCache({
    required this.sha1,
    required this.url,
  });
}

enum MediaType {
  video,
  image,
  unknown,
}

class MediaTypeAdapter extends TypeAdapter<MediaType> {
  @override
  final int typeId = 47;

  @override
  MediaType read(BinaryReader reader) {
    return MediaType.values[reader.readInt()];
  }

  @override
  void write(BinaryWriter writer, MediaType obj) {
    writer.writeInt(obj.index);
  }
}

