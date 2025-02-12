import 'package:akropolis/main.dart';
import 'package:dio/dio.dart';

Future<String?> getMediaType(String url) async {
  try {
    Response response = await Dio().head(url);
    String? contentType = response.headers.value('content-type');
    return contentType;
  } catch (e, trace) {
    log.error(
      "Error fetching media type: $e",
      trace: trace,
    );
    return null;
  }
}

Future<MediaType> whichMediaType(String url) async {
  String? contentType = await getMediaType(url);
  if (contentType == null) {
    log.info("Could not determine media type for $url");
    return MediaType.unknown;
  }

  if (contentType.startsWith('image/')) {
    return MediaType.image;
  } else if (contentType.startsWith('video/')) {
    return MediaType.video;
  } else {
    return MediaType.unknown;
  }
}

enum MediaType {
  image,
  video,
  unknown;
}
