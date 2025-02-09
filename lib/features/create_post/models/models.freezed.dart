// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreatePostForm {
  String get postId => throw _privateConstructorUsedError;
  AppUser get appUser => throw _privateConstructorUsedError;
  File? get videoData => throw _privateConstructorUsedError;
  bool get videoDataUploaded => throw _privateConstructorUsedError;
  Duration? get videoDuration => throw _privateConstructorUsedError;
  Uint8List? get thumbnailData => throw _privateConstructorUsedError;
  bool get thumbnailUploaded => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String postId,
            AppUser appUser,
            File? videoData,
            bool videoDataUploaded,
            Duration? videoDuration,
            Uint8List? thumbnailData,
            bool thumbnailUploaded)
        create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String postId,
            AppUser appUser,
            File? videoData,
            bool videoDataUploaded,
            Duration? videoDuration,
            Uint8List? thumbnailData,
            bool thumbnailUploaded)?
        create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String postId,
            AppUser appUser,
            File? videoData,
            bool videoDataUploaded,
            Duration? videoDuration,
            Uint8List? thumbnailData,
            bool thumbnailUploaded)?
        create,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreatePostForm value) create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreatePostForm value)? create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreatePostForm value)? create,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of CreatePostForm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreatePostFormCopyWith<CreatePostForm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePostFormCopyWith<$Res> {
  factory $CreatePostFormCopyWith(
          CreatePostForm value, $Res Function(CreatePostForm) then) =
      _$CreatePostFormCopyWithImpl<$Res, CreatePostForm>;
  @useResult
  $Res call(
      {String postId,
      AppUser appUser,
      File? videoData,
      bool videoDataUploaded,
      Duration? videoDuration,
      Uint8List? thumbnailData,
      bool thumbnailUploaded});
}

