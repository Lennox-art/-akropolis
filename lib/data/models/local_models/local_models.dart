import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
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

@HiveType(typeId: 29)
class LocalNotification extends HiveObject implements Comparable<LocalNotification> {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String subTitle;

  @HiveField(3)
  final String body;

  @HiveField(4)
  final String? payload;

  @HiveField(5)
  final String groupKey;

  @HiveField(6)
  final NotificationChannel channel;

  @HiveField(7)
  final DateTime addedAt;

  LocalNotification({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.body,
    this.payload,
    required this.groupKey,
    required this.channel,
    required this.addedAt,
  });

  @override
  int compareTo(LocalNotification other) {
    return -addedAt.compareTo(other.addedAt);
  }
}

class NotificationChannelAdapter extends TypeAdapter<NotificationChannel> {
  @override
  final int typeId = 47;

  @override
  NotificationChannel read(BinaryReader reader) {
    return NotificationChannel.values[reader.readInt()];
  }

  @override
  void write(BinaryWriter writer, NotificationChannel obj) {
    writer.writeInt(obj.index);
  }
}
