import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/user_story_repository/user_story_repository.dart';
import 'package:akropolis/domain/use_cases/get_media_use_case.dart';
import 'package:akropolis/presentation/features/news_feed/models/media_download_state.dart';
import 'package:flutter/material.dart';

class StoryViewerItemViewModel extends ChangeNotifier {
  final UserStoryRepository _userStoryRepository;
  final List<UserStory> _stories;
  final AppUser _currentUser;
  final GetMediaUseCase _getMediaUseCase;
  int _currentIndex = 0;
  MediaDownloadState _thumbnailState = const InitialMediaState();
  MediaDownloadState _videoState = const InitialMediaState();

  StoryViewerItemViewModel({
    required UserStoryRepository userStoryRepository,
    required AppUser currentUser,
    required List<UserStory> stories,
    required GetMediaUseCase getMediaUseCase,
  })  : _stories = stories,
        _currentUser = currentUser,
        _userStoryRepository = userStoryRepository,
        _getMediaUseCase = getMediaUseCase {
    downloadData();
  }

  void goToNextStory() {
    if (isLastIndex) return;
    print("Index is $_currentIndex next is ${_currentIndex + 1}");
    _currentIndex++;

    _thumbnailState = const InitialMediaState();
    _videoState = const InitialMediaState();
    downloadData();
  }

  bool get isLastIndex => _currentIndex == (_stories.length - 1);

  int get currentIndex => _currentIndex;

  int get noOfItems => _stories.length;

  UserStory get currentStory => _stories[_currentIndex];

  MediaDownloadState get thumbnailState => _thumbnailState;

  MediaDownloadState get videoState => _videoState;

  Future<void> downloadData() async {
    await Future.wait([_downloadThumbnail(), _downloadVideo(), _addToViewers()]);
  }

  Future<void> _downloadThumbnail() async {
    if (_thumbnailState is! ErrorDownloadMediaState && _thumbnailState is! InitialMediaState) return;

    try {
      _thumbnailState = const DownloadingMediaState();
      notifyListeners();

      Result<MapEntry<String, MediaData>> thumbnailResult = await _getMediaUseCase.getMediaFromUrl(
        currentStory.thumbnailUrl,
        onProgress: (p) {
          _thumbnailState = DownloadingMediaState(
            progress: ProgressModel(
              sent: p.sent,
              total: p.total,
            ),
          );
          notifyListeners();
        },
      );

      switch (thumbnailResult) {
        case Success<MapEntry<String, MediaData>>():
          _thumbnailState = DownloadedMediaState(media: thumbnailResult.data.value);
          print("_vm thumbnail downloaded for ${currentStory.id}");
          break;

        case Error<MapEntry<String, MediaData>>():
          _thumbnailState = ErrorDownloadMediaState(failure: thumbnailResult.failure);
          break;
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> _downloadVideo() async {
    if (_videoState is! ErrorDownloadMediaState && _videoState is! InitialMediaState) return;

    try {
      _videoState = const DownloadingMediaState();
      notifyListeners();

      Result<MapEntry<String, MediaData>> videoResult = await _getMediaUseCase.getMediaFromUrl(
        currentStory.postUrl,
        onProgress: (p) {
          _videoState = DownloadingMediaState(
            progress: ProgressModel(
              sent: p.sent,
              total: p.total,
            ),
          );
          notifyListeners();
        },
      );

      switch (videoResult) {
        case Success<MapEntry<String, MediaData>>():
          _videoState = DownloadedMediaState(media: videoResult.data.value);
          print("_vm video downloaded for ${currentStory.id}");
          break;

        case Error<MapEntry<String, MediaData>>():
          _videoState = ErrorDownloadMediaState(failure: videoResult.failure);
          break;
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> _addToViewers() async {
    if (currentStory.viewers.contains(_currentUser.id)) return;

    _userStoryRepository.addToViewers(userId: _currentUser.id, postId: currentStory.id);

    try {
      _videoState = const DownloadingMediaState();
      notifyListeners();

      Result<MapEntry<String, MediaData>> videoResult = await _getMediaUseCase.getMediaFromUrl(
        currentStory.postUrl,
        onProgress: (p) {
          _videoState = DownloadingMediaState(
            progress: ProgressModel(
              sent: p.sent,
              total: p.total,
            ),
          );
          notifyListeners();
        },
      );

      switch (videoResult) {
        case Success<MapEntry<String, MediaData>>():
          _videoState = DownloadedMediaState(media: videoResult.data.value);
          print("_vm video downloaded for ${currentStory.id}");
          break;

        case Error<MapEntry<String, MediaData>>():
          _videoState = ErrorDownloadMediaState(failure: videoResult.failure);
          break;
      }
    } finally {
      notifyListeners();
    }
  }
}
