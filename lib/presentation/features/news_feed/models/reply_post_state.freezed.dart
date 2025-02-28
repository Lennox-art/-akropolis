// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reply_post_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ReplyPostState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProgressModel? progress) loading,
    required TResult Function(AppFailure failure) errorState,
    required TResult Function() idlePostState,
    required TResult Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)
        editingVideo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ProgressModel? progress)? loading,
    TResult? Function(AppFailure failure)? errorState,
    TResult? Function()? idlePostState,
    TResult? Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)?
        editingVideo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ProgressModel? progress)? loading,
    TResult Function(AppFailure failure)? errorState,
    TResult Function()? idlePostState,
    TResult Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)?
        editingVideo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingReplyPostState value) loading,
    required TResult Function(ErrorReplyPostState value) errorState,
    required TResult Function(IdlePostState value) idlePostState,
    required TResult Function(EdittingVideoReplyPostState value) editingVideo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingReplyPostState value)? loading,
    TResult? Function(ErrorReplyPostState value)? errorState,
    TResult? Function(IdlePostState value)? idlePostState,
    TResult? Function(EdittingVideoReplyPostState value)? editingVideo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingReplyPostState value)? loading,
    TResult Function(ErrorReplyPostState value)? errorState,
    TResult Function(IdlePostState value)? idlePostState,
    TResult Function(EdittingVideoReplyPostState value)? editingVideo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReplyPostStateCopyWith<$Res> {
  factory $ReplyPostStateCopyWith(
          ReplyPostState value, $Res Function(ReplyPostState) then) =
      _$ReplyPostStateCopyWithImpl<$Res, ReplyPostState>;
}

/// @nodoc
class _$ReplyPostStateCopyWithImpl<$Res, $Val extends ReplyPostState>
    implements $ReplyPostStateCopyWith<$Res> {
  _$ReplyPostStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReplyPostState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadingReplyPostStateImplCopyWith<$Res> {
  factory _$$LoadingReplyPostStateImplCopyWith(
          _$LoadingReplyPostStateImpl value,
          $Res Function(_$LoadingReplyPostStateImpl) then) =
      __$$LoadingReplyPostStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ProgressModel? progress});
}

/// @nodoc
class __$$LoadingReplyPostStateImplCopyWithImpl<$Res>
    extends _$ReplyPostStateCopyWithImpl<$Res, _$LoadingReplyPostStateImpl>
    implements _$$LoadingReplyPostStateImplCopyWith<$Res> {
  __$$LoadingReplyPostStateImplCopyWithImpl(_$LoadingReplyPostStateImpl _value,
      $Res Function(_$LoadingReplyPostStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReplyPostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = freezed,
  }) {
    return _then(_$LoadingReplyPostStateImpl(
      progress: freezed == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as ProgressModel?,
    ));
  }
}

/// @nodoc

class _$LoadingReplyPostStateImpl implements LoadingReplyPostState {
  const _$LoadingReplyPostStateImpl({this.progress});

  @override
  final ProgressModel? progress;

  @override
  String toString() {
    return 'ReplyPostState.loading(progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingReplyPostStateImpl &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, progress);

  /// Create a copy of ReplyPostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingReplyPostStateImplCopyWith<_$LoadingReplyPostStateImpl>
      get copyWith => __$$LoadingReplyPostStateImplCopyWithImpl<
          _$LoadingReplyPostStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProgressModel? progress) loading,
    required TResult Function(AppFailure failure) errorState,
    required TResult Function() idlePostState,
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
    TResult? Function(AppFailure failure)? errorState,
    TResult? Function()? idlePostState,
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
    TResult Function(AppFailure failure)? errorState,
    TResult Function()? idlePostState,
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
    required TResult Function(LoadingReplyPostState value) loading,
    required TResult Function(ErrorReplyPostState value) errorState,
    required TResult Function(IdlePostState value) idlePostState,
    required TResult Function(EdittingVideoReplyPostState value) editingVideo,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingReplyPostState value)? loading,
    TResult? Function(ErrorReplyPostState value)? errorState,
    TResult? Function(IdlePostState value)? idlePostState,
    TResult? Function(EdittingVideoReplyPostState value)? editingVideo,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingReplyPostState value)? loading,
    TResult Function(ErrorReplyPostState value)? errorState,
    TResult Function(IdlePostState value)? idlePostState,
    TResult Function(EdittingVideoReplyPostState value)? editingVideo,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LoadingReplyPostState implements ReplyPostState {
  const factory LoadingReplyPostState({final ProgressModel? progress}) =
      _$LoadingReplyPostStateImpl;

  ProgressModel? get progress;

  /// Create a copy of ReplyPostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingReplyPostStateImplCopyWith<_$LoadingReplyPostStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorReplyPostStateImplCopyWith<$Res> {
  factory _$$ErrorReplyPostStateImplCopyWith(_$ErrorReplyPostStateImpl value,
          $Res Function(_$ErrorReplyPostStateImpl) then) =
      __$$ErrorReplyPostStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppFailure failure});
}