/// @nodoc
class _$CreatePostFormCopyWithImpl<$Res, $Val extends CreatePostForm>
    implements $CreatePostFormCopyWith<$Res> {
  _$CreatePostFormCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreatePostForm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? appUser = null,
    Object? videoData = freezed,
    Object? videoDataUploaded = null,
    Object? videoDuration = freezed,
    Object? thumbnailData = freezed,
    Object? thumbnailUploaded = null,
  }) {
    return _then(_value.copyWith(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      appUser: null == appUser
          ? _value.appUser
          : appUser // ignore: cast_nullable_to_non_nullable
              as AppUser,
      videoData: freezed == videoData
          ? _value.videoData
          : videoData // ignore: cast_nullable_to_non_nullable
              as File?,
      videoDataUploaded: null == videoDataUploaded
          ? _value.videoDataUploaded
          : videoDataUploaded // ignore: cast_nullable_to_non_nullable
              as bool,
      videoDuration: freezed == videoDuration
          ? _value.videoDuration
          : videoDuration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      thumbnailData: freezed == thumbnailData
          ? _value.thumbnailData
          : thumbnailData // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      thumbnailUploaded: null == thumbnailUploaded
          ? _value.thumbnailUploaded
          : thumbnailUploaded // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreatePostFormImplCopyWith<$Res>
    implements $CreatePostFormCopyWith<$Res> {
  factory _$$CreatePostFormImplCopyWith(_$CreatePostFormImpl value,
          $Res Function(_$CreatePostFormImpl) then) =
      __$$CreatePostFormImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String postId,
      AppUser appUser,
      File? videoData,
      bool videoDataUploaded,
      Duration? videoDuration,
      Uint8List? thumbnailData,
      bool thumbnailUploaded});
}

/// @nodoc
class __$$CreatePostFormImplCopyWithImpl<$Res>
    extends _$CreatePostFormCopyWithImpl<$Res, _$CreatePostFormImpl>
    implements _$$CreatePostFormImplCopyWith<$Res> {
  __$$CreatePostFormImplCopyWithImpl(
      _$CreatePostFormImpl _value, $Res Function(_$CreatePostFormImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreatePostForm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? appUser = null,
    Object? videoData = freezed,
    Object? videoDataUploaded = null,
    Object? videoDuration = freezed,
    Object? thumbnailData = freezed,
    Object? thumbnailUploaded = null,
  }) {
    return _then(_$CreatePostFormImpl(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      appUser: null == appUser
          ? _value.appUser
          : appUser // ignore: cast_nullable_to_non_nullable
              as AppUser,
      videoData: freezed == videoData
          ? _value.videoData
          : videoData // ignore: cast_nullable_to_non_nullable
              as File?,
      videoDataUploaded: null == videoDataUploaded
          ? _value.videoDataUploaded
          : videoDataUploaded // ignore: cast_nullable_to_non_nullable
              as bool,
      videoDuration: freezed == videoDuration
          ? _value.videoDuration
          : videoDuration // ignore: cast_nullable_to_non_nullable
              as Duration?,
      thumbnailData: freezed == thumbnailData
          ? _value.thumbnailData
          : thumbnailData // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      thumbnailUploaded: null == thumbnailUploaded
          ? _value.thumbnailUploaded
          : thumbnailUploaded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CreatePostFormImpl implements _CreatePostForm {
  const _$CreatePostFormImpl(
      {required this.postId,
      required this.appUser,
      this.videoData,
      this.videoDataUploaded = false,
      this.videoDuration,
      this.thumbnailData,
      this.thumbnailUploaded = false});

  @override
  final String postId;
  @override
  final AppUser appUser;
  @override
  final File? videoData;
  @override
  @JsonKey()
  final bool videoDataUploaded;
  @override
  final Duration? videoDuration;
  @override
  final Uint8List? thumbnailData;
  @override
  @JsonKey()
  final bool thumbnailUploaded;

  @override
  String toString() {
    return 'CreatePostForm.create(postId: $postId, appUser: $appUser, videoData: $videoData, videoDataUploaded: $videoDataUploaded, videoDuration: $videoDuration, thumbnailData: $thumbnailData, thumbnailUploaded: $thumbnailUploaded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePostFormImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.appUser, appUser) || other.appUser == appUser) &&
            (identical(other.videoData, videoData) ||
                other.videoData == videoData) &&
            (identical(other.videoDataUploaded, videoDataUploaded) ||
                other.videoDataUploaded == videoDataUploaded) &&
            (identical(other.videoDuration, videoDuration) ||
                other.videoDuration == videoDuration) &&
            const DeepCollectionEquality()
                .equals(other.thumbnailData, thumbnailData) &&
            (identical(other.thumbnailUploaded, thumbnailUploaded) ||
                other.thumbnailUploaded == thumbnailUploaded));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      postId,
      appUser,
      videoData,
      videoDataUploaded,
      videoDuration,
      const DeepCollectionEquality().hash(thumbnailData),
      thumbnailUploaded);

  /// Create a copy of CreatePostForm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatePostFormImplCopyWith<_$CreatePostFormImpl> get copyWith =>
      __$$CreatePostFormImplCopyWithImpl<_$CreatePostFormImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String postId,
            AppUser appUser,
            File? videoData,
            bool videoDataUploaded,
            Duration? videoDuration,
            Uint8List? thumbnailData,
            bool thumbnailUploaded)
        create,
  }) {
    return create(postId, appUser, videoData, videoDataUploaded, videoDuration,
        thumbnailData, thumbnailUploaded);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String postId,
            AppUser appUser,
            File? videoData,
            bool videoDataUploaded,
            Duration? videoDuration,
            Uint8List? thumbnailData,
            bool thumbnailUploaded)?
        create,
  }) {
    return create?.call(postId, appUser, videoData, videoDataUploaded,
        videoDuration, thumbnailData, thumbnailUploaded);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String postId,
            AppUser appUser,
            File? videoData,
            bool videoDataUploaded,
            Duration? videoDuration,
            Uint8List? thumbnailData,
            bool thumbnailUploaded)?
        create,
    required TResult orElse(),
  }) {
    if (create != null) {
      return create(postId, appUser, videoData, videoDataUploaded,
          videoDuration, thumbnailData, thumbnailUploaded);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreatePostForm value) create,
  }) {
    return create(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreatePostForm value)? create,
  }) {
    return create?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreatePostForm value)? create,
    required TResult orElse(),
  }) {
    if (create != null) {
      return create(this);
    }
    return orElse();
  }
}

abstract class _CreatePostForm implements CreatePostForm {
  const factory _CreatePostForm(
      {required final String postId,
      required final AppUser appUser,
      final File? videoData,
      final bool videoDataUploaded,
      final Duration? videoDuration,
      final Uint8List? thumbnailData,
      final bool thumbnailUploaded}) = _$CreatePostFormImpl;

  @override
  String get postId;
  @override
  AppUser get appUser;
  @override
  File? get videoData;
  @override
  bool get videoDataUploaded;
  @override
  Duration? get videoDuration;
  @override
  Uint8List? get thumbnailData;
  @override
  bool get thumbnailUploaded;

  /// Create a copy of CreatePostForm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatePostFormImplCopyWith<_$CreatePostFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

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
