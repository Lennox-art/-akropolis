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
    required TResult Function(ProgressModel? progress) loading,
    required TResult Function() pickingVideo,
    required TResult Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)
        editingVideo,
    required TResult Function(File video, Uint8List thumbnail) captionPost,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ProgressModel? progress)? loading,
    TResult? Function()? pickingVideo,
    TResult? Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)?
        editingVideo,
    TResult? Function(File video, Uint8List thumbnail)? captionPost,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ProgressModel? progress)? loading,
    TResult Function()? pickingVideo,
    TResult Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)?
        editingVideo,
    TResult Function(File video, Uint8List thumbnail)? captionPost,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingCreatePostState value) loading,
    required TResult Function(PickingVideoCreatePostState value) pickingVideo,
    required TResult Function(EdittingVideoCreatePostState value) editingVideo,
    required TResult Function(CaptionPostCreatePostState value) captionPost,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingCreatePostState value)? loading,
    TResult? Function(PickingVideoCreatePostState value)? pickingVideo,
    TResult? Function(EdittingVideoCreatePostState value)? editingVideo,
    TResult? Function(CaptionPostCreatePostState value)? captionPost,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingCreatePostState value)? loading,
    TResult Function(PickingVideoCreatePostState value)? pickingVideo,
    TResult Function(EdittingVideoCreatePostState value)? editingVideo,
    TResult Function(CaptionPostCreatePostState value)? captionPost,
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
  $Res call({ProgressModel? progress});
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
              as ProgressModel?,
    ));
  }
}

/// @nodoc

class _$LoadingCreatePostStateImpl implements LoadingCreatePostState {
  const _$LoadingCreatePostStateImpl({this.progress});

  @override
  final ProgressModel? progress;

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
    required TResult Function(ProgressModel? progress) loading,
    required TResult Function() pickingVideo,
    required TResult Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)
        editingVideo,
    required TResult Function(File video, Uint8List thumbnail) captionPost,
  }) {
    return loading(progress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ProgressModel? progress)? loading,
    TResult? Function()? pickingVideo,
    TResult? Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)?
        editingVideo,
    TResult? Function(File video, Uint8List thumbnail)? captionPost,
  }) {
    return loading?.call(progress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ProgressModel? progress)? loading,
    TResult Function()? pickingVideo,
    TResult Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)?
        editingVideo,
    TResult Function(File video, Uint8List thumbnail)? captionPost,
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
    required TResult Function(PickingVideoCreatePostState value) pickingVideo,
    required TResult Function(EdittingVideoCreatePostState value) editingVideo,
    required TResult Function(CaptionPostCreatePostState value) captionPost,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingCreatePostState value)? loading,
    TResult? Function(PickingVideoCreatePostState value)? pickingVideo,
    TResult? Function(EdittingVideoCreatePostState value)? editingVideo,
    TResult? Function(CaptionPostCreatePostState value)? captionPost,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingCreatePostState value)? loading,
    TResult Function(PickingVideoCreatePostState value)? pickingVideo,
    TResult Function(EdittingVideoCreatePostState value)? editingVideo,
    TResult Function(CaptionPostCreatePostState value)? captionPost,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LoadingCreatePostState implements CreatePostState {
  const factory LoadingCreatePostState({final ProgressModel? progress}) =
      _$LoadingCreatePostStateImpl;

  ProgressModel? get progress;

  /// Create a copy of CreatePostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingCreatePostStateImplCopyWith<_$LoadingCreatePostStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PickingVideoCreatePostStateImplCopyWith<$Res> {
  factory _$$PickingVideoCreatePostStateImplCopyWith(
          _$PickingVideoCreatePostStateImpl value,
          $Res Function(_$PickingVideoCreatePostStateImpl) then) =
      __$$PickingVideoCreatePostStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PickingVideoCreatePostStateImplCopyWithImpl<$Res>
    extends _$CreatePostStateCopyWithImpl<$Res,
        _$PickingVideoCreatePostStateImpl>
    implements _$$PickingVideoCreatePostStateImplCopyWith<$Res> {
  __$$PickingVideoCreatePostStateImplCopyWithImpl(
      _$PickingVideoCreatePostStateImpl _value,
      $Res Function(_$PickingVideoCreatePostStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreatePostState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PickingVideoCreatePostStateImpl implements PickingVideoCreatePostState {
  const _$PickingVideoCreatePostStateImpl();

  @override
  String toString() {
    return 'CreatePostState.pickingVideo()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PickingVideoCreatePostStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProgressModel? progress) loading,
    required TResult Function() pickingVideo,
    required TResult Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)
        editingVideo,
    required TResult Function(File video, Uint8List thumbnail) captionPost,
  }) {
    return pickingVideo();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ProgressModel? progress)? loading,
    TResult? Function()? pickingVideo,
    TResult? Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)?
        editingVideo,
    TResult? Function(File video, Uint8List thumbnail)? captionPost,
  }) {
    return pickingVideo?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ProgressModel? progress)? loading,
    TResult Function()? pickingVideo,
    TResult Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)?
        editingVideo,
    TResult Function(File video, Uint8List thumbnail)? captionPost,
    required TResult orElse(),
  }) {
    if (pickingVideo != null) {
      return pickingVideo();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingCreatePostState value) loading,
    required TResult Function(PickingVideoCreatePostState value) pickingVideo,
    required TResult Function(EdittingVideoCreatePostState value) editingVideo,
    required TResult Function(CaptionPostCreatePostState value) captionPost,
  }) {
    return pickingVideo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingCreatePostState value)? loading,
    TResult? Function(PickingVideoCreatePostState value)? pickingVideo,
    TResult? Function(EdittingVideoCreatePostState value)? editingVideo,
    TResult? Function(CaptionPostCreatePostState value)? captionPost,
  }) {
    return pickingVideo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingCreatePostState value)? loading,
    TResult Function(PickingVideoCreatePostState value)? pickingVideo,
    TResult Function(EdittingVideoCreatePostState value)? editingVideo,
    TResult Function(CaptionPostCreatePostState value)? captionPost,
    required TResult orElse(),
  }) {
    if (pickingVideo != null) {
      return pickingVideo(this);
    }
    return orElse();
  }
}

