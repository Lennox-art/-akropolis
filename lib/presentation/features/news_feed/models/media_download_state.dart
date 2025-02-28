import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:exception_base/exception_base.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_download_state.freezed.dart';

@freezed
class MediaDownloadState with _$MediaDownloadState {
  const factory MediaDownloadState.initial() = InitialMediaState;
  const factory MediaDownloadState.downloadingMedia({ProgressModel? progress}) = DownloadingMediaState;
  const factory MediaDownloadState.downloadedMedia({required MediaData media}) = DownloadedMediaState;
  const factory MediaDownloadState.errorDownloadingMedia({required AppFailure failure}) = ErrorDownloadMediaState;

}