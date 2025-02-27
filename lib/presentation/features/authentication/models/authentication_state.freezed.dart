// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthenticationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() notAuthenticated,
    required TResult Function(User user) partialSignUp,
    required TResult Function(bool requiresOnboarding) authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? notAuthenticated,
    TResult? Function(User user)? partialSignUp,
    TResult? Function(bool requiresOnboarding)? authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? notAuthenticated,
    TResult Function(User user)? partialSignUp,
    TResult Function(bool requiresOnboarding)? authenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingAuthenticationState value) loading,
    required TResult Function(NotAuthenticatedState value) notAuthenticated,
    required TResult Function(PartialSigningUpState value) partialSignUp,
    required TResult Function(AuthenticatedState value) authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingAuthenticationState value)? loading,
    TResult? Function(NotAuthenticatedState value)? notAuthenticated,
    TResult? Function(PartialSigningUpState value)? partialSignUp,
    TResult? Function(AuthenticatedState value)? authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingAuthenticationState value)? loading,
    TResult Function(NotAuthenticatedState value)? notAuthenticated,
    TResult Function(PartialSigningUpState value)? partialSignUp,
    TResult Function(AuthenticatedState value)? authenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationStateCopyWith<$Res> {
  factory $AuthenticationStateCopyWith(
          AuthenticationState value, $Res Function(AuthenticationState) then) =
      _$AuthenticationStateCopyWithImpl<$Res, AuthenticationState>;
}

/// @nodoc
class _$AuthenticationStateCopyWithImpl<$Res, $Val extends AuthenticationState>
    implements $AuthenticationStateCopyWith<$Res> {
  _$AuthenticationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadingAuthenticationStateImplCopyWith<$Res> {
  factory _$$LoadingAuthenticationStateImplCopyWith(
          _$LoadingAuthenticationStateImpl value,
          $Res Function(_$LoadingAuthenticationStateImpl) then) =
      __$$LoadingAuthenticationStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingAuthenticationStateImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res,
        _$LoadingAuthenticationStateImpl>
    implements _$$LoadingAuthenticationStateImplCopyWith<$Res> {
  __$$LoadingAuthenticationStateImplCopyWithImpl(
      _$LoadingAuthenticationStateImpl _value,
      $Res Function(_$LoadingAuthenticationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingAuthenticationStateImpl implements LoadingAuthenticationState {
  const _$LoadingAuthenticationStateImpl();

  @override
  String toString() {
    return 'AuthenticationState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingAuthenticationStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() notAuthenticated,
    required TResult Function(User user) partialSignUp,
    required TResult Function(bool requiresOnboarding) authenticated,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? notAuthenticated,
    TResult? Function(User user)? partialSignUp,
    TResult? Function(bool requiresOnboarding)? authenticated,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? notAuthenticated,
    TResult Function(User user)? partialSignUp,
    TResult Function(bool requiresOnboarding)? authenticated,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingAuthenticationState value) loading,
    required TResult Function(NotAuthenticatedState value) notAuthenticated,
    required TResult Function(PartialSigningUpState value) partialSignUp,
    required TResult Function(AuthenticatedState value) authenticated,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingAuthenticationState value)? loading,
    TResult? Function(NotAuthenticatedState value)? notAuthenticated,
    TResult? Function(PartialSigningUpState value)? partialSignUp,
    TResult? Function(AuthenticatedState value)? authenticated,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingAuthenticationState value)? loading,
    TResult Function(NotAuthenticatedState value)? notAuthenticated,
    TResult Function(PartialSigningUpState value)? partialSignUp,
    TResult Function(AuthenticatedState value)? authenticated,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LoadingAuthenticationState implements AuthenticationState {
  const factory LoadingAuthenticationState() = _$LoadingAuthenticationStateImpl;
}

/// @nodoc
abstract class _$$NotAuthenticatedStateImplCopyWith<$Res> {
  factory _$$NotAuthenticatedStateImplCopyWith(
          _$NotAuthenticatedStateImpl value,
          $Res Function(_$NotAuthenticatedStateImpl) then) =
      __$$NotAuthenticatedStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NotAuthenticatedStateImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$NotAuthenticatedStateImpl>
    implements _$$NotAuthenticatedStateImplCopyWith<$Res> {
  __$$NotAuthenticatedStateImplCopyWithImpl(_$NotAuthenticatedStateImpl _value,
      $Res Function(_$NotAuthenticatedStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NotAuthenticatedStateImpl implements NotAuthenticatedState {
  const _$NotAuthenticatedStateImpl();

  @override
  String toString() {
    return 'AuthenticationState.notAuthenticated()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotAuthenticatedStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() notAuthenticated,
    required TResult Function(User user) partialSignUp,
    required TResult Function(bool requiresOnboarding) authenticated,
  }) {
    return notAuthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? notAuthenticated,
    TResult? Function(User user)? partialSignUp,
    TResult? Function(bool requiresOnboarding)? authenticated,
  }) {
    return notAuthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? notAuthenticated,
    TResult Function(User user)? partialSignUp,
    TResult Function(bool requiresOnboarding)? authenticated,
    required TResult orElse(),
  }) {
    if (notAuthenticated != null) {
      return notAuthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingAuthenticationState value) loading,
    required TResult Function(NotAuthenticatedState value) notAuthenticated,
    required TResult Function(PartialSigningUpState value) partialSignUp,
    required TResult Function(AuthenticatedState value) authenticated,
  }) {
    return notAuthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingAuthenticationState value)? loading,
    TResult? Function(NotAuthenticatedState value)? notAuthenticated,
    TResult? Function(PartialSigningUpState value)? partialSignUp,
    TResult? Function(AuthenticatedState value)? authenticated,
  }) {
    return notAuthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingAuthenticationState value)? loading,
    TResult Function(NotAuthenticatedState value)? notAuthenticated,
    TResult Function(PartialSigningUpState value)? partialSignUp,
    TResult Function(AuthenticatedState value)? authenticated,
    required TResult orElse(),
  }) {
    if (notAuthenticated != null) {
      return notAuthenticated(this);
    }
    return orElse();
  }
}

