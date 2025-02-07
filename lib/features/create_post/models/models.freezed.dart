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
  String get userId => throw _privateConstructorUsedError;
  File? get videoData => throw _privateConstructorUsedError;
  Uint8List? get thumbnailData => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId, File? videoData,
            Uint8List? thumbnailData, String? title, String? description)
        create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId, File? videoData, Uint8List? thumbnailData,
            String? title, String? description)?
        create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId, File? videoData, Uint8List? thumbnailData,
            String? title, String? description)?
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
      {String userId,
      File? videoData,
      Uint8List? thumbnailData,
      String? title,
      String? description});
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
    Object? userId = null,
    Object? videoData = freezed,
    Object? thumbnailData = freezed,
    Object? title = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      videoData: freezed == videoData
          ? _value.videoData
          : videoData // ignore: cast_nullable_to_non_nullable
              as File?,
      thumbnailData: freezed == thumbnailData
          ? _value.thumbnailData
          : thumbnailData // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
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
      {String userId,
      File? videoData,
      Uint8List? thumbnailData,
      String? title,
      String? description});
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
    Object? userId = null,
    Object? videoData = freezed,
    Object? thumbnailData = freezed,
    Object? title = freezed,
    Object? description = freezed,
  }) {
    return _then(_$CreatePostFormImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      videoData: freezed == videoData
          ? _value.videoData
          : videoData // ignore: cast_nullable_to_non_nullable
              as File?,
      thumbnailData: freezed == thumbnailData
          ? _value.thumbnailData
          : thumbnailData // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CreatePostFormImpl implements _CreatePostForm {
  const _$CreatePostFormImpl(
      {required this.userId,
      this.videoData,
      this.thumbnailData,
      this.title,
      this.description});

  @override
  final String userId;
  @override
  final File? videoData;
  @override
  final Uint8List? thumbnailData;
  @override
  final String? title;
  @override
  final String? description;

  @override
  String toString() {
    return 'CreatePostForm.create(userId: $userId, videoData: $videoData, thumbnailData: $thumbnailData, title: $title, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePostFormImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.videoData, videoData) ||
                other.videoData == videoData) &&
            const DeepCollectionEquality()
                .equals(other.thumbnailData, thumbnailData) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, videoData,
      const DeepCollectionEquality().hash(thumbnailData), title, description);

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
    required TResult Function(String userId, File? videoData,
            Uint8List? thumbnailData, String? title, String? description)
        create,
  }) {
    return create(userId, videoData, thumbnailData, title, description);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId, File? videoData, Uint8List? thumbnailData,
            String? title, String? description)?
        create,
  }) {
    return create?.call(userId, videoData, thumbnailData, title, description);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId, File? videoData, Uint8List? thumbnailData,
            String? title, String? description)?
        create,
    required TResult orElse(),
  }) {
    if (create != null) {
      return create(userId, videoData, thumbnailData, title, description);
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
      {required final String userId,
      final File? videoData,
      final Uint8List? thumbnailData,
      final String? title,
      final String? description}) = _$CreatePostFormImpl;

  @override
  String get userId;
  @override
  File? get videoData;
  @override
  Uint8List? get thumbnailData;
  @override
  String? get title;
  @override
  String? get description;

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