/// @nodoc
class __$$ErrorReplyPostStateImplCopyWithImpl<$Res>
    extends _$ReplyPostStateCopyWithImpl<$Res, _$ErrorReplyPostStateImpl>
    implements _$$ErrorReplyPostStateImplCopyWith<$Res> {
  __$$ErrorReplyPostStateImplCopyWithImpl(_$ErrorReplyPostStateImpl _value,
      $Res Function(_$ErrorReplyPostStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReplyPostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$ErrorReplyPostStateImpl(
      failure: null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as AppFailure,
    ));
  }
}

/// @nodoc

class _$ErrorReplyPostStateImpl implements ErrorReplyPostState {
  const _$ErrorReplyPostStateImpl({required this.failure});

  @override
  final AppFailure failure;

  @override
  String toString() {
    return 'ReplyPostState.errorState(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorReplyPostStateImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of ReplyPostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorReplyPostStateImplCopyWith<_$ErrorReplyPostStateImpl> get copyWith =>
      __$$ErrorReplyPostStateImplCopyWithImpl<_$ErrorReplyPostStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProgressModel? progress) loading,
    required TResult Function(AppFailure failure) errorState,
    required TResult Function() idlePostState,
    required TResult Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)
        editingVideo,
  }) {
    return errorState(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ProgressModel? progress)? loading,
    TResult? Function(AppFailure failure)? errorState,
    TResult? Function()? idlePostState,
    TResult? Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)?
        editingVideo,
  }) {
    return errorState?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ProgressModel? progress)? loading,
    TResult Function(AppFailure failure)? errorState,
    TResult Function()? idlePostState,
    TResult Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)?
        editingVideo,
    required TResult orElse(),
  }) {
    if (errorState != null) {
      return errorState(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingReplyPostState value) loading,
    required TResult Function(ErrorReplyPostState value) errorState,
    required TResult Function(IdlePostState value) idlePostState,
    required TResult Function(EdittingVideoReplyPostState value) editingVideo,
  }) {
    return errorState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingReplyPostState value)? loading,
    TResult? Function(ErrorReplyPostState value)? errorState,
    TResult? Function(IdlePostState value)? idlePostState,
    TResult? Function(EdittingVideoReplyPostState value)? editingVideo,
  }) {
    return errorState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingReplyPostState value)? loading,
    TResult Function(ErrorReplyPostState value)? errorState,
    TResult Function(IdlePostState value)? idlePostState,
    TResult Function(EdittingVideoReplyPostState value)? editingVideo,
    required TResult orElse(),
  }) {
    if (errorState != null) {
      return errorState(this);
    }
    return orElse();
  }
}

abstract class ErrorReplyPostState implements ReplyPostState {
  const factory ErrorReplyPostState({required final AppFailure failure}) =
      _$ErrorReplyPostStateImpl;

  AppFailure get failure;

  /// Create a copy of ReplyPostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorReplyPostStateImplCopyWith<_$ErrorReplyPostStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$IdlePostStateImplCopyWith<$Res> {
  factory _$$IdlePostStateImplCopyWith(
          _$IdlePostStateImpl value, $Res Function(_$IdlePostStateImpl) then) =
      __$$IdlePostStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$IdlePostStateImplCopyWithImpl<$Res>
    extends _$ReplyPostStateCopyWithImpl<$Res, _$IdlePostStateImpl>
    implements _$$IdlePostStateImplCopyWith<$Res> {
  __$$IdlePostStateImplCopyWithImpl(
      _$IdlePostStateImpl _value, $Res Function(_$IdlePostStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReplyPostState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$IdlePostStateImpl implements IdlePostState {
  const _$IdlePostStateImpl();

  @override
  String toString() {
    return 'ReplyPostState.idlePostState()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$IdlePostStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProgressModel? progress) loading,
    required TResult Function(AppFailure failure) errorState,
    required TResult Function() idlePostState,
    required TResult Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)
        editingVideo,
  }) {
    return idlePostState();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ProgressModel? progress)? loading,
    TResult? Function(AppFailure failure)? errorState,
    TResult? Function()? idlePostState,
    TResult? Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)?
        editingVideo,
  }) {
    return idlePostState?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ProgressModel? progress)? loading,
    TResult Function(AppFailure failure)? errorState,
    TResult Function()? idlePostState,
    TResult Function(File video, Uint8List selectedThumbnail,
            List<Uint8List> videoThumbnails, VideoEditingTools currentTool)?
        editingVideo,
    required TResult orElse(),
  }) {
    if (idlePostState != null) {
      return idlePostState();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingReplyPostState value) loading,
    required TResult Function(ErrorReplyPostState value) errorState,
    required TResult Function(IdlePostState value) idlePostState,
    required TResult Function(EdittingVideoReplyPostState value) editingVideo,
  }) {
    return idlePostState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingReplyPostState value)? loading,
    TResult? Function(ErrorReplyPostState value)? errorState,
    TResult? Function(IdlePostState value)? idlePostState,
    TResult? Function(EdittingVideoReplyPostState value)? editingVideo,
  }) {
    return idlePostState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingReplyPostState value)? loading,
    TResult Function(ErrorReplyPostState value)? errorState,
    TResult Function(IdlePostState value)? idlePostState,
    TResult Function(EdittingVideoReplyPostState value)? editingVideo,
    required TResult orElse(),
  }) {
    if (idlePostState != null) {
      return idlePostState(this);
    }
    return orElse();
  }
}

