// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'headlines_news_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HeadlinesNewsState {
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
    required TResult Function(HeadlinesNewsStateLoadedState value) loaded,
    required TResult Function(HeadlinesNewsStateLoadingState value) loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HeadlinesNewsStateLoadedState value)? loaded,
    TResult? Function(HeadlinesNewsStateLoadingState value)? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HeadlinesNewsStateLoadedState value)? loaded,
    TResult Function(HeadlinesNewsStateLoadingState value)? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HeadlinesNewsStateCopyWith<$Res> {
  factory $HeadlinesNewsStateCopyWith(
          HeadlinesNewsState value, $Res Function(HeadlinesNewsState) then) =
      _$HeadlinesNewsStateCopyWithImpl<$Res, HeadlinesNewsState>;
}

/// @nodoc
class _$HeadlinesNewsStateCopyWithImpl<$Res, $Val extends HeadlinesNewsState>
    implements $HeadlinesNewsStateCopyWith<$Res> {
  _$HeadlinesNewsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HeadlinesNewsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$HeadlinesNewsStateLoadedStateImplCopyWith<$Res> {
  factory _$$HeadlinesNewsStateLoadedStateImplCopyWith(
          _$HeadlinesNewsStateLoadedStateImpl value,
          $Res Function(_$HeadlinesNewsStateLoadedStateImpl) then) =
      __$$HeadlinesNewsStateLoadedStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ToastMessage? toast});

  $ToastMessageCopyWith<$Res>? get toast;
}

/// @nodoc
class __$$HeadlinesNewsStateLoadedStateImplCopyWithImpl<$Res>
    extends _$HeadlinesNewsStateCopyWithImpl<$Res,
        _$HeadlinesNewsStateLoadedStateImpl>
    implements _$$HeadlinesNewsStateLoadedStateImplCopyWith<$Res> {
  __$$HeadlinesNewsStateLoadedStateImplCopyWithImpl(
      _$HeadlinesNewsStateLoadedStateImpl _value,
      $Res Function(_$HeadlinesNewsStateLoadedStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HeadlinesNewsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? toast = freezed,
  }) {
    return _then(_$HeadlinesNewsStateLoadedStateImpl(
      toast: freezed == toast
          ? _value.toast
          : toast // ignore: cast_nullable_to_non_nullable
              as ToastMessage?,
    ));
  }

  /// Create a copy of HeadlinesNewsState
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

class _$HeadlinesNewsStateLoadedStateImpl
    implements HeadlinesNewsStateLoadedState {
  const _$HeadlinesNewsStateLoadedStateImpl({this.toast});

  @override
  final ToastMessage? toast;

  @override
  String toString() {
    return 'HeadlinesNewsState.loaded(toast: $toast)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HeadlinesNewsStateLoadedStateImpl &&
            (identical(other.toast, toast) || other.toast == toast));
  }

  @override
  int get hashCode => Object.hash(runtimeType, toast);

  /// Create a copy of HeadlinesNewsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HeadlinesNewsStateLoadedStateImplCopyWith<
          _$HeadlinesNewsStateLoadedStateImpl>
      get copyWith => __$$HeadlinesNewsStateLoadedStateImplCopyWithImpl<
          _$HeadlinesNewsStateLoadedStateImpl>(this, _$identity);

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
    required TResult Function(HeadlinesNewsStateLoadedState value) loaded,
    required TResult Function(HeadlinesNewsStateLoadingState value) loading,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HeadlinesNewsStateLoadedState value)? loaded,
    TResult? Function(HeadlinesNewsStateLoadingState value)? loading,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HeadlinesNewsStateLoadedState value)? loaded,
    TResult Function(HeadlinesNewsStateLoadingState value)? loading,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class HeadlinesNewsStateLoadedState implements HeadlinesNewsState {
  const factory HeadlinesNewsStateLoadedState({final ToastMessage? toast}) =
      _$HeadlinesNewsStateLoadedStateImpl;

  ToastMessage? get toast;

  /// Create a copy of HeadlinesNewsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HeadlinesNewsStateLoadedStateImplCopyWith<
          _$HeadlinesNewsStateLoadedStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HeadlinesNewsStateLoadingStateImplCopyWith<$Res> {
  factory _$$HeadlinesNewsStateLoadingStateImplCopyWith(
          _$HeadlinesNewsStateLoadingStateImpl value,
          $Res Function(_$HeadlinesNewsStateLoadingStateImpl) then) =
      __$$HeadlinesNewsStateLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HeadlinesNewsStateLoadingStateImplCopyWithImpl<$Res>
    extends _$HeadlinesNewsStateCopyWithImpl<$Res,
        _$HeadlinesNewsStateLoadingStateImpl>
    implements _$$HeadlinesNewsStateLoadingStateImplCopyWith<$Res> {
  __$$HeadlinesNewsStateLoadingStateImplCopyWithImpl(
      _$HeadlinesNewsStateLoadingStateImpl _value,
      $Res Function(_$HeadlinesNewsStateLoadingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HeadlinesNewsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$HeadlinesNewsStateLoadingStateImpl
    implements HeadlinesNewsStateLoadingState {
  const _$HeadlinesNewsStateLoadingStateImpl();

  @override
  String toString() {
    return 'HeadlinesNewsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HeadlinesNewsStateLoadingStateImpl);
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
    required TResult Function(HeadlinesNewsStateLoadedState value) loaded,
    required TResult Function(HeadlinesNewsStateLoadingState value) loading,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HeadlinesNewsStateLoadedState value)? loaded,
    TResult? Function(HeadlinesNewsStateLoadingState value)? loading,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HeadlinesNewsStateLoadedState value)? loaded,
    TResult Function(HeadlinesNewsStateLoadingState value)? loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class HeadlinesNewsStateLoadingState implements HeadlinesNewsState {
  const factory HeadlinesNewsStateLoadingState() =
      _$HeadlinesNewsStateLoadingStateImpl;
}
