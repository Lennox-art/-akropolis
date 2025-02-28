import 'dart:io';
import 'dart:math';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/main.dart';
import 'package:exception_base/exception_base.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_session.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/media_information.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/media_information_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

Future<Result<Uint8List>> _generateThumbnail({required String videoPath, int timeInSeconds = 1}) async {
  try {
    BackgroundIsolateBinaryMessenger.ensureInitialized(RootIsolateToken.instance!);
    Directory d = File(videoPath).parent;
    String outputPath = path.join(d.path, "thumb_${Random().nextInt(20000)}.jpg");

    log.debug("Generating thumbnail to: $outputPath");

    String command = '-ss $timeInSeconds -i "$videoPath" -frames:v 1 "$outputPath"';

    FFmpegSession session = await FFmpegKit.execute(command);

    final ReturnCode? returnCode = await session.getReturnCode();
    if (returnCode == null || !returnCode.isValueSuccess()) {
      return Result.error(
        failure: AppFailure(
          message: "Thumbnail generation failed: $returnCode",
          trace: returnCode,
        ),
      );
    }

    log.debug("Thumbnail successfully generated: $outputPath");
    await Future.delayed(const Duration(seconds: 1));
    return Result.success(data: await File(outputPath).readAsBytes());
  } catch (e, trace) {
    log.error("Error generating thumbnail $e", trace: trace);
    return Result.error(
      failure: AppFailure(
        message: e.toString(),
        trace: trace,
      ),
    );
  }
}

///GenerateThumbnails
class GenerateThumbnailsRequest {
  final String videoPath;
  final int count;

  GenerateThumbnailsRequest({
    required this.videoPath,
    required this.count,
  });
}

Future<Result<List<Uint8List>>> generateThumbnails(GenerateThumbnailsRequest request) async {
  try {
    List<Uint8List> thumbnails = [];

    Result<Duration> durationResult = await getVideoDuration(request.videoPath);

    switch (durationResult) {
      case Success<Duration>():
        double interval = durationResult.data.inSeconds / request.count;

        //TODO: Check if in order
        List<Result<Uint8List>> thumbnailsResult = await Future.wait<Result<Uint8List>>(
          List.generate(
            request.count,
            (i) {
              int timeInSeconds = (interval * i).round();
              return _generateThumbnail(
                videoPath: request.videoPath,
                timeInSeconds: timeInSeconds,
              );
            },
          ),
        );
        for (Result<Uint8List> result in thumbnailsResult) {
          switch (result) {
            case Success<Uint8List>():
              thumbnails.add(result.data);
              break;
            case Error<Uint8List>():
              continue;
          }
        }

        return Result.success(data: thumbnails);
      case Error<Duration>():
        return Result.error(failure: durationResult.failure);
    }
  } catch (e, trace) {
    return Result.error(
      failure: AppFailure(
        message: e.toString(),
        trace: trace,
      ),
    );
  }
}

Future<Result<Duration>> getVideoDuration(String videoPath) async {
  try {
    final MediaInformationSession session = await FFprobeKit.getMediaInformation(videoPath);
    final MediaInformation? mediaInfo = session.getMediaInformation();

    if (mediaInfo == null) {
      return Result.error(
        failure: AppFailure(
          message: "Failed to get media info",
        ),
      );
    }

    String? durationStr = mediaInfo.getDuration();
    if (durationStr == null) {
      return Result.error(
        failure: AppFailure(
          message: "Failed to get media duration",
        ),
      );
    }
    double durationInSeconds = double.parse(durationStr);
    return Result.success(data: Duration(seconds: durationInSeconds.toInt()));
  } catch (e, trace) {
    return Result.error(
      failure: AppFailure(
        message: e.toString(),
        trace: trace,
      ),
    );
  }
}

///Trim Video
class TrimVideoRequest {
  final File file;
  final Duration start;
  final Duration end;

  TrimVideoRequest({
    required this.file,
    required this.start,
    required this.end,
  });
}

Future<Result<File>> trimVideoInRange(TrimVideoRequest request) async {
  try {
    final dir = request.file.parent;
    final outputPath = '${dir.path}/trimmed_video_${Random().nextInt(2000)}.mp4';

    String command = '-i "${request.file.path}" -ss ${request.start.inSeconds} -to ${request.end.inSeconds} -c copy "$outputPath"';

    FFmpegSession session = await FFmpegKit.execute(command);
    final ReturnCode? returnCode = await session.getReturnCode();

    if (returnCode == null || !returnCode.isValueSuccess()) {
      return Result.error(
        failure: AppFailure(
          message: "Trimming video failed: $returnCode",
          trace: returnCode,
        ),
      );
    }

    return Result.success(data: File(outputPath));
  } catch (e, trace) {
    return Result.error(
      failure: AppFailure(
        message: e.toString(),
        trace: trace,
      ),
    );
  }
}