abstract class NotAuthenticatedState implements AuthenticationState {
  const factory NotAuthenticatedState() = _$NotAuthenticatedStateImpl;
}

/// @nodoc
abstract class _$$PartialSigningUpStateImplCopyWith<$Res> {
  factory _$$PartialSigningUpStateImplCopyWith(
          _$PartialSigningUpStateImpl value,
          $Res Function(_$PartialSigningUpStateImpl) then) =
      __$$PartialSigningUpStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({User user});
}

/// @nodoc
class __$$PartialSigningUpStateImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$PartialSigningUpStateImpl>
    implements _$$PartialSigningUpStateImplCopyWith<$Res> {
  __$$PartialSigningUpStateImplCopyWithImpl(_$PartialSigningUpStateImpl _value,
      $Res Function(_$PartialSigningUpStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$PartialSigningUpStateImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }
}

/// @nodoc

class _$PartialSigningUpStateImpl implements PartialSigningUpState {
  const _$PartialSigningUpStateImpl({required this.user});

  @override
  final User user;

  @override
  String toString() {
    return 'AuthenticationState.partialSignUp(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartialSigningUpStateImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartialSigningUpStateImplCopyWith<_$PartialSigningUpStateImpl>
      get copyWith => __$$PartialSigningUpStateImplCopyWithImpl<
          _$PartialSigningUpStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() notAuthenticated,
    required TResult Function(User user) partialSignUp,
    required TResult Function(bool requiresOnboarding) authenticated,
  }) {
    return partialSignUp(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? notAuthenticated,
    TResult? Function(User user)? partialSignUp,
    TResult? Function(bool requiresOnboarding)? authenticated,
  }) {
    return partialSignUp?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? notAuthenticated,
    TResult Function(User user)? partialSignUp,
    TResult Function(bool requiresOnboarding)? authenticated,
    required TResult orElse(),
  }) {
    if (partialSignUp != null) {
      return partialSignUp(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingAuthenticationState value) loading,
    required TResult Function(NotAuthenticatedState value) notAuthenticated,
    required TResult Function(PartialSigningUpState value) partialSignUp,
    required TResult Function(AuthenticatedState value) authenticated,
  }) {
    return partialSignUp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingAuthenticationState value)? loading,
    TResult? Function(NotAuthenticatedState value)? notAuthenticated,
    TResult? Function(PartialSigningUpState value)? partialSignUp,
    TResult? Function(AuthenticatedState value)? authenticated,
  }) {
    return partialSignUp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingAuthenticationState value)? loading,
    TResult Function(NotAuthenticatedState value)? notAuthenticated,
    TResult Function(PartialSigningUpState value)? partialSignUp,
    TResult Function(AuthenticatedState value)? authenticated,
    required TResult orElse(),
  }) {
    if (partialSignUp != null) {
      return partialSignUp(this);
    }
    return orElse();
  }
}

