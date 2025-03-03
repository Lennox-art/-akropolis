import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/post_repository/post_repository.dart';
import 'package:akropolis/domain/models/news_card_model.dart';
import 'package:akropolis/domain/use_cases/fetch_post_comments_use_case.dart';
import 'package:akropolis/domain/use_cases/get_media_use_case.dart';
import 'package:akropolis/presentation/features/news_feed/models/media_download_state.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:flutter/cupertino.dart';

class PostCommentCardViewModel extends ChangeNotifier {
  final NewsPost _newsPost;
  final NewsCardCommentModel _comment;
  final AppUser _appUser;
  final GetMediaUseCase _getMediaUseCase;
  MediaDownloadState _thumbnailMediaState = const InitialMediaState();

  MediaDownloadState get thumbnailMediaState => _thumbnailMediaState;
  AppUser get currentUser => _appUser;
  NewsPost get post => _newsPost;
  PostComment get comment => _comment.postComment;


  PostCommentCardViewModel({
    required NewsPost newsPost,
    required NewsCardCommentModel comment,
    required AppUser appUser,
    required GetMediaUseCase getMediaUseCase,
  })  : _comment = comment, _getMediaUseCase = getMediaUseCase, _appUser = appUser, _newsPost = newsPost;

  void downloadThumbnail() async {
    if(_thumbnailMediaState is! InitialMediaState && _thumbnailMediaState is! ErrorDownloadMediaState) return;

    if(_comment.thumbnail is Success<MapEntry<String, MediaData>>) {
      Success<MapEntry<String, MediaData>> thumbnail = _comment.thumbnail as Success<MapEntry<String, MediaData>>;
      _thumbnailMediaState = DownloadedMediaState(media: thumbnail.data.value);
      notifyListeners();
      return;
    }

    _thumbnailMediaState = const DownloadingMediaState();
    notifyListeners();

    Result<MapEntry<String, MediaData>> thumbnailResult = await _getMediaUseCase.getMediaFromUrl(
      _comment.postComment.thumbnailUrl,
      onProgress: (p) {
        _thumbnailMediaState = DownloadingMediaState(progress: p);
        notifyListeners();
      },
    );

    switch(thumbnailResult) {

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


}
