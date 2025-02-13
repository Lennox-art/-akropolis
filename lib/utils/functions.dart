import 'dart:io';
import 'dart:math';

import 'package:akropolis/main.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_session.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/media_information.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/media_information_session.dart';
import 'package:flutter/material.dart';

import 'dart:typed_data';
import 'package:path/path.dart' as path;

import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';

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

Future<Uint8List?> generateThumbnail({
  required String videoPath,
  int timeInSeconds = 1,
}) async {
  try {
    Directory d = File(videoPath).parent;
    String outputPath = path.join(d.path, "thumb_${Random().nextInt(20000)}.jpg");

    log.debug("Generating thumbnail to: $outputPath");

    String command = '-ss $timeInSeconds -i "$videoPath" -frames:v 1 "$outputPath"';

    FFmpegSession session = await FFmpegKit.execute(command);

    final ReturnCode? returnCode = await session.getReturnCode();
    if (returnCode?.isValueSuccess() ?? false) {
      log.debug("Thumbnail successfully generated: $outputPath");
      await Future.delayed(const Duration(seconds: 1));
      return File(outputPath).readAsBytes();
    } else {
      log.debug("Thumbnail generation failed: $returnCode");
      return null;
    }
  } catch (e, trace) {
    log.error("Error generating thumbnail $e", trace: trace);
    return null;
  }
}

Future<List<Uint8List>> generateThumbnails({
  required String videoPath,
  required int count,
}) async {
  List<Uint8List> thumbnails = [];

  Duration? duration = await getVideoDuration(videoPath);
  if (duration == null || duration.inSeconds == 0) return [];

  double interval = duration.inSeconds / count;

  for (int i = 0; i < count; i++) {
    int timeInSeconds = (interval * i).round();
    Uint8List? thumbnail = await generateThumbnail(videoPath: videoPath, timeInSeconds: timeInSeconds);
    if (thumbnail == null) continue;
    thumbnails.add(thumbnail);
  }

  return thumbnails;
}

Future<Duration?> getVideoDuration(String videoPath) async {
  final MediaInformationSession session = await FFprobeKit.getMediaInformation(videoPath);
  final MediaInformation? mediaInfo = session.getMediaInformation();

  if (mediaInfo == null) return null;

  String? durationStr = mediaInfo.getDuration();
  double? durationInSeconds = durationStr != null ? double.tryParse(durationStr) : null;
  return durationInSeconds != null ? Duration(seconds: durationInSeconds.toInt()) : null;
}

Future<File?> trimVideoToTime({
  required File file,
  required Duration start,
  required Duration end,
}) async {
  try {
    final dir = file.parent;
    final outputPath = '${dir.path}/trimmed_video_${Random().nextInt(2000)}.mp4';

    String command = '-i "${file.path}" -ss ${start.inSeconds} -to ${end.inSeconds} -c copy "$outputPath"';

    FFmpegSession session = await FFmpegKit.execute(command);
    final ReturnCode? returnCode = await session.getReturnCode();
    if (returnCode?.isValueSuccess() ?? false) {
      log.debug("Video trimmed successfully: $outputPath");
      return File(outputPath);
    } else {
      log.debug("Video trim failed: $returnCode");
      return null;
    }
  } catch (e, trace) {
    log.error("Error trimming video thumbnail $e", trace: trace);
    return null;
  }
}

final Uint8List kTransparentImage = Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
  0x42,
  0x60,
  0x82,
]);


bool isTopRoute(BuildContext context) {
  return ModalRoute.of(context)?.isCurrent ?? false;
}