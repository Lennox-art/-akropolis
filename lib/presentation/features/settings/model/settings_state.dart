import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';

@freezed
sealed class SettingsState with _$SettingsState {
  const factory SettingsState.loaded() = LoadedSettingsState;
  const factory SettingsState.loading() = LoadingSettingsState;
  const factory SettingsState.loggedOut() = LoggedOutSettingsState;
}