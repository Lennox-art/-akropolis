import 'dart:io';
import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/services/file_storage_service/local_file_storage_service.dart';
import 'package:akropolis/data/utils/crypto_functions.dart';
import 'package:exception_base/exception_base.dart';
import 'package:flutter/foundation.dart';
import 'package:logging_service/logging_service.dart';
import 'package:path/path.dart' as path;

class LocalFileSystemLocalStorageServiceImpl extends LocalFileStorageService {
  final String _fileDirectory;
  final LoggingService _log;

  LocalFileSystemLocalStorageServiceImpl({
    required String filePath,
    required LoggingService loggingService,
  })  : _fileDirectory = filePath,
        _log = loggingService;

  /// Function: [getCachedFileData] will retrieve a file from the [Sha1] of the file
  /// Returns: [Result.success], with the [data] as a [Uint8List] of the file and null if file not found
  @override
  Future<Result<Uint8List?>> getCachedFileData(Sha1 sha1) async {
    try {
      _log.debug("LocalFileSystemLocalStorageServiceImpl : getCachedFileData(sha1=$sha1)");
      String filePath = path.join(_fileDirectory, sha1.short, sha1.hash);

      File file = File(filePath);
      if (!await file.exists()) return const Result.success(data: null);

      //to avoid blocking the event loop use async
      Uint8List bytes = await file.readAsBytes();
      return Result.success(data: bytes);
    } on FileSystemException catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.message,
          failureType: FailureType.illegalStateFailure,
          trace: trace,
        ),
      );
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  /// Function: [cacheLocalFile] an idempotent function that will save a [file] to the local file system
  /// Returns: [Result.success], with a [Sha1] of the file unless otherwise
  @override
  Future<Result<Sha1>> cacheLocalFileData(Uint8List data) async {
    try {
      _log.debug("LocalFileSystemLocalStorageServiceImpl : cacheLocalFile(data=${data.length})");
      Sha1 sha1 = await compute<Uint8List, Sha1>(computeSha1Hash, data);
      String filePath = path.join(_fileDirectory, sha1.short, sha1.hash);
      File f = File(filePath);
      if (await f.exists()) return Result.success(data: sha1);
      await f.writeAsBytes(data);
      return Result.success(data: sha1);
    } on FileSystemException catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.message,
          failureType: FailureType.illegalStateFailure,
          trace: trace,
        ),
      );
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }
}