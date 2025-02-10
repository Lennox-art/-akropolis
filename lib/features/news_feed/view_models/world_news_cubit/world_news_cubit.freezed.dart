// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'world_news_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WorldNewsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(ToastMessage? toast) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(ToastMessage? toast)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(ToastMessage? toast)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingWorldNewsState value) loading,
    required TResult Function(LoadedWorldNewsState value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingWorldNewsState value)? loading,
    TResult? Function(LoadedWorldNewsState value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingWorldNewsState value)? loading,
    TResult Function(LoadedWorldNewsState value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorldNewsStateCopyWith<$Res> {
  factory $WorldNewsStateCopyWith(
          WorldNewsState value, $Res Function(WorldNewsState) then) =
      _$WorldNewsStateCopyWithImpl<$Res, WorldNewsState>;
}

/// @nodoc
class _$WorldNewsStateCopyWithImpl<$Res, $Val extends WorldNewsState>
    implements $WorldNewsStateCopyWith<$Res> {
  _$WorldNewsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorldNewsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadingWorldNewsStateImplCopyWith<$Res> {
  factory _$$LoadingWorldNewsStateImplCopyWith(
          _$LoadingWorldNewsStateImpl value,
          $Res Function(_$LoadingWorldNewsStateImpl) then) =
      __$$LoadingWorldNewsStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingWorldNewsStateImplCopyWithImpl<$Res>
    extends _$WorldNewsStateCopyWithImpl<$Res, _$LoadingWorldNewsStateImpl>
    implements _$$LoadingWorldNewsStateImplCopyWith<$Res> {
  __$$LoadingWorldNewsStateImplCopyWithImpl(_$LoadingWorldNewsStateImpl _value,
      $Res Function(_$LoadingWorldNewsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorldNewsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingWorldNewsStateImpl implements LoadingWorldNewsState {
  const _$LoadingWorldNewsStateImpl();

  @override
  String toString() {
    return 'WorldNewsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingWorldNewsStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(ToastMessage? toast) loaded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(ToastMessage? toast)? loaded,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(ToastMessage? toast)? loaded,
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
    required TResult Function(LoadingWorldNewsState value) loading,
    required TResult Function(LoadedWorldNewsState value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingWorldNewsState value)? loading,
    TResult? Function(LoadedWorldNewsState value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingWorldNewsState value)? loading,
    TResult Function(LoadedWorldNewsState value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LoadingWorldNewsState implements WorldNewsState {
  const factory LoadingWorldNewsState() = _$LoadingWorldNewsStateImpl;
}

/// @nodoc
abstract class _$$LoadedWorldNewsStateImplCopyWith<$Res> {
  factory _$$LoadedWorldNewsStateImplCopyWith(_$LoadedWorldNewsStateImpl value,
          $Res Function(_$LoadedWorldNewsStateImpl) then) =
      __$$LoadedWorldNewsStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ToastMessage? toast});

  $ToastMessageCopyWith<$Res>? get toast;
}

/// @nodoc
class __$$LoadedWorldNewsStateImplCopyWithImpl<$Res>
    extends _$WorldNewsStateCopyWithImpl<$Res, _$LoadedWorldNewsStateImpl>
    implements _$$LoadedWorldNewsStateImplCopyWith<$Res> {
  __$$LoadedWorldNewsStateImplCopyWithImpl(_$LoadedWorldNewsStateImpl _value,
      $Res Function(_$LoadedWorldNewsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorldNewsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? toast = freezed,
  }) {
    return _then(_$LoadedWorldNewsStateImpl(
      toast: freezed == toast
          ? _value.toast
          : toast // ignore: cast_nullable_to_non_nullable
              as ToastMessage?,
    ));
  }

  /// Create a copy of WorldNewsState
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

class _$LoadedWorldNewsStateImpl implements LoadedWorldNewsState {
  const _$LoadedWorldNewsStateImpl({this.toast});

  @override
  final ToastMessage? toast;

  @override
  String toString() {
    return 'WorldNewsState.loaded(toast: $toast)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedWorldNewsStateImpl &&
            (identical(other.toast, toast) || other.toast == toast));
  }

  @override
  int get hashCode => Object.hash(runtimeType, toast);

  /// Create a copy of WorldNewsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedWorldNewsStateImplCopyWith<_$LoadedWorldNewsStateImpl>
      get copyWith =>
          __$$LoadedWorldNewsStateImplCopyWithImpl<_$LoadedWorldNewsStateImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(ToastMessage? toast) loaded,
  }) {
    return loaded(toast);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(ToastMessage? toast)? loaded,
  }) {
    return loaded?.call(toast);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(ToastMessage? toast)? loaded,
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
    required TResult Function(LoadingWorldNewsState value) loading,
    required TResult Function(LoadedWorldNewsState value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingWorldNewsState value)? loading,
    TResult? Function(LoadedWorldNewsState value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingWorldNewsState value)? loading,
    TResult Function(LoadedWorldNewsState value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class LoadedWorldNewsState implements WorldNewsState {
  const factory LoadedWorldNewsState({final ToastMessage? toast}) =
      _$LoadedWorldNewsStateImpl;

  ToastMessage? get toast;

  /// Create a copy of WorldNewsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedWorldNewsStateImplCopyWith<_$LoadedWorldNewsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
