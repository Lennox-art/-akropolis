// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'thread_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ThreadsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loaded,
    required TResult Function() loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loaded,
    TResult? Function()? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function()? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ThreadsLoadedState value) loaded,
    required TResult Function(ThreadsLoadingState value) loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ThreadsLoadedState value)? loaded,
    TResult? Function(ThreadsLoadingState value)? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ThreadsLoadedState value)? loaded,
    TResult Function(ThreadsLoadingState value)? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThreadsStateCopyWith<$Res> {
  factory $ThreadsStateCopyWith(
          ThreadsState value, $Res Function(ThreadsState) then) =
      _$ThreadsStateCopyWithImpl<$Res, ThreadsState>;
}

/// @nodoc
class _$ThreadsStateCopyWithImpl<$Res, $Val extends ThreadsState>
    implements $ThreadsStateCopyWith<$Res> {
  _$ThreadsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ThreadsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ThreadsLoadedStateImplCopyWith<$Res> {
  factory _$$ThreadsLoadedStateImplCopyWith(_$ThreadsLoadedStateImpl value,
          $Res Function(_$ThreadsLoadedStateImpl) then) =
      __$$ThreadsLoadedStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ThreadsLoadedStateImplCopyWithImpl<$Res>
    extends _$ThreadsStateCopyWithImpl<$Res, _$ThreadsLoadedStateImpl>
    implements _$$ThreadsLoadedStateImplCopyWith<$Res> {
  __$$ThreadsLoadedStateImplCopyWithImpl(_$ThreadsLoadedStateImpl _value,
      $Res Function(_$ThreadsLoadedStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ThreadsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ThreadsLoadedStateImpl implements ThreadsLoadedState {
  const _$ThreadsLoadedStateImpl();

  @override
  String toString() {
    return 'ThreadsState.loaded()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ThreadsLoadedStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loaded,
    required TResult Function() loading,
  }) {
    return loaded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loaded,
    TResult? Function()? loading,
  }) {
    return loaded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function()? loading,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ThreadsLoadedState value) loaded,
    required TResult Function(ThreadsLoadingState value) loading,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ThreadsLoadedState value)? loaded,
    TResult? Function(ThreadsLoadingState value)? loading,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ThreadsLoadedState value)? loaded,
    TResult Function(ThreadsLoadingState value)? loading,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ThreadsLoadedState implements ThreadsState {
  const factory ThreadsLoadedState() = _$ThreadsLoadedStateImpl;
}

/// @nodoc
abstract class _$$ThreadsLoadingStateImplCopyWith<$Res> {
  factory _$$ThreadsLoadingStateImplCopyWith(_$ThreadsLoadingStateImpl value,
          $Res Function(_$ThreadsLoadingStateImpl) then) =
      __$$ThreadsLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ThreadsLoadingStateImplCopyWithImpl<$Res>
    extends _$ThreadsStateCopyWithImpl<$Res, _$ThreadsLoadingStateImpl>
    implements _$$ThreadsLoadingStateImplCopyWith<$Res> {
  __$$ThreadsLoadingStateImplCopyWithImpl(_$ThreadsLoadingStateImpl _value,
      $Res Function(_$ThreadsLoadingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ThreadsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ThreadsLoadingStateImpl implements ThreadsLoadingState {
  const _$ThreadsLoadingStateImpl();

  @override
  String toString() {
    return 'ThreadsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThreadsLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loaded,
    required TResult Function() loading,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loaded,
    TResult? Function()? loading,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loaded,
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
    required TResult Function(ThreadsLoadedState value) loaded,
    required TResult Function(ThreadsLoadingState value) loading,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ThreadsLoadedState value)? loaded,
    TResult? Function(ThreadsLoadingState value)? loading,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ThreadsLoadedState value)? loaded,
    TResult Function(ThreadsLoadingState value)? loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ThreadsLoadingState implements ThreadsState {
  const factory ThreadsLoadingState() = _$ThreadsLoadingStateImpl;
}
