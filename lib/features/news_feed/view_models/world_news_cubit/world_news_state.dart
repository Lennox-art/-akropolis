part of 'world_news_cubit.dart';

@freezed
class WorldNewsState with _$WorldNewsState {
  const factory WorldNewsState.loading() = LoadingWorldNewsState;

  const factory WorldNewsState.loaded({
    ToastMessage? toast,
  }) = LoadedWorldNewsState;

}
