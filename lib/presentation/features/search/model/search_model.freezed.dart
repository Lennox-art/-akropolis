// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(bool showNotFound) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(bool showNotFound)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(bool showNotFound)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingSearchState value) loading,
    required TResult Function(LoadedSearchState value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingSearchState value)? loading,
    TResult? Function(LoadedSearchState value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingSearchState value)? loading,
    TResult Function(LoadedSearchState value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchStateCopyWith<$Res> {
  factory $SearchStateCopyWith(
          SearchState value, $Res Function(SearchState) then) =
      _$SearchStateCopyWithImpl<$Res, SearchState>;
}

/// @nodoc
class _$SearchStateCopyWithImpl<$Res, $Val extends SearchState>
    implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadingSearchStateImplCopyWith<$Res> {
  factory _$$LoadingSearchStateImplCopyWith(_$LoadingSearchStateImpl value,
          $Res Function(_$LoadingSearchStateImpl) then) =
      __$$LoadingSearchStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingSearchStateImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$LoadingSearchStateImpl>
    implements _$$LoadingSearchStateImplCopyWith<$Res> {
  __$$LoadingSearchStateImplCopyWithImpl(_$LoadingSearchStateImpl _value,
      $Res Function(_$LoadingSearchStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingSearchStateImpl implements LoadingSearchState {
  const _$LoadingSearchStateImpl();

  @override
  String toString() {
    return 'SearchState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingSearchStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(bool showNotFound) loaded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(bool showNotFound)? loaded,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(bool showNotFound)? loaded,
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
    required TResult Function(LoadingSearchState value) loading,
    required TResult Function(LoadedSearchState value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingSearchState value)? loading,
    TResult? Function(LoadedSearchState value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingSearchState value)? loading,
    TResult Function(LoadedSearchState value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LoadingSearchState implements SearchState {
  const factory LoadingSearchState() = _$LoadingSearchStateImpl;
}

/// @nodoc
abstract class _$$LoadedSearchStateImplCopyWith<$Res> {
  factory _$$LoadedSearchStateImplCopyWith(_$LoadedSearchStateImpl value,
          $Res Function(_$LoadedSearchStateImpl) then) =
      __$$LoadedSearchStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool showNotFound});
}

/// @nodoc
class __$$LoadedSearchStateImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$LoadedSearchStateImpl>
    implements _$$LoadedSearchStateImplCopyWith<$Res> {
  __$$LoadedSearchStateImplCopyWithImpl(_$LoadedSearchStateImpl _value,
      $Res Function(_$LoadedSearchStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showNotFound = null,
  }) {
    return _then(_$LoadedSearchStateImpl(
      showNotFound: null == showNotFound
          ? _value.showNotFound
          : showNotFound // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$LoadedSearchStateImpl implements LoadedSearchState {
  const _$LoadedSearchStateImpl({this.showNotFound = false});

  @override
  @JsonKey()
  final bool showNotFound;

  @override
  String toString() {
    return 'SearchState.loaded(showNotFound: $showNotFound)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedSearchStateImpl &&
            (identical(other.showNotFound, showNotFound) ||
                other.showNotFound == showNotFound));
  }

  @override
  int get hashCode => Object.hash(runtimeType, showNotFound);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedSearchStateImplCopyWith<_$LoadedSearchStateImpl> get copyWith =>
      __$$LoadedSearchStateImplCopyWithImpl<_$LoadedSearchStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(bool showNotFound) loaded,
  }) {
    return loaded(showNotFound);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(bool showNotFound)? loaded,
  }) {
    return loaded?.call(showNotFound);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(bool showNotFound)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(showNotFound);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingSearchState value) loading,
    required TResult Function(LoadedSearchState value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingSearchState value)? loading,
    TResult? Function(LoadedSearchState value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingSearchState value)? loading,
    TResult Function(LoadedSearchState value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class LoadedSearchState implements SearchState {
  const factory LoadedSearchState({final bool showNotFound}) =
      _$LoadedSearchStateImpl;

  bool get showNotFound;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedSearchStateImplCopyWith<_$LoadedSearchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
