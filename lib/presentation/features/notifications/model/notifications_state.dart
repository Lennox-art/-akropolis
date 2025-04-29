import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications_state.freezed.dart';

@freezed
sealed class NotificationsState with _$NotificationsState {
  const factory NotificationsState.loaded() = LoadedNotificationsState;
  const factory NotificationsState.loading() = LoadingNotificationsState;
}