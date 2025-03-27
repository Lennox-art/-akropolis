import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/post_repository/post_repository.dart';
import 'package:akropolis/domain/models/news_card_model.dart';
import 'package:akropolis/domain/use_cases/fetch_post_comments_use_case.dart';
import 'package:akropolis/domain/use_cases/get_media_use_case.dart';
import 'package:akropolis/domain/use_cases/post_reply_use_case.dart';
import 'package:akropolis/domain/utils/functions.dart';
import 'package:akropolis/presentation/features/create_post/models/create_post_models.dart';
import 'package:akropolis/presentation/features/news_feed/models/media_download_state.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' as io;

class ChatMessageViewModel extends ChangeNotifier {
  final GetMediaUseCase _getMediaUseCase;
  final MessageRemote _messageRemote;

  final StreamController<ToastMessage> _toastMessageStream = StreamController.broadcast();

  MediaDownloadState _thumbnailMediaState = const InitialMediaState();
  Result<MapEntry<String, MediaData>>? thumbnail;

  MediaDownloadState _postMediaState = const InitialMediaState();
  Result<MapEntry<String, MediaData>>? postMedia;

  ChatMessageViewModel({
    required MessageRemote messageRemote,
    required GetMediaUseCase getMediaUseCase,
  })  : _getMediaUseCase = getMediaUseCase,
        _messageRemote = messageRemote;

  Stream<ToastMessage> get toastStream => _toastMessageStream.stream;

  MediaDownloadState get postMediaState => _postMediaState;

  MediaDownloadState get thumbnailMediaState => _thumbnailMediaState;

  MessageRemote get message => _messageRemote;



  void downloadThumbnail() async {
    if (_thumbnailMediaState is! InitialMediaState && _thumbnailMediaState is! ErrorDownloadMediaState) return;

    if (thumbnail != null && thumbnail is Success<Result<MapEntry<String, MediaData>>>) {
      Success<MapEntry<String, MediaData>> result = _thumbnailMediaState as Success<MapEntry<String, MediaData>>;
      _thumbnailMediaState = DownloadedMediaState(media: result.data.value);
      notifyListeners();
      return;
    }

    _thumbnailMediaState = const DownloadingMediaState();
    notifyListeners();

    Result<MapEntry<String, MediaData>> thumbnailResult = await _getMediaUseCase.getMediaFromUrl(
      message.thumbnailUrl,
      onProgress: (p) {
        _thumbnailMediaState = DownloadingMediaState(progress: p);
        notifyListeners();
      },
    );

    switch (thumbnailResult) {
      case Success<MapEntry<String, MediaData>>():
        _thumbnailMediaState = DownloadedMediaState(media: thumbnailResult.data.value);
        notifyListeners();
        break;
      case Error<MapEntry<String, MediaData>>():
        _thumbnailMediaState = ErrorDownloadMediaState(failure: thumbnailResult.failure);
        notifyListeners();
        break;
    }
  }

  void downloadPost() async {
    if (_postMediaState is! InitialMediaState && _postMediaState is! ErrorDownloadMediaState) return;

    _postMediaState = const DownloadingMediaState();
    notifyListeners();

    Result<MapEntry<String, MediaData>> thumbnailResult = await _getMediaUseCase.getMediaFromUrl(
      message.videoUrl,
      onProgress: (p) {
        _postMediaState = DownloadingMediaState(progress: p);
        notifyListeners();
      },
    );

    switch (thumbnailResult) {
      case Success<MapEntry<String, MediaData>>():
        _postMediaState = DownloadedMediaState(media: thumbnailResult.data.value);
        notifyListeners();
        break;
      case Error<MapEntry<String, MediaData>>():
        _postMediaState = ErrorDownloadMediaState(failure: thumbnailResult.failure);
        notifyListeners();
        break;
    }
  }

}
