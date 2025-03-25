import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:hive/hive.dart';

part 'local_models.g.dart';

@HiveType(typeId: 3)
class LocalFileCache extends HiveObject {

  @HiveField(0)
  final String sha1;

  @HiveField(1)
  final String url;

  @HiveField(2)
  final MediaType mediaType;

  LocalFileCache({
    required this.sha1,
    required this.url,
    required this.mediaType,
  });
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