abstract class IdlePostState implements ReplyPostState {
  const factory IdlePostState() = _$IdlePostStateImpl;
}

/// @nodoc
abstract class _$$EdittingVideoReplyPostStateImplCopyWith<$Res> {
  factory _$$EdittingVideoReplyPostStateImplCopyWith(
          _$EdittingVideoReplyPostStateImpl value,
          $Res Function(_$EdittingVideoReplyPostStateImpl) then) =
      __$$EdittingVideoReplyPostStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {File video,
      Uint8List selectedThumbnail,
      List<Uint8List> videoThumbnails,
      VideoEditingTools currentTool});
}

/// @nodoc
class __$$EdittingVideoReplyPostStateImplCopyWithImpl<$Res>
    extends _$ReplyPostStateCopyWithImpl<$Res,
        _$EdittingVideoReplyPostStateImpl>
    implements _$$EdittingVideoReplyPostStateImplCopyWith<$Res> {
  __$$EdittingVideoReplyPostStateImplCopyWithImpl(
      _$EdittingVideoReplyPostStateImpl _value,
      $Res Function(_$EdittingVideoReplyPostStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReplyPostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? video = null,
    Object? selectedThumbnail = null,
    Object? videoThumbnails = null,
    Object? currentTool = null,
  }) {
    return _then(_$EdittingVideoReplyPostStateImpl(
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

class _$EdittingVideoReplyPostStateImpl implements EdittingVideoReplyPostState {
  const _$EdittingVideoReplyPostStateImpl(
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
    return 'ReplyPostState.editingVideo(video: $video, selectedThumbnail: $selectedThumbnail, videoThumbnails: $videoThumbnails, currentTool: $currentTool)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EdittingVideoReplyPostStateImpl &&
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

  /// Create a copy of ReplyPostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EdittingVideoReplyPostStateImplCopyWith<_$EdittingVideoReplyPostStateImpl>
      get copyWith => __$$EdittingVideoReplyPostStateImplCopyWithImpl<
          _$EdittingVideoReplyPostStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProgressModel? progress) loading,
    required TResult Function(AppFailure failure) errorState,
    required TResult Function() idlePostState,
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
    TResult? Function(AppFailure failure)? errorState,
    TResult? Function()? idlePostState,
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
    TResult Function(AppFailure failure)? errorState,
    TResult Function()? idlePostState,
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
    required TResult Function(LoadingReplyPostState value) loading,
    required TResult Function(ErrorReplyPostState value) errorState,
    required TResult Function(IdlePostState value) idlePostState,
    required TResult Function(EdittingVideoReplyPostState value) editingVideo,
  }) {
    return editingVideo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingReplyPostState value)? loading,
    TResult? Function(ErrorReplyPostState value)? errorState,
    TResult? Function(IdlePostState value)? idlePostState,
    TResult? Function(EdittingVideoReplyPostState value)? editingVideo,
  }) {
    return editingVideo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingReplyPostState value)? loading,
    TResult Function(ErrorReplyPostState value)? errorState,
    TResult Function(IdlePostState value)? idlePostState,
    TResult Function(EdittingVideoReplyPostState value)? editingVideo,
    required TResult orElse(),
  }) {
    if (editingVideo != null) {
      return editingVideo(this);
    }
    return orElse();
  }
}

abstract class EdittingVideoReplyPostState implements ReplyPostState {
  const factory EdittingVideoReplyPostState(
          {required final File video,
          required final Uint8List selectedThumbnail,
          required final List<Uint8List> videoThumbnails,
          required final VideoEditingTools currentTool}) =
      _$EdittingVideoReplyPostStateImpl;

  File get video;
  Uint8List get selectedThumbnail;
  List<Uint8List> get videoThumbnails;
  VideoEditingTools get currentTool;

  /// Create a copy of ReplyPostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EdittingVideoReplyPostStateImplCopyWith<_$EdittingVideoReplyPostStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
