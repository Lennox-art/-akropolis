import 'dart:io';

import 'package:akropolis/main.dart';
//import 'package:ffmpeg_helper/ffmpeg_helper.dart';
import 'dart:typed_data';
import 'package:path/path.dart';

import 'package:video_compress/video_compress.dart';

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
    // throw Exception("Not implemented");
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



/*Future<Duration?> getVideoDuration(String fileUrlOrPath) async {
  num videoDuration = 60.19;
  MediaInformationSession session = await FFprobeKit.getMediaInformation(
    fileUrlOrPath,
    const Duration(milliseconds: 800).inMilliseconds,
  );

  final information = session.getMediaInformation();

  try {
    for (int x = 0; x < information!.getStreams().length; x++) {
      final stream = information.getStreams()[x];

      if (stream.getAllProperties() != null && videoDuration == 60.19) {
        videoDuration = num.parse(stream.getAllProperties()!["duration"].toString());

        return Duration(seconds: videoDuration.toInt());
      }
    }
  } catch (e, trace) {
    log.error(e,trace: trace);
  }

  return null;
}

Future<void> saveTrimmedVideo({
  required double startValue,
  required double endValue,
  required File selectedVideo,
  required Function(String? outputPath) onSave,
}) async {
  final String videoPath = selectedVideo.path;
  final String videoName = basename(videoPath).split('.')[0];

  String command;
  String outputPath;

  var videoFileName = "${videoName}_trimmed";
  videoFileName = videoFileName.replaceAll(' ', '_');

  String path = selectedVideo.path;

  Duration startPoint = Duration(milliseconds: startValue.toInt());
  Duration endPoint = Duration(milliseconds: endValue.toInt());

// Checking the start and end point strings
  log.debug("Start: ${startPoint.toString()} & End: ${endPoint.toString()}");
  log.debug(path);

  String trimLengthCommand = ' -ss $startPoint -i "$videoPath" -t ${endPoint - startPoint} -avoid_negative_ts make_zero ';
  command = '$trimLengthCommand -c:a copy -crf 30 -preset ultrafast ';

  ///getExtension method returns file extension like .mp4 .avi etc
  outputPath = '$path$videoFileName${extension(selectedVideo.path)}';
  command += '"$outputPath"';

  FFmpegKit.executeAsync(command, (session) async {

    final state = await session.getState();
    final returnCode = await session.getReturnCode();

    log.debug("FFmpeg process exited with state $state and rc $returnCode");

    if (ReturnCode.isSuccess(returnCode)) {
      log.debug('Video successfuly saved');
      onSave(outputPath);
    } else {
      log.debug("FFmpeg processing failed.");
      onSave(null);
    }
  });
}*/
