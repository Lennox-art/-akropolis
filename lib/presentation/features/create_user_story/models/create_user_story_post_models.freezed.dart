// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_user_story_post_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateUserStoryPostState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProgressModel? progress) loading,
    required TResult Function() pickingVideo,
    required TResult Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)
        editingVideo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ProgressModel? progress)? loading,
    TResult? Function()? pickingVideo,
    TResult? Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)?
        editingVideo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ProgressModel? progress)? loading,
    TResult Function()? pickingVideo,
    TResult Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)?
        editingVideo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingCreateUserStoryPostState value) loading,
    required TResult Function(PickingVideoCreateUserStoryPostState value)
        pickingVideo,
    required TResult Function(EdittingVideoCreateUserStoryPostState value)
        editingVideo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingCreateUserStoryPostState value)? loading,
    TResult? Function(PickingVideoCreateUserStoryPostState value)? pickingVideo,
    TResult? Function(EdittingVideoCreateUserStoryPostState value)?
        editingVideo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingCreateUserStoryPostState value)? loading,
    TResult Function(PickingVideoCreateUserStoryPostState value)? pickingVideo,
    TResult Function(EdittingVideoCreateUserStoryPostState value)? editingVideo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateUserStoryPostStateCopyWith<$Res> {
  factory $CreateUserStoryPostStateCopyWith(CreateUserStoryPostState value,
          $Res Function(CreateUserStoryPostState) then) =
      _$CreateUserStoryPostStateCopyWithImpl<$Res, CreateUserStoryPostState>;
}

/// @nodoc
class _$CreateUserStoryPostStateCopyWithImpl<$Res,
        $Val extends CreateUserStoryPostState>
    implements $CreateUserStoryPostStateCopyWith<$Res> {
  _$CreateUserStoryPostStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateUserStoryPostState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadingCreateUserStoryPostStateImplCopyWith<$Res> {
  factory _$$LoadingCreateUserStoryPostStateImplCopyWith(
          _$LoadingCreateUserStoryPostStateImpl value,
          $Res Function(_$LoadingCreateUserStoryPostStateImpl) then) =
      __$$LoadingCreateUserStoryPostStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ProgressModel? progress});
}

/// @nodoc
class __$$LoadingCreateUserStoryPostStateImplCopyWithImpl<$Res>
    extends _$CreateUserStoryPostStateCopyWithImpl<$Res,
        _$LoadingCreateUserStoryPostStateImpl>
    implements _$$LoadingCreateUserStoryPostStateImplCopyWith<$Res> {
  __$$LoadingCreateUserStoryPostStateImplCopyWithImpl(
      _$LoadingCreateUserStoryPostStateImpl _value,
      $Res Function(_$LoadingCreateUserStoryPostStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateUserStoryPostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = freezed,
  }) {
    return _then(_$LoadingCreateUserStoryPostStateImpl(
      progress: freezed == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as ProgressModel?,
    ));
  }
}

/// @nodoc

class _$LoadingCreateUserStoryPostStateImpl
    implements LoadingCreateUserStoryPostState {
  const _$LoadingCreateUserStoryPostStateImpl({this.progress});

  @override
  final ProgressModel? progress;

  @override
  String toString() {
    return 'CreateUserStoryPostState.loading(progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingCreateUserStoryPostStateImpl &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, progress);

  /// Create a copy of CreateUserStoryPostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingCreateUserStoryPostStateImplCopyWith<
          _$LoadingCreateUserStoryPostStateImpl>
      get copyWith => __$$LoadingCreateUserStoryPostStateImplCopyWithImpl<
          _$LoadingCreateUserStoryPostStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProgressModel? progress) loading,
    required TResult Function() pickingVideo,
    required TResult Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)
        editingVideo,
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
    required TResult Function(LoadingCreateUserStoryPostState value) loading,
    required TResult Function(PickingVideoCreateUserStoryPostState value)
        pickingVideo,
    required TResult Function(EdittingVideoCreateUserStoryPostState value)
        editingVideo,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingCreateUserStoryPostState value)? loading,
    TResult? Function(PickingVideoCreateUserStoryPostState value)? pickingVideo,
    TResult? Function(EdittingVideoCreateUserStoryPostState value)?
        editingVideo,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingCreateUserStoryPostState value)? loading,
    TResult Function(PickingVideoCreateUserStoryPostState value)? pickingVideo,
    TResult Function(EdittingVideoCreateUserStoryPostState value)? editingVideo,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LoadingCreateUserStoryPostState
    implements CreateUserStoryPostState {
  const factory LoadingCreateUserStoryPostState(
      {final ProgressModel? progress}) = _$LoadingCreateUserStoryPostStateImpl;

  ProgressModel? get progress;

  /// Create a copy of CreateUserStoryPostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingCreateUserStoryPostStateImplCopyWith<
          _$LoadingCreateUserStoryPostStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PickingVideoCreateUserStoryPostStateImplCopyWith<$Res> {
  factory _$$PickingVideoCreateUserStoryPostStateImplCopyWith(
          _$PickingVideoCreateUserStoryPostStateImpl value,
          $Res Function(_$PickingVideoCreateUserStoryPostStateImpl) then) =
      __$$PickingVideoCreateUserStoryPostStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PickingVideoCreateUserStoryPostStateImplCopyWithImpl<$Res>
    extends _$CreateUserStoryPostStateCopyWithImpl<$Res,
        _$PickingVideoCreateUserStoryPostStateImpl>
    implements _$$PickingVideoCreateUserStoryPostStateImplCopyWith<$Res> {
  __$$PickingVideoCreateUserStoryPostStateImplCopyWithImpl(
      _$PickingVideoCreateUserStoryPostStateImpl _value,
      $Res Function(_$PickingVideoCreateUserStoryPostStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateUserStoryPostState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PickingVideoCreateUserStoryPostStateImpl
    implements PickingVideoCreateUserStoryPostState {
  const _$PickingVideoCreateUserStoryPostStateImpl();

  @override
  String toString() {
    return 'CreateUserStoryPostState.pickingVideo()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PickingVideoCreateUserStoryPostStateImpl);
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
    required TResult Function(LoadingCreateUserStoryPostState value) loading,
    required TResult Function(PickingVideoCreateUserStoryPostState value)
        pickingVideo,
    required TResult Function(EdittingVideoCreateUserStoryPostState value)
        editingVideo,
  }) {
    return pickingVideo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingCreateUserStoryPostState value)? loading,
    TResult? Function(PickingVideoCreateUserStoryPostState value)? pickingVideo,
    TResult? Function(EdittingVideoCreateUserStoryPostState value)?
        editingVideo,
  }) {
    return pickingVideo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingCreateUserStoryPostState value)? loading,
    TResult Function(PickingVideoCreateUserStoryPostState value)? pickingVideo,
    TResult Function(EdittingVideoCreateUserStoryPostState value)? editingVideo,
    required TResult orElse(),
  }) {
    if (pickingVideo != null) {
      return pickingVideo(this);
    }
    return orElse();
  }
}

