// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_post_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DurationTrim {
  Duration get duration => throw _privateConstructorUsedError;
  double get start => throw _privateConstructorUsedError;
  double get end => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Duration duration, double start, double end)
        create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Duration duration, double start, double end)? create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Duration duration, double start, double end)? create,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DurationTrim value) create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DurationTrim value)? create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DurationTrim value)? create,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of DurationTrim
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DurationTrimCopyWith<DurationTrim> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DurationTrimCopyWith<$Res> {
  factory $DurationTrimCopyWith(
          DurationTrim value, $Res Function(DurationTrim) then) =
      _$DurationTrimCopyWithImpl<$Res, DurationTrim>;
  @useResult
  $Res call({Duration duration, double start, double end});
}

/// @nodoc
class _$DurationTrimCopyWithImpl<$Res, $Val extends DurationTrim>
    implements $DurationTrimCopyWith<$Res> {
  _$DurationTrimCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DurationTrim
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? duration = null,
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_value.copyWith(
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as double,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DurationTrimImplCopyWith<$Res>
    implements $DurationTrimCopyWith<$Res> {
  factory _$$DurationTrimImplCopyWith(
          _$DurationTrimImpl value, $Res Function(_$DurationTrimImpl) then) =
      __$$DurationTrimImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Duration duration, double start, double end});
}

/// @nodoc
class __$$DurationTrimImplCopyWithImpl<$Res>
    extends _$DurationTrimCopyWithImpl<$Res, _$DurationTrimImpl>
    implements _$$DurationTrimImplCopyWith<$Res> {
  __$$DurationTrimImplCopyWithImpl(
      _$DurationTrimImpl _value, $Res Function(_$DurationTrimImpl) _then)
      : super(_value, _then);

  /// Create a copy of DurationTrim
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? duration = null,
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_$DurationTrimImpl(
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as double,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$DurationTrimImpl implements _DurationTrim {
  const _$DurationTrimImpl(
      {required this.duration, this.start = 0.0, this.end = 1.0});

  @override
  final Duration duration;
  @override
  @JsonKey()
  final double start;
  @override
  @JsonKey()
  final double end;

  @override
  String toString() {
    return 'DurationTrim.create(duration: $duration, start: $start, end: $end)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DurationTrimImpl &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @override
  int get hashCode => Object.hash(runtimeType, duration, start, end);

  /// Create a copy of DurationTrim
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DurationTrimImplCopyWith<_$DurationTrimImpl> get copyWith =>
      __$$DurationTrimImplCopyWithImpl<_$DurationTrimImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Duration duration, double start, double end)
        create,
  }) {
    return create(duration, start, end);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Duration duration, double start, double end)? create,
  }) {
    return create?.call(duration, start, end);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Duration duration, double start, double end)? create,
    required TResult orElse(),
  }) {
    if (create != null) {
      return create(duration, start, end);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DurationTrim value) create,
  }) {
    return create(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DurationTrim value)? create,
  }) {
    return create?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DurationTrim value)? create,
    required TResult orElse(),
  }) {
    if (create != null) {
      return create(this);
    }
    return orElse();
  }
}

abstract class _DurationTrim implements DurationTrim {
  const factory _DurationTrim(
      {required final Duration duration,
      final double start,
      final double end}) = _$DurationTrimImpl;

  @override
  Duration get duration;
  @override
  double get start;
  @override
  double get end;

  /// Create a copy of DurationTrim
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DurationTrimImplCopyWith<_$DurationTrimImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CreatePostState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UploadProgress? progress) loading,
    required TResult Function() loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UploadProgress? progress)? loading,
    TResult? Function()? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UploadProgress? progress)? loading,
    TResult Function()? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingCreatePostState value) loading,
    required TResult Function(LoadedCreatePostState value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingCreatePostState value)? loading,
    TResult? Function(LoadedCreatePostState value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingCreatePostState value)? loading,
    TResult Function(LoadedCreatePostState value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePostStateCopyWith<$Res> {
  factory $CreatePostStateCopyWith(
          CreatePostState value, $Res Function(CreatePostState) then) =
      _$CreatePostStateCopyWithImpl<$Res, CreatePostState>;
}

/// @nodoc
class _$CreatePostStateCopyWithImpl<$Res, $Val extends CreatePostState>
    implements $CreatePostStateCopyWith<$Res> {
  _$CreatePostStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreatePostState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadingCreatePostStateImplCopyWith<$Res> {
  factory _$$LoadingCreatePostStateImplCopyWith(
          _$LoadingCreatePostStateImpl value,
          $Res Function(_$LoadingCreatePostStateImpl) then) =
      __$$LoadingCreatePostStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UploadProgress? progress});
}

