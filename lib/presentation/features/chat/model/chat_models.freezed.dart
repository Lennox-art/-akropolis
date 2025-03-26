// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChatState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() requested,
    required TResult Function() declined,
    required TResult Function() loaded,
    required TResult Function() loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? requested,
    TResult? Function()? declined,
    TResult? Function()? loaded,
    TResult? Function()? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? requested,
    TResult Function()? declined,
    TResult Function()? loaded,
    TResult Function()? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatInitialState value) initial,
    required TResult Function(ChatRequestedState value) requested,
    required TResult Function(ChatDeclinedState value) declined,
    required TResult Function(ChatLoadedState value) loaded,
    required TResult Function(ChatLoadingState value) loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatInitialState value)? initial,
    TResult? Function(ChatRequestedState value)? requested,
    TResult? Function(ChatDeclinedState value)? declined,
    TResult? Function(ChatLoadedState value)? loaded,
    TResult? Function(ChatLoadingState value)? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatInitialState value)? initial,
    TResult Function(ChatRequestedState value)? requested,
    TResult Function(ChatDeclinedState value)? declined,
    TResult Function(ChatLoadedState value)? loaded,
    TResult Function(ChatLoadingState value)? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatStateCopyWith<$Res> {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) then) =
      _$ChatStateCopyWithImpl<$Res, ChatState>;
}

/// @nodoc
class _$ChatStateCopyWithImpl<$Res, $Val extends ChatState>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ChatInitialStateImplCopyWith<$Res> {
  factory _$$ChatInitialStateImplCopyWith(_$ChatInitialStateImpl value,
          $Res Function(_$ChatInitialStateImpl) then) =
      __$$ChatInitialStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChatInitialStateImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatInitialStateImpl>
    implements _$$ChatInitialStateImplCopyWith<$Res> {
  __$$ChatInitialStateImplCopyWithImpl(_$ChatInitialStateImpl _value,
      $Res Function(_$ChatInitialStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ChatInitialStateImpl implements ChatInitialState {
  const _$ChatInitialStateImpl();

  @override
  String toString() {
    return 'ChatState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ChatInitialStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() requested,
    required TResult Function() declined,
    required TResult Function() loaded,
    required TResult Function() loading,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? requested,
    TResult? Function()? declined,
    TResult? Function()? loaded,
    TResult? Function()? loading,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? requested,
    TResult Function()? declined,
    TResult Function()? loaded,
    TResult Function()? loading,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatInitialState value) initial,
    required TResult Function(ChatRequestedState value) requested,
    required TResult Function(ChatDeclinedState value) declined,
    required TResult Function(ChatLoadedState value) loaded,
    required TResult Function(ChatLoadingState value) loading,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatInitialState value)? initial,
    TResult? Function(ChatRequestedState value)? requested,
    TResult? Function(ChatDeclinedState value)? declined,
    TResult? Function(ChatLoadedState value)? loaded,
    TResult? Function(ChatLoadingState value)? loading,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatInitialState value)? initial,
    TResult Function(ChatRequestedState value)? requested,
    TResult Function(ChatDeclinedState value)? declined,
    TResult Function(ChatLoadedState value)? loaded,
    TResult Function(ChatLoadingState value)? loading,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ChatInitialState implements ChatState {
  const factory ChatInitialState() = _$ChatInitialStateImpl;
}

/// @nodoc
abstract class _$$ChatRequestedStateImplCopyWith<$Res> {
  factory _$$ChatRequestedStateImplCopyWith(_$ChatRequestedStateImpl value,
          $Res Function(_$ChatRequestedStateImpl) then) =
      __$$ChatRequestedStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChatRequestedStateImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatRequestedStateImpl>
    implements _$$ChatRequestedStateImplCopyWith<$Res> {
  __$$ChatRequestedStateImplCopyWithImpl(_$ChatRequestedStateImpl _value,
      $Res Function(_$ChatRequestedStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ChatRequestedStateImpl implements ChatRequestedState {
  const _$ChatRequestedStateImpl();

  @override
  String toString() {
    return 'ChatState.requested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ChatRequestedStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() requested,
    required TResult Function() declined,
    required TResult Function() loaded,
    required TResult Function() loading,
  }) {
    return requested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? requested,
    TResult? Function()? declined,
    TResult? Function()? loaded,
    TResult? Function()? loading,
  }) {
    return requested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? requested,
    TResult Function()? declined,
    TResult Function()? loaded,
    TResult Function()? loading,
    required TResult orElse(),
  }) {
    if (requested != null) {
      return requested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatInitialState value) initial,
    required TResult Function(ChatRequestedState value) requested,
    required TResult Function(ChatDeclinedState value) declined,
    required TResult Function(ChatLoadedState value) loaded,
    required TResult Function(ChatLoadingState value) loading,
  }) {
    return requested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatInitialState value)? initial,
    TResult? Function(ChatRequestedState value)? requested,
    TResult? Function(ChatDeclinedState value)? declined,
    TResult? Function(ChatLoadedState value)? loaded,
    TResult? Function(ChatLoadingState value)? loading,
  }) {
    return requested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatInitialState value)? initial,
    TResult Function(ChatRequestedState value)? requested,
    TResult Function(ChatDeclinedState value)? declined,
    TResult Function(ChatLoadedState value)? loaded,
    TResult Function(ChatLoadingState value)? loading,
    required TResult orElse(),
  }) {
    if (requested != null) {
      return requested(this);
    }
    return orElse();
  }
}

