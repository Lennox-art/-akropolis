part of 'headlines_news_cubit.dart';

@freezed
class HeadlinesNewsState with _$HeadlinesNewsState {
  const factory HeadlinesNewsState.loaded({
    ToastMessage? toast,
  }) = HeadlinesNewsStateLoadedState;

  const factory HeadlinesNewsState.loading() = HeadlinesNewsStateLoadingState;
}
