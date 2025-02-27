import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_state.freezed.dart';

@freezed
class AuthenticationState with _$AuthenticationState {

  const factory AuthenticationState.loading() = LoadingAuthenticationState;

  const factory AuthenticationState.notAuthenticated() = NotAuthenticatedState;

  const factory AuthenticationState.partialSignUp({required User user}) = PartialSigningUpState;

  const factory AuthenticationState.authenticated({required bool requiresOnboarding}) = AuthenticatedState;

}
