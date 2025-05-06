import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmarked_state.freezed.dart';

@freezed
sealed class BookmarkedState with _$BookmarkedState {
  const factory BookmarkedState.loaded() = LoadedBookmarkedState;
  const factory BookmarkedState.loading() = LoadingBookmarkedState;
}

@freezed
sealed class ResolveBookmarkedState with _$ResolveBookmarkedState {
  const factory ResolveBookmarkedState.loaded() = LoadedResolveBookmarkedState;
  const factory ResolveBookmarkedState.loading() = LoadingResolveBookmarkedState;
}