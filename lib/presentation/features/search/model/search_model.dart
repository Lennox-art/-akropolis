import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_model.freezed.dart';

@freezed
sealed class SearchState with _$SearchState {
  const factory SearchState.loading() = LoadingSearchState;

  const factory SearchState.loaded() = LoadedSearchState;
}

enum SearchCategory {
  trending("Trending"),
  logical("Logical"),
  empathetic("Empathetic"),
  opposingViews("Opposing Views");

  final String label;

  const SearchCategory(this.label);
}
