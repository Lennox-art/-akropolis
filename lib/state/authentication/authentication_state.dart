part of 'authentication_cubit.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.loading() = LoadingAuthentication;

  const factory AuthenticationState.loaded({
    User? user,
  }) = LoadedAuthentication;

}
