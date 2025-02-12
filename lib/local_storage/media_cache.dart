import 'dart:async';
import 'dart:typed_data';

import 'package:akropolis/main.dart';
import 'package:dio/dio.dart';
import 'package:hive_database_service/hive_database_service.dart';

part 'media_cache.g.dart';

@HiveType(typeId: 0)
class CachedMedia extends HiveObject {
  @HiveField(0)
  final String url;

  @HiveField(1)
  final Uint8List data;

  @HiveField(2)
  DateTime cachedAt;

  CachedMedia(this.url, this.data, this.cachedAt);

  bool get shouldDeleteMedia => DateTime.now().difference(cachedAt) > MediaCache.maxDuration;

  void updateUsage() {
    cachedAt = DateTime.now();
    save();
  }
}

class MediaCache {
  static final Dio _dio = Dio();
  static const maxCapacity = 100;
  static const maxDuration = Duration(days: 2);
  static const _urlBox = "urls";

  MediaCache._();

  static Future<void> _addUrl(String url) async {
    Box<String> urlBox = await db.openBox(_urlBox);
    urlBox.add(url);
    log.info("Adding new media to $_urlBox: $url");

    if (urlBox.length >= maxCapacity) clearExpiredUrls();
  }

  static Future<void> clearCache() async {
    Box<String> urlBox = await db.openBox(_urlBox);
    for (var url in urlBox.values) {
      db.removeValue(url);
      urlBox.delete(url);
    }
  }

  static Future<void> clearExpiredUrls() async {
    Box<String> urlBox = await db.openBox(_urlBox);
    for (var url in urlBox.values) {
      CachedMedia? cachedMedia = await db.getValue<CachedMedia>(url);
      if (cachedMedia == null) {
        urlBox.delete(url);
        continue;
      }

      if (!cachedMedia.shouldDeleteMedia) continue;

      urlBox.delete(url);
      cachedMedia.delete();
    }
  }

  static Future<void> addMedia(String url, Uint8List data) async {
    log.info("Adding media to cache: $url");
    if (await hasMedia(url)) return;

    log.info("Adding new media to cache: $url");
    await db.putValue<CachedMedia>(url, CachedMedia(url, data, DateTime.now()));
    _addUrl(url);
  }

  static Future<bool> hasMedia(String url) async {
    log.info("Checking if media is in cache: $url");
    CachedMedia? cachedMedia = await db.getValue<CachedMedia>(url);
    if (cachedMedia == null) return false;
    cachedMedia.updateUsage();
    return true;
  }

  static Future<Uint8List?> _getMedia(String url) async {
    log.info("Getting media from cache: $url");

    CachedMedia? cachedMedia = await db.getValue<CachedMedia>(url);
    if (cachedMedia == null) {
      log.info("Media not found in cache: $url");
      return null;
    }

    log.info("Found media in cache $url");

    cachedMedia.updateUsage();
    return cachedMedia.data;
  }

  static Stream<Uint8List> downloadMedia(String url) async* {
    log.info("Downloading media $url");

    // Check if media is already cached
    Uint8List? cachedData = await _getMedia(url);
    if (cachedData != null) {
      log.info("Returning cached media: $url");
      yield cachedData;
      return;
    }

    log.info("Media not in cache: Downloading... $url");

    final StreamController<Uint8List> controller = StreamController();
    final List<int> buffer = [];

    try {
      Response<ResponseBody> response = await _dio.get<ResponseBody>(
        url,
        options: Options(responseType: ResponseType.stream),
      );

      log.info("Stream response received: $url");

      // Process the stream
      int i = 0;
      await for (List<int> chunk in response.data!.stream) {
        buffer.addAll(chunk);
        controller.add(Uint8List.fromList(chunk)); // Stream chunked data
        log.info("Receiving chunk data: ${i++}");
      }

      final Uint8List fullData = Uint8List.fromList(buffer);
      await addMedia(url, fullData); // Cache the media

      await controller.close();
    } catch (e, trace) {
      log.error("Error downloading media: $e", trace: trace);
      controller.addError(e);
      await controller.close();
    }

    yield* controller.stream;
  }

}