/// @nodoc
class __$$LoadingCreatePostStateImplCopyWithImpl<$Res>
    extends _$CreatePostStateCopyWithImpl<$Res, _$LoadingCreatePostStateImpl>
    implements _$$LoadingCreatePostStateImplCopyWith<$Res> {
  __$$LoadingCreatePostStateImplCopyWithImpl(
      _$LoadingCreatePostStateImpl _value,
      $Res Function(_$LoadingCreatePostStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreatePostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = freezed,
  }) {
    return _then(_$LoadingCreatePostStateImpl(
      progress: freezed == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as UploadProgress?,
    ));
  }
}

/// @nodoc

class _$LoadingCreatePostStateImpl implements LoadingCreatePostState {
  const _$LoadingCreatePostStateImpl({this.progress});

  @override
  final UploadProgress? progress;

  @override
  String toString() {
    return 'CreatePostState.loading(progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingCreatePostStateImpl &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, progress);

  /// Create a copy of CreatePostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingCreatePostStateImplCopyWith<_$LoadingCreatePostStateImpl>
      get copyWith => __$$LoadingCreatePostStateImplCopyWithImpl<
          _$LoadingCreatePostStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UploadProgress? progress) loading,
    required TResult Function() loaded,
  }) {
    return loading(progress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UploadProgress? progress)? loading,
    TResult? Function()? loaded,
  }) {
    return loading?.call(progress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UploadProgress? progress)? loading,
    TResult Function()? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(progress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingCreatePostState value) loading,
    required TResult Function(LoadedCreatePostState value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingCreatePostState value)? loading,
    TResult? Function(LoadedCreatePostState value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingCreatePostState value)? loading,
    TResult Function(LoadedCreatePostState value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LoadingCreatePostState implements CreatePostState {
  const factory LoadingCreatePostState({final UploadProgress? progress}) =
      _$LoadingCreatePostStateImpl;

  UploadProgress? get progress;

  /// Create a copy of CreatePostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingCreatePostStateImplCopyWith<_$LoadingCreatePostStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedCreatePostStateImplCopyWith<$Res> {
  factory _$$LoadedCreatePostStateImplCopyWith(
          _$LoadedCreatePostStateImpl value,
          $Res Function(_$LoadedCreatePostStateImpl) then) =
      __$$LoadedCreatePostStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadedCreatePostStateImplCopyWithImpl<$Res>
    extends _$CreatePostStateCopyWithImpl<$Res, _$LoadedCreatePostStateImpl>
    implements _$$LoadedCreatePostStateImplCopyWith<$Res> {
  __$$LoadedCreatePostStateImplCopyWithImpl(_$LoadedCreatePostStateImpl _value,
      $Res Function(_$LoadedCreatePostStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreatePostState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadedCreatePostStateImpl implements LoadedCreatePostState {
  const _$LoadedCreatePostStateImpl();

  @override
  String toString() {
    return 'CreatePostState.loaded()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedCreatePostStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UploadProgress? progress) loading,
    required TResult Function() loaded,
  }) {
    return loaded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UploadProgress? progress)? loading,
    TResult? Function()? loaded,
  }) {
    return loaded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UploadProgress? progress)? loading,
    TResult Function()? loaded,
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
    required TResult Function(LoadingCreatePostState value) loading,
    required TResult Function(LoadedCreatePostState value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingCreatePostState value)? loading,
    TResult? Function(LoadedCreatePostState value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingCreatePostState value)? loading,
    TResult Function(LoadedCreatePostState value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class LoadedCreatePostState implements CreatePostState {
  const factory LoadedCreatePostState() = _$LoadedCreatePostStateImpl;
}
