import 'dart:io';
import 'dart:typed_data';

import 'package:akropolis/data/models/local_models/local_models.dart';
import 'package:exception_base/exception_base.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dto_models.freezed.dart';

// sealed class Result {}
//
// class Success<T> extends Result {
//   final T data;
//   Success(this.data);
// }
//
// class Error extends Result {
//   final AppFailure errorMessage;
//   Error(this.errorMessage);
// }
//

@freezed
sealed class Result<T> with _$Result<T> {
  const factory Result.success({
    required T data,
  }) = Success<T>;

  const factory Result.error({
    required AppFailure failure,
  }) = Error;
}


/// Hash of a sha1 with validation
class Sha1 {
  final String hash;

  Sha1(this.hash) : assert(hash.length == 40);

  String get sub => hash.substring(0, 2);

  String get short => hash.substring(0, 6);
}

///Display progress
class ProgressModel {
  int sent;
  int total;

  ProgressModel({
    required this.sent,
    required this.total,
  }) : assert(total > 0);

  double get percent => (sent * 100) / total;

  @override
  String toString() => "$sent / $total = $percent %";
}

class MediaData {
  final File file;
  final MediaType mediaType;

  MediaData({
    required this.file,
    required this.mediaType,
  });

}

class MediaBlobData {
  final Uint8List blob;
  final MediaType mediaType;

  MediaBlobData({
    required this.blob,
    required this.mediaType,
  });

}

class CacheFileResult {
  final File file;
  final Sha1 sha1;

  CacheFileResult({
    required this.file,
    required this.sha1,
  });

}