abstract class PickingVideoCreatePostState implements CreatePostState {
  const factory PickingVideoCreatePostState() =
      _$PickingVideoCreatePostStateImpl;
}

/// @nodoc
abstract class _$$EdittingVideoCreatePostStateImplCopyWith<$Res> {
  factory _$$EdittingVideoCreatePostStateImplCopyWith(
          _$EdittingVideoCreatePostStateImpl value,
          $Res Function(_$EdittingVideoCreatePostStateImpl) then) =
      __$$EdittingVideoCreatePostStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {File video,
      Uint8List selectedThumbnail,
      List<Uint8List> videoThumbnails,
      VideoEditingTools currentTool});
}

/// @nodoc
class __$$EdittingVideoCreatePostStateImplCopyWithImpl<$Res>
    extends _$CreatePostStateCopyWithImpl<$Res,
        _$EdittingVideoCreatePostStateImpl>
    implements _$$EdittingVideoCreatePostStateImplCopyWith<$Res> {
  __$$EdittingVideoCreatePostStateImplCopyWithImpl(
      _$EdittingVideoCreatePostStateImpl _value,
      $Res Function(_$EdittingVideoCreatePostStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreatePostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? video = null,
    Object? selectedThumbnail = null,
    Object? videoThumbnails = null,
    Object? currentTool = null,
  }) {
    return _then(_$EdittingVideoCreatePostStateImpl(
      video: null == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as File,
      selectedThumbnail: null == selectedThumbnail
          ? _value.selectedThumbnail
          : selectedThumbnail // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      videoThumbnails: null == videoThumbnails
          ? _value._videoThumbnails
          : videoThumbnails // ignore: cast_nullable_to_non_nullable
              as List<Uint8List>,
      currentTool: null == currentTool
          ? _value.currentTool
          : currentTool // ignore: cast_nullable_to_non_nullable
              as VideoEditingTools,
    ));
  }
}

/// @nodoc

