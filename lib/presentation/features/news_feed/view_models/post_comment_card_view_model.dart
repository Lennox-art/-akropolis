import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/post_repository/post_repository.dart';
import 'package:akropolis/domain/use_cases/fetch_post_comments_use_case.dart';
import 'package:akropolis/domain/use_cases/get_media_use_case.dart';
import 'package:akropolis/presentation/features/news_feed/models/media_download_state.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:flutter/cupertino.dart';

class PostCommentCardViewModel extends ChangeNotifier {
  final PostComment _comment;
  final GetMediaUseCase _getMediaUseCase;
  MediaDownloadState _thumbnailMediaState = const InitialMediaState();

  MediaDownloadState get thumbnailMediaState => _thumbnailMediaState;


  PostCommentCardViewModel({
    required PostComment comment,
    required GetMediaUseCase getMediaUseCase,
  })  : _comment = comment, _getMediaUseCase = getMediaUseCase;

  void downloadThumbnail() async {
    if(_thumbnailMediaState is! InitialMediaState && _thumbnailMediaState is! ErrorDownloadMediaState) return;

    _thumbnailMediaState = const DownloadingMediaState();
    notifyListeners();

    Result<MediaData> thumbnailResult = await _getMediaUseCase.getMediaFromUrl(
      _comment.thumbnailUrl,
      onProgress: (p) {
        _thumbnailMediaState = DownloadingMediaState(progress: p);
        notifyListeners();
      },
    );

    switch(thumbnailResult) {

      case Success<MediaData>():
        _thumbnailMediaState = DownloadedMediaState(media: thumbnailResult.data);
        notifyListeners();
        break;
      case Error<MediaData>():
        _thumbnailMediaState = ErrorDownloadMediaState(failure: thumbnailResult.failure);
        notifyListeners();
        break;
    }
  }


}
