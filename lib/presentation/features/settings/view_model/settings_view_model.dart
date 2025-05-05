import 'dart:async';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:akropolis/presentation/features/settings/model/settings_state.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier {

  final AuthenticationRepository _authenticationRepository;

  final StreamController<ToastMessage> _toastStreamController = StreamController.broadcast();

  SettingsState _settingsState = const LoadedSettingsState();

  SettingsViewModel({required AuthenticationRepository authenticationRepository}) : _authenticationRepository = authenticationRepository;

  SettingsState get settingsState => _settingsState;

  Future<void> logout() async {
    if (_settingsState is LoadingSettingsState) return;

    _settingsState = const LoadingSettingsState();
    notifyListeners();

    try {
      Result<void> logoutResult = await _authenticationRepository.logout();

      switch (logoutResult) {
        case Success<void>():
          _settingsState = const LoggedOutSettingsState();
          _toastStreamController.add(
            const ToastSuccess(message: "Logged out successfully"),
          );
          break;

        case Error<void>():
          _settingsState = const LoadedSettingsState();
          _toastStreamController.add(
            ToastError(message: logoutResult.failure.message),
          );
          break;
      }
    } finally {
      notifyListeners();
    }
  }

}