class _$EdittingVideoCreatePostStateImpl
    implements EdittingVideoCreatePostState {
  const _$EdittingVideoCreatePostStateImpl(
      {required this.video,
      required this.selectedThumbnail,
      required final List<Uint8List> videoThumbnails,
      required this.currentTool})
      : _videoThumbnails = videoThumbnails;

  @override
  final File video;
  @override
  final Uint8List selectedThumbnail;
  final List<Uint8List> _videoThumbnails;
  @override
  List<Uint8List> get videoThumbnails {
    if (_videoThumbnails is EqualUnmodifiableListView) return _videoThumbnails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_videoThumbnails);
  }

  @override
  final VideoEditingTools currentTool;

  @override
  String toString() {
    return 'CreatePostState.editingVideo(video: $video, selectedThumbnail: $selectedThumbnail, videoThumbnails: $videoThumbnails, currentTool: $currentTool)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EdittingVideoCreatePostStateImpl &&
            (identical(other.video, video) || other.video == video) &&
            const DeepCollectionEquality()
                .equals(other.selectedThumbnail, selectedThumbnail) &&
            const DeepCollectionEquality()
                .equals(other._videoThumbnails, _videoThumbnails) &&
            (identical(other.currentTool, currentTool) ||
                other.currentTool == currentTool));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      video,
      const DeepCollectionEquality().hash(selectedThumbnail),
      const DeepCollectionEquality().hash(_videoThumbnails),
      currentTool);

  /// Create a copy of CreatePostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EdittingVideoCreatePostStateImplCopyWith<
          _$EdittingVideoCreatePostStateImpl>
      get copyWith => __$$EdittingVideoCreatePostStateImplCopyWithImpl<
          _$EdittingVideoCreatePostStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProgressModel? progress) loading,
    required TResult Function() pickingVideo,
    required TResult Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)
        editingVideo,
    required TResult Function(File video, Uint8List thumbnail) captionPost,
  }) {
    return editingVideo(video, selectedThumbnail, videoThumbnails, currentTool);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ProgressModel? progress)? loading,
    TResult? Function()? pickingVideo,
    TResult? Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)?
        editingVideo,
    TResult? Function(File video, Uint8List thumbnail)? captionPost,
  }) {
    return editingVideo?.call(
        video, selectedThumbnail, videoThumbnails, currentTool);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ProgressModel? progress)? loading,
    TResult Function()? pickingVideo,
    TResult Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)?
        editingVideo,
    TResult Function(File video, Uint8List thumbnail)? captionPost,
    required TResult orElse(),
  }) {
    if (editingVideo != null) {
      return editingVideo(
          video, selectedThumbnail, videoThumbnails, currentTool);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingCreatePostState value) loading,
    required TResult Function(PickingVideoCreatePostState value) pickingVideo,
    required TResult Function(EdittingVideoCreatePostState value) editingVideo,
    required TResult Function(CaptionPostCreatePostState value) captionPost,
  }) {
    return editingVideo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingCreatePostState value)? loading,
    TResult? Function(PickingVideoCreatePostState value)? pickingVideo,
    TResult? Function(EdittingVideoCreatePostState value)? editingVideo,
    TResult? Function(CaptionPostCreatePostState value)? captionPost,
  }) {
    return editingVideo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingCreatePostState value)? loading,
    TResult Function(PickingVideoCreatePostState value)? pickingVideo,
    TResult Function(EdittingVideoCreatePostState value)? editingVideo,
    TResult Function(CaptionPostCreatePostState value)? captionPost,
    required TResult orElse(),
  }) {
    if (editingVideo != null) {
      return editingVideo(this);
    }
    return orElse();
  }
}

abstract class EdittingVideoCreatePostState implements CreatePostState {
  const factory EdittingVideoCreatePostState(
          {required final File video,
          required final Uint8List selectedThumbnail,
          required final List<Uint8List> videoThumbnails,
          required final VideoEditingTools currentTool}) =
      _$EdittingVideoCreatePostStateImpl;

  File get video;
  Uint8List get selectedThumbnail;
  List<Uint8List> get videoThumbnails;
  VideoEditingTools get currentTool;

