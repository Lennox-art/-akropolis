part of 'for_you_news_cubit.dart';

@freezed
class ForYouNewsState with _$ForYouNewsState {
  const factory ForYouNewsState.loaded({
    ToastMessage? toast,
  }) = ForYouNewsLoadedState;

  const factory ForYouNewsState.loading() = ForYouNewsLoadingState;
}
