import 'package:freezed_annotation/freezed_annotation.dart';

part 'on_boarding_models.freezed.dart';

@freezed
class OnBoardingState with _$OnBoardingState {

  const factory OnBoardingState.initial() = InitialOnBoardingState;

  const factory OnBoardingState.notOnBoarded() = NotOnBoardedBoardingState;

  const factory OnBoardingState.loading() = LoadingOnBoardingState;

  const factory OnBoardingState.topics() = TopicsOnBoardingState;

  const factory OnBoardingState.notifications() = NotificationsOnBoardingState;

  const factory OnBoardingState.cleared() = ClearedOnBoardingState;

}