abstract class PickingVideoCreateUserStoryPostState
    implements CreateUserStoryPostState {
  const factory PickingVideoCreateUserStoryPostState() =
      _$PickingVideoCreateUserStoryPostStateImpl;
}

/// @nodoc
abstract class _$$EdittingVideoCreateUserStoryPostStateImplCopyWith<$Res> {
  factory _$$EdittingVideoCreateUserStoryPostStateImplCopyWith(
          _$EdittingVideoCreateUserStoryPostStateImpl value,
          $Res Function(_$EdittingVideoCreateUserStoryPostStateImpl) then) =
      __$$EdittingVideoCreateUserStoryPostStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {File video,
      Uint8List selectedThumbnail,
      List<Uint8List> videoThumbnails,
      VideoEditingTools currentTool});
}

/// @nodoc
class __$$EdittingVideoCreateUserStoryPostStateImplCopyWithImpl<$Res>
    extends _$CreateUserStoryPostStateCopyWithImpl<$Res,
        _$EdittingVideoCreateUserStoryPostStateImpl>
    implements _$$EdittingVideoCreateUserStoryPostStateImplCopyWith<$Res> {
  __$$EdittingVideoCreateUserStoryPostStateImplCopyWithImpl(
      _$EdittingVideoCreateUserStoryPostStateImpl _value,
      $Res Function(_$EdittingVideoCreateUserStoryPostStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateUserStoryPostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? video = null,
    Object? selectedThumbnail = null,
    Object? videoThumbnails = null,
    Object? currentTool = null,
  }) {
    return _then(_$EdittingVideoCreateUserStoryPostStateImpl(
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

class _$EdittingVideoCreateUserStoryPostStateImpl
    implements EdittingVideoCreateUserStoryPostState {
  const _$EdittingVideoCreateUserStoryPostStateImpl(
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
    return 'CreateUserStoryPostState.editingVideo(video: $video, selectedThumbnail: $selectedThumbnail, videoThumbnails: $videoThumbnails, currentTool: $currentTool)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EdittingVideoCreateUserStoryPostStateImpl &&
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

  /// Create a copy of CreateUserStoryPostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EdittingVideoCreateUserStoryPostStateImplCopyWith<
          _$EdittingVideoCreateUserStoryPostStateImpl>
      get copyWith => __$$EdittingVideoCreateUserStoryPostStateImplCopyWithImpl<
          _$EdittingVideoCreateUserStoryPostStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProgressModel? progress) loading,
    required TResult Function() pickingVideo,
    required TResult Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)
        editingVideo,
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
    required TResult Function(LoadingCreateUserStoryPostState value) loading,
    required TResult Function(PickingVideoCreateUserStoryPostState value)
        pickingVideo,
    required TResult Function(EdittingVideoCreateUserStoryPostState value)
        editingVideo,
  }) {
    return editingVideo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingCreateUserStoryPostState value)? loading,
    TResult? Function(PickingVideoCreateUserStoryPostState value)? pickingVideo,
    TResult? Function(EdittingVideoCreateUserStoryPostState value)?
        editingVideo,
  }) {
    return editingVideo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingCreateUserStoryPostState value)? loading,
    TResult Function(PickingVideoCreateUserStoryPostState value)? pickingVideo,
    TResult Function(EdittingVideoCreateUserStoryPostState value)? editingVideo,
    required TResult orElse(),
  }) {
    if (editingVideo != null) {
      return editingVideo(this);
    }
    return orElse();
  }
}

abstract class EdittingVideoCreateUserStoryPostState
    implements CreateUserStoryPostState {
  const factory EdittingVideoCreateUserStoryPostState(
          {required final File video,
          required final Uint8List selectedThumbnail,
          required final List<Uint8List> videoThumbnails,
          required final VideoEditingTools currentTool}) =
      _$EdittingVideoCreateUserStoryPostStateImpl;

  File get video;
  Uint8List get selectedThumbnail;
  List<Uint8List> get videoThumbnails;
  VideoEditingTools get currentTool;

  /// Create a copy of CreateUserStoryPostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EdittingVideoCreateUserStoryPostStateImplCopyWith<
          _$EdittingVideoCreateUserStoryPostStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
