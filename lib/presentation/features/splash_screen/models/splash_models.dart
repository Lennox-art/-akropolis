import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_models.freezed.dart';

@freezed
class SplashScreenState with _$SplashScreenState {

  const factory SplashScreenState.loading() = LoadingSplashScreenState;

  const factory SplashScreenState.notAuthenticated() = NotAuthenticatedSplashScreenState;

  const factory SplashScreenState.onBoarding() = OnBoardingSplashScreenState;

  const factory SplashScreenState.home() = HomeSplashScreenState;

}