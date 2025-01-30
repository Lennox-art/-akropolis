import 'package:akropolis/main.dart';
import 'package:video_compress/video_compress.dart';
import 'dart:typed_data';

/// Converts `DateTime` to a "time ago" string
String timeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inMinutes < 60) {
    return "${difference.inMinutes}m ago";
  } else if (difference.inHours < 24) {
    return "${difference.inHours}h ago";
  } else {
    return "${difference.inDays}d ago";
  }
}

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');

  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));

  if (duration.inHours > 0) {
    return '$hours:$minutes:$seconds';
  }
  return '$minutes:$seconds';
}

Future<Uint8List?> generateThumbnailBytes({
  required String videoPath,
  int timeMs = -1,
  int quality = 50,
}) async {
  try {
    return VideoCompress.getByteThumbnail(
      videoPath,
      quality: quality, // default(100)
      position: timeMs, // default(-1)
    );
  } catch (e, trace) {
    log.error('Error generating thumbnail bytes: $e', trace: trace);
    return null;
  }
}
