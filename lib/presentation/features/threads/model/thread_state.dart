import 'package:freezed_annotation/freezed_annotation.dart';

part 'thread_state.freezed.dart';

@freezed
class ThreadsState with _$ThreadsState {
  const factory ThreadsState.loaded() = ThreadsLoadedState;
  const factory ThreadsState.loading() = ThreadsLoadingState;
}