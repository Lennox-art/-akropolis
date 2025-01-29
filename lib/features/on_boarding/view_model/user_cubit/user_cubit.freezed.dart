// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ToastMessage? toast) loaded,
    required TResult Function() loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ToastMessage? toast)? loaded,
    TResult? Function()? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ToastMessage? toast)? loaded,
    TResult Function()? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadedUserState value) loaded,
    required TResult Function(LoadingUserState value) loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadedUserState value)? loaded,
    TResult? Function(LoadingUserState value)? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadedUserState value)? loaded,
    TResult Function(LoadingUserState value)? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStateCopyWith<$Res> {
  factory $UserStateCopyWith(UserState value, $Res Function(UserState) then) =
      _$UserStateCopyWithImpl<$Res, UserState>;
}

/// @nodoc
class _$UserStateCopyWithImpl<$Res, $Val extends UserState>
    implements $UserStateCopyWith<$Res> {
  _$UserStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadedUserStateImplCopyWith<$Res> {
  factory _$$LoadedUserStateImplCopyWith(_$LoadedUserStateImpl value,
          $Res Function(_$LoadedUserStateImpl) then) =
      __$$LoadedUserStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ToastMessage? toast});

  $ToastMessageCopyWith<$Res>? get toast;
}

/// @nodoc
class __$$LoadedUserStateImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$LoadedUserStateImpl>
    implements _$$LoadedUserStateImplCopyWith<$Res> {
  __$$LoadedUserStateImplCopyWithImpl(
      _$LoadedUserStateImpl _value, $Res Function(_$LoadedUserStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? toast = freezed,
  }) {
    return _then(_$LoadedUserStateImpl(
      toast: freezed == toast
          ? _value.toast
          : toast // ignore: cast_nullable_to_non_nullable
              as ToastMessage?,
    ));
  }

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ToastMessageCopyWith<$Res>? get toast {
    if (_value.toast == null) {
      return null;
    }

    return $ToastMessageCopyWith<$Res>(_value.toast!, (value) {
      return _then(_value.copyWith(toast: value));
    });
  }
}

/// @nodoc

class _$LoadedUserStateImpl
    with DiagnosticableTreeMixin
    implements LoadedUserState {
  const _$LoadedUserStateImpl({this.toast});

  @override
  final ToastMessage? toast;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserState.loaded(toast: $toast)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserState.loaded'))
      ..add(DiagnosticsProperty('toast', toast));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedUserStateImpl &&
            (identical(other.toast, toast) || other.toast == toast));
  }

  @override
  int get hashCode => Object.hash(runtimeType, toast);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedUserStateImplCopyWith<_$LoadedUserStateImpl> get copyWith =>
      __$$LoadedUserStateImplCopyWithImpl<_$LoadedUserStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ToastMessage? toast) loaded,
    required TResult Function() loading,
  }) {
    return loaded(toast);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ToastMessage? toast)? loaded,
    TResult? Function()? loading,
  }) {
    return loaded?.call(toast);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ToastMessage? toast)? loaded,
    TResult Function()? loading,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(toast);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadedUserState value) loaded,
    required TResult Function(LoadingUserState value) loading,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadedUserState value)? loaded,
    TResult? Function(LoadingUserState value)? loading,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadedUserState value)? loaded,
    TResult Function(LoadingUserState value)? loading,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class LoadedUserState implements UserState {
  const factory LoadedUserState({final ToastMessage? toast}) =
      _$LoadedUserStateImpl;

  ToastMessage? get toast;

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedUserStateImplCopyWith<_$LoadedUserStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingUserStateImplCopyWith<$Res> {
  factory _$$LoadingUserStateImplCopyWith(_$LoadingUserStateImpl value,
          $Res Function(_$LoadingUserStateImpl) then) =
      __$$LoadingUserStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingUserStateImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$LoadingUserStateImpl>
    implements _$$LoadingUserStateImplCopyWith<$Res> {
  __$$LoadingUserStateImplCopyWithImpl(_$LoadingUserStateImpl _value,
      $Res Function(_$LoadingUserStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingUserStateImpl
    with DiagnosticableTreeMixin
    implements LoadingUserState {
  const _$LoadingUserStateImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'UserState.loading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingUserStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ToastMessage? toast) loaded,
    required TResult Function() loading,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ToastMessage? toast)? loaded,
    TResult? Function()? loading,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ToastMessage? toast)? loaded,
    TResult Function()? loading,
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
    required TResult Function(LoadedUserState value) loaded,
    required TResult Function(LoadingUserState value) loading,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadedUserState value)? loaded,
    TResult? Function(LoadingUserState value)? loading,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadedUserState value)? loaded,
    TResult Function(LoadingUserState value)? loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LoadingUserState implements UserState {
  const factory LoadingUserState() = _$LoadingUserStateImpl;
}
