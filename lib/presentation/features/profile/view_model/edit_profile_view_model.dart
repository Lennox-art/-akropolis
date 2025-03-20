import 'dart:async';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/local_models/local_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/user_repository/user_repository.dart';
import 'package:akropolis/data/services/file_storage_service/remote_file_storage_service.dart';
import 'package:akropolis/presentation/features/profile/model/profile_models.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/cupertino.dart';

class EditProfileViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  final RemoteFileStorageService _remoteFileStorageService;
  final StreamController<ToastMessage> _toastMessageStream = StreamController.broadcast();
  AppUser _currentUser;
  EditProfileState _editProfileState = const LoadedEditProfileState();
  ProfilePictureState _profilePictureState = const LoadedProfilePictureState();

  EditProfileViewModel({
    required AppUser currentUser,
    required UserRepository userRepository,
    required RemoteFileStorageService remoteFileStorageService,
  })  : _userRepository = userRepository,
        _currentUser = currentUser,
        _remoteFileStorageService = remoteFileStorageService;

  AppUser get currentUser => _currentUser;

  EditProfileState get editProfileState => _editProfileState;

  ProfilePictureState get profilePictureState => _profilePictureState;

  Stream<ToastMessage> get toastStream => _toastMessageStream.stream;

  Future<void> uploadProfilePicture(MediaBlobData blob) async {
    if (_profilePictureState is! LoadedProfilePictureState) return;

    try {
      _profilePictureState = const LoadingProfilePictureState();
      notifyListeners();

      Result<LocalFileCache> uploadProfilePicResult = await _remoteFileStorageService.uploadBlob(
        blob,
        onProgress: (p) {
          _profilePictureState = LoadingProfilePictureState(progress: p);
          notifyListeners();
        },
      );

      switch (uploadProfilePicResult) {
        case Success<LocalFileCache>():
          _toastMessageStream.add(
            const ToastSuccess(message: "Profile picture uploaded"),
          );
          updateUser(currentUser..profilePicture = uploadProfilePicResult.data.url);
          break;
        case Error<LocalFileCache>():
          _toastMessageStream.add(
            ToastError(message: uploadProfilePicResult.failure.message),
          );
          break;
      }
    } finally {
      _profilePictureState = const LoadedProfilePictureState();
      notifyListeners();
    }
  }

  Future<void> updateUser(AppUser updatedUser) async {
    if (_editProfileState is! LoadedEditProfileState) return;

    try {
      _editProfileState = const LoadingEditProfileState();
      notifyListeners();

      Result<AppUser> updateUserResult = await _userRepository.saveAppUser(
        appUser: updatedUser,
      );

      switch (updateUserResult) {
        case Success<AppUser>():
          _currentUser = updateUserResult.data;
          break;

        case Error<AppUser>():
          _toastMessageStream.add(ToastError(message: updateUserResult.failure.message));
          break;
      }
    } finally {
      _editProfileState = const LoadedEditProfileState();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _toastMessageStream.close();
    super.dispose();
  }
}
