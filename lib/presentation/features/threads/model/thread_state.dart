import 'package:freezed_annotation/freezed_annotation.dart';

part 'thread_state.freezed.dart';

@freezed
class ThreadsState with _$ThreadsState {
  const factory ThreadsState.loaded() = ThreadsLoadedState;

  const factory ThreadsState.loading() = ThreadsLoadingState;
}

class Connect {
  final String imageUrl;
  final String name;
  final String message;

  Connect({
    required this.imageUrl,
    required this.name,
    required this.message,
  });
}
