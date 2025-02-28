import 'dart:io';
import 'dart:typed_data';

import 'package:akropolis/data/models/dto_models/dto_models.dart';

abstract class LocalFileStorageService {

  /// Function: [cacheLocalFile] an idempotent function that will save a [file] to the local file system
  /// Returns: [Result.success], with a [Sha1] of the file unless otherwise
  Future<Result<CacheFileResult>> cacheLocalFileData(Uint8List data);

  /// Function: [getCachedFileData] will retrieve a file from the [Sha1] of the file
  /// Returns: [Result.success], with the [selectedThumbnail] as a [Uint8List] of the file and null if file not found
  Future<Result<File?>> getCachedFileData(Sha1 sha1);

  /// Path to [Directory] where [File]'s will be stored
  String get _fileDirectory;

}

