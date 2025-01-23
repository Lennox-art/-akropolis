part of 'user_cubit.dart';

@freezed
class UserState with _$UserState {

  const factory UserState.loaded() = LoadedUserState;

  const factory UserState.loading() = LoadingUserState;

}