abstract class PartialSigningUpState implements AuthenticationState {
  const factory PartialSigningUpState({required final User user}) =
      _$PartialSigningUpStateImpl;

  User get user;

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartialSigningUpStateImplCopyWith<_$PartialSigningUpStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthenticatedStateImplCopyWith<$Res> {
  factory _$$AuthenticatedStateImplCopyWith(_$AuthenticatedStateImpl value,
          $Res Function(_$AuthenticatedStateImpl) then) =
      __$$AuthenticatedStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool requiresOnboarding});
}

/// @nodoc
class __$$AuthenticatedStateImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticatedStateImpl>
    implements _$$AuthenticatedStateImplCopyWith<$Res> {
  __$$AuthenticatedStateImplCopyWithImpl(_$AuthenticatedStateImpl _value,
      $Res Function(_$AuthenticatedStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requiresOnboarding = null,
  }) {
    return _then(_$AuthenticatedStateImpl(
      requiresOnboarding: null == requiresOnboarding
          ? _value.requiresOnboarding
          : requiresOnboarding // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AuthenticatedStateImpl implements AuthenticatedState {
  const _$AuthenticatedStateImpl({required this.requiresOnboarding});

  @override
  final bool requiresOnboarding;

  @override
  String toString() {
    return 'AuthenticationState.authenticated(requiresOnboarding: $requiresOnboarding)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticatedStateImpl &&
            (identical(other.requiresOnboarding, requiresOnboarding) ||
                other.requiresOnboarding == requiresOnboarding));
  }

  @override
  int get hashCode => Object.hash(runtimeType, requiresOnboarding);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticatedStateImplCopyWith<_$AuthenticatedStateImpl> get copyWith =>
      __$$AuthenticatedStateImplCopyWithImpl<_$AuthenticatedStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() notAuthenticated,
    required TResult Function(User user) partialSignUp,
    required TResult Function(bool requiresOnboarding) authenticated,
  }) {
    return authenticated(requiresOnboarding);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? notAuthenticated,
    TResult? Function(User user)? partialSignUp,
    TResult? Function(bool requiresOnboarding)? authenticated,
  }) {
    return authenticated?.call(requiresOnboarding);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? notAuthenticated,
    TResult Function(User user)? partialSignUp,
    TResult Function(bool requiresOnboarding)? authenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(requiresOnboarding);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingAuthenticationState value) loading,
    required TResult Function(NotAuthenticatedState value) notAuthenticated,
    required TResult Function(PartialSigningUpState value) partialSignUp,
    required TResult Function(AuthenticatedState value) authenticated,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingAuthenticationState value)? loading,
    TResult? Function(NotAuthenticatedState value)? notAuthenticated,
    TResult? Function(PartialSigningUpState value)? partialSignUp,
    TResult? Function(AuthenticatedState value)? authenticated,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingAuthenticationState value)? loading,
    TResult Function(NotAuthenticatedState value)? notAuthenticated,
    TResult Function(PartialSigningUpState value)? partialSignUp,
    TResult Function(AuthenticatedState value)? authenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class AuthenticatedState implements AuthenticationState {
  const factory AuthenticatedState({required final bool requiresOnboarding}) =
      _$AuthenticatedStateImpl;

  bool get requiresOnboarding;

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticatedStateImplCopyWith<_$AuthenticatedStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
