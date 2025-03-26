import 'package:akropolis/domain/models/thread_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_models.freezed.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState.initial() = ChatInitialState;
  const factory ChatState.requested() = ChatRequestedState;
  const factory ChatState.declined() = ChatDeclinedState;
  const factory ChatState.loaded() = ChatLoadedState;
  const factory ChatState.loading() = ChatLoadingState;
}

class ChatDto {
  final Thread thread;
  final String currentUserId;

  ChatDto(this.thread, this.currentUserId);
}