abstract class ChatRequestedState implements ChatState {
  const factory ChatRequestedState() = _$ChatRequestedStateImpl;
}

/// @nodoc
abstract class _$$ChatDeclinedStateImplCopyWith<$Res> {
  factory _$$ChatDeclinedStateImplCopyWith(_$ChatDeclinedStateImpl value,
          $Res Function(_$ChatDeclinedStateImpl) then) =
      __$$ChatDeclinedStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChatDeclinedStateImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatDeclinedStateImpl>
    implements _$$ChatDeclinedStateImplCopyWith<$Res> {
  __$$ChatDeclinedStateImplCopyWithImpl(_$ChatDeclinedStateImpl _value,
      $Res Function(_$ChatDeclinedStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ChatDeclinedStateImpl implements ChatDeclinedState {
  const _$ChatDeclinedStateImpl();

  @override
  String toString() {
    return 'ChatState.declined()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ChatDeclinedStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() requested,
    required TResult Function() declined,
    required TResult Function() loaded,
    required TResult Function() loading,
  }) {
    return declined();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? requested,
    TResult? Function()? declined,
    TResult? Function()? loaded,
    TResult? Function()? loading,
  }) {
    return declined?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? requested,
    TResult Function()? declined,
    TResult Function()? loaded,
    TResult Function()? loading,
    required TResult orElse(),
  }) {
    if (declined != null) {
      return declined();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatInitialState value) initial,
    required TResult Function(ChatRequestedState value) requested,
    required TResult Function(ChatDeclinedState value) declined,
    required TResult Function(ChatLoadedState value) loaded,
    required TResult Function(ChatLoadingState value) loading,
  }) {
    return declined(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatInitialState value)? initial,
    TResult? Function(ChatRequestedState value)? requested,
    TResult? Function(ChatDeclinedState value)? declined,
    TResult? Function(ChatLoadedState value)? loaded,
    TResult? Function(ChatLoadingState value)? loading,
  }) {
    return declined?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatInitialState value)? initial,
    TResult Function(ChatRequestedState value)? requested,
    TResult Function(ChatDeclinedState value)? declined,
    TResult Function(ChatLoadedState value)? loaded,
    TResult Function(ChatLoadingState value)? loading,
    required TResult orElse(),
  }) {
    if (declined != null) {
      return declined(this);
    }
    return orElse();
  }
}

abstract class ChatDeclinedState implements ChatState {
  const factory ChatDeclinedState() = _$ChatDeclinedStateImpl;
}