  /// Create a copy of CreatePostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EdittingVideoCreatePostStateImplCopyWith<
          _$EdittingVideoCreatePostStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CaptionPostCreatePostStateImplCopyWith<$Res> {
  factory _$$CaptionPostCreatePostStateImplCopyWith(
          _$CaptionPostCreatePostStateImpl value,
          $Res Function(_$CaptionPostCreatePostStateImpl) then) =
      __$$CaptionPostCreatePostStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({File video, Uint8List thumbnail});
}

/// @nodoc
class __$$CaptionPostCreatePostStateImplCopyWithImpl<$Res>
    extends _$CreatePostStateCopyWithImpl<$Res,
        _$CaptionPostCreatePostStateImpl>
    implements _$$CaptionPostCreatePostStateImplCopyWith<$Res> {
  __$$CaptionPostCreatePostStateImplCopyWithImpl(
      _$CaptionPostCreatePostStateImpl _value,
      $Res Function(_$CaptionPostCreatePostStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreatePostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? video = null,
    Object? thumbnail = null,
  }) {
    return _then(_$CaptionPostCreatePostStateImpl(
      video: null == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as File,
      thumbnail: null == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as Uint8List,
    ));
  }
}

/// @nodoc

class _$CaptionPostCreatePostStateImpl implements CaptionPostCreatePostState {
  const _$CaptionPostCreatePostStateImpl(
      {required this.video, required this.thumbnail});

  @override
  final File video;
  @override
  final Uint8List thumbnail;

  @override
  String toString() {
    return 'CreatePostState.captionPost(video: $video, thumbnail: $thumbnail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CaptionPostCreatePostStateImpl &&
            (identical(other.video, video) || other.video == video) &&
            const DeepCollectionEquality().equals(other.thumbnail, thumbnail));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, video, const DeepCollectionEquality().hash(thumbnail));

  /// Create a copy of CreatePostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CaptionPostCreatePostStateImplCopyWith<_$CaptionPostCreatePostStateImpl>
      get copyWith => __$$CaptionPostCreatePostStateImplCopyWithImpl<
          _$CaptionPostCreatePostStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProgressModel? progress) loading,
    required TResult Function() pickingVideo,
    required TResult Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)
        editingVideo,
    required TResult Function(File video, Uint8List thumbnail) captionPost,
  }) {
    return captionPost(video, thumbnail);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ProgressModel? progress)? loading,
    TResult? Function()? pickingVideo,
    TResult? Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)?
        editingVideo,
    TResult? Function(File video, Uint8List thumbnail)? captionPost,
  }) {
    return captionPost?.call(video, thumbnail);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ProgressModel? progress)? loading,
    TResult Function()? pickingVideo,
    TResult Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)?
        editingVideo,
    TResult Function(File video, Uint8List thumbnail)? captionPost,
    required TResult orElse(),
  }) {
    if (captionPost != null) {
      return captionPost(video, thumbnail);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingCreatePostState value) loading,
    required TResult Function(PickingVideoCreatePostState value) pickingVideo,
    required TResult Function(EdittingVideoCreatePostState value) editingVideo,
    required TResult Function(CaptionPostCreatePostState value) captionPost,
  }) {
    return captionPost(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingCreatePostState value)? loading,
    TResult? Function(PickingVideoCreatePostState value)? pickingVideo,
    TResult? Function(EdittingVideoCreatePostState value)? editingVideo,
    TResult? Function(CaptionPostCreatePostState value)? captionPost,
  }) {
    return captionPost?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingCreatePostState value)? loading,
    TResult Function(PickingVideoCreatePostState value)? pickingVideo,
    TResult Function(EdittingVideoCreatePostState value)? editingVideo,
    TResult Function(CaptionPostCreatePostState value)? captionPost,
    required TResult orElse(),
  }) {
    if (captionPost != null) {
      return captionPost(this);
    }
    return orElse();
  }
}

abstract class CaptionPostCreatePostState implements CreatePostState {
  const factory CaptionPostCreatePostState(
      {required final File video,
      required final Uint8List thumbnail}) = _$CaptionPostCreatePostStateImpl;

  File get video;
  Uint8List get thumbnail;

  /// Create a copy of CreatePostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CaptionPostCreatePostStateImplCopyWith<_$CaptionPostCreatePostStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