/// @nodoc
abstract class _$$ChatLoadedStateImplCopyWith<$Res> {
  factory _$$ChatLoadedStateImplCopyWith(_$ChatLoadedStateImpl value,
          $Res Function(_$ChatLoadedStateImpl) then) =
      __$$ChatLoadedStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChatLoadedStateImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatLoadedStateImpl>
    implements _$$ChatLoadedStateImplCopyWith<$Res> {
  __$$ChatLoadedStateImplCopyWithImpl(
      _$ChatLoadedStateImpl _value, $Res Function(_$ChatLoadedStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ChatLoadedStateImpl implements ChatLoadedState {
  const _$ChatLoadedStateImpl();

  @override
  String toString() {
    return 'ChatState.loaded()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ChatLoadedStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() requested,
    required TResult Function() declined,
    required TResult Function() loaded,
    required TResult Function() loading,
  }) {
    return loaded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? requested,
    TResult? Function()? declined,
    TResult? Function()? loaded,
    TResult? Function()? loading,
  }) {
    return loaded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? requested,
    TResult Function()? declined,
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
    required TResult Function(ChatInitialState value) initial,
    required TResult Function(ChatRequestedState value) requested,
    required TResult Function(ChatDeclinedState value) declined,
    required TResult Function(ChatLoadedState value) loaded,
    required TResult Function(ChatLoadingState value) loading,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatInitialState value)? initial,
    TResult? Function(ChatRequestedState value)? requested,
    TResult? Function(ChatDeclinedState value)? declined,
    TResult? Function(ChatLoadedState value)? loaded,
    TResult? Function(ChatLoadingState value)? loading,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatInitialState value)? initial,
    TResult Function(ChatRequestedState value)? requested,
    TResult Function(ChatDeclinedState value)? declined,
    TResult Function(ChatLoadedState value)? loaded,
    TResult Function(ChatLoadingState value)? loading,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ChatLoadedState implements ChatState {
  const factory ChatLoadedState() = _$ChatLoadedStateImpl;
}

/// @nodoc
abstract class _$$ChatLoadingStateImplCopyWith<$Res> {
  factory _$$ChatLoadingStateImplCopyWith(_$ChatLoadingStateImpl value,
          $Res Function(_$ChatLoadingStateImpl) then) =
      __$$ChatLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChatLoadingStateImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatLoadingStateImpl>
    implements _$$ChatLoadingStateImplCopyWith<$Res> {
  __$$ChatLoadingStateImplCopyWithImpl(_$ChatLoadingStateImpl _value,
      $Res Function(_$ChatLoadingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ChatLoadingStateImpl implements ChatLoadingState {
  const _$ChatLoadingStateImpl();

  @override
  String toString() {
    return 'ChatState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ChatLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() requested,
    required TResult Function() declined,
    required TResult Function() loaded,
    required TResult Function() loading,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? requested,
    TResult? Function()? declined,
    TResult? Function()? loaded,
    TResult? Function()? loading,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? requested,
    TResult Function()? declined,
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
    required TResult Function(ChatInitialState value) initial,
    required TResult Function(ChatRequestedState value) requested,
    required TResult Function(ChatDeclinedState value) declined,
    required TResult Function(ChatLoadedState value) loaded,
    required TResult Function(ChatLoadingState value) loading,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatInitialState value)? initial,
    TResult? Function(ChatRequestedState value)? requested,
    TResult? Function(ChatDeclinedState value)? declined,
    TResult? Function(ChatLoadedState value)? loaded,
    TResult? Function(ChatLoadingState value)? loading,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatInitialState value)? initial,
    TResult Function(ChatRequestedState value)? requested,
    TResult Function(ChatDeclinedState value)? declined,
    TResult Function(ChatLoadedState value)? loaded,
    TResult Function(ChatLoadingState value)? loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ChatLoadingState implements ChatState {
  const factory ChatLoadingState() = _$ChatLoadingStateImpl;
}
