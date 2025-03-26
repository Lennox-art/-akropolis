// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_video_message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NewVideoMessageState {
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
    required TResult Function(LoadingNewVideoMessageState value) loading,
    required TResult Function(ErrorNewVideoMessageState value) errorState,
    required TResult Function(IdleNewVideoMessageState value) idlePostState,
    required TResult Function(EdittingVideoNewVideoMessageState value)
        editingVideo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingNewVideoMessageState value)? loading,
    TResult? Function(ErrorNewVideoMessageState value)? errorState,
    TResult? Function(IdleNewVideoMessageState value)? idlePostState,
    TResult? Function(EdittingVideoNewVideoMessageState value)? editingVideo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingNewVideoMessageState value)? loading,
    TResult Function(ErrorNewVideoMessageState value)? errorState,
    TResult Function(IdleNewVideoMessageState value)? idlePostState,
    TResult Function(EdittingVideoNewVideoMessageState value)? editingVideo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewVideoMessageStateCopyWith<$Res> {
  factory $NewVideoMessageStateCopyWith(NewVideoMessageState value,
          $Res Function(NewVideoMessageState) then) =
      _$NewVideoMessageStateCopyWithImpl<$Res, NewVideoMessageState>;
}

/// @nodoc
class _$NewVideoMessageStateCopyWithImpl<$Res,
        $Val extends NewVideoMessageState>
    implements $NewVideoMessageStateCopyWith<$Res> {
  _$NewVideoMessageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NewVideoMessageState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadingNewVideoMessageStateImplCopyWith<$Res> {
  factory _$$LoadingNewVideoMessageStateImplCopyWith(
          _$LoadingNewVideoMessageStateImpl value,
          $Res Function(_$LoadingNewVideoMessageStateImpl) then) =
      __$$LoadingNewVideoMessageStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ProgressModel? progress});
}

/// @nodoc
class __$$LoadingNewVideoMessageStateImplCopyWithImpl<$Res>
    extends _$NewVideoMessageStateCopyWithImpl<$Res,
        _$LoadingNewVideoMessageStateImpl>
    implements _$$LoadingNewVideoMessageStateImplCopyWith<$Res> {
  __$$LoadingNewVideoMessageStateImplCopyWithImpl(
      _$LoadingNewVideoMessageStateImpl _value,
      $Res Function(_$LoadingNewVideoMessageStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of NewVideoMessageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = freezed,
  }) {
    return _then(_$LoadingNewVideoMessageStateImpl(
      progress: freezed == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as ProgressModel?,
    ));
  }
}

/// @nodoc

class _$LoadingNewVideoMessageStateImpl implements LoadingNewVideoMessageState {
  const _$LoadingNewVideoMessageStateImpl({this.progress});

  @override
  final ProgressModel? progress;

  @override
  String toString() {
    return 'NewVideoMessageState.loading(progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingNewVideoMessageStateImpl &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, progress);

  /// Create a copy of NewVideoMessageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingNewVideoMessageStateImplCopyWith<_$LoadingNewVideoMessageStateImpl>
      get copyWith => __$$LoadingNewVideoMessageStateImplCopyWithImpl<
          _$LoadingNewVideoMessageStateImpl>(this, _$identity);

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
    required TResult Function(LoadingNewVideoMessageState value) loading,
    required TResult Function(ErrorNewVideoMessageState value) errorState,
    required TResult Function(IdleNewVideoMessageState value) idlePostState,
    required TResult Function(EdittingVideoNewVideoMessageState value)
        editingVideo,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingNewVideoMessageState value)? loading,
    TResult? Function(ErrorNewVideoMessageState value)? errorState,
    TResult? Function(IdleNewVideoMessageState value)? idlePostState,
    TResult? Function(EdittingVideoNewVideoMessageState value)? editingVideo,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingNewVideoMessageState value)? loading,
    TResult Function(ErrorNewVideoMessageState value)? errorState,
    TResult Function(IdleNewVideoMessageState value)? idlePostState,
    TResult Function(EdittingVideoNewVideoMessageState value)? editingVideo,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LoadingNewVideoMessageState implements NewVideoMessageState {
  const factory LoadingNewVideoMessageState({final ProgressModel? progress}) =
      _$LoadingNewVideoMessageStateImpl;

  ProgressModel? get progress;

  /// Create a copy of NewVideoMessageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingNewVideoMessageStateImplCopyWith<_$LoadingNewVideoMessageStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorNewVideoMessageStateImplCopyWith<$Res> {
  factory _$$ErrorNewVideoMessageStateImplCopyWith(
          _$ErrorNewVideoMessageStateImpl value,
          $Res Function(_$ErrorNewVideoMessageStateImpl) then) =
      __$$ErrorNewVideoMessageStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppFailure failure});
}

/// @nodoc
class __$$ErrorNewVideoMessageStateImplCopyWithImpl<$Res>
    extends _$NewVideoMessageStateCopyWithImpl<$Res,
        _$ErrorNewVideoMessageStateImpl>
    implements _$$ErrorNewVideoMessageStateImplCopyWith<$Res> {
  __$$ErrorNewVideoMessageStateImplCopyWithImpl(
      _$ErrorNewVideoMessageStateImpl _value,
      $Res Function(_$ErrorNewVideoMessageStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of NewVideoMessageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$ErrorNewVideoMessageStateImpl(
      failure: null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as AppFailure,
    ));
  }
}

/// @nodoc

class _$ErrorNewVideoMessageStateImpl implements ErrorNewVideoMessageState {
  const _$ErrorNewVideoMessageStateImpl({required this.failure});

  @override
  final AppFailure failure;

  @override
  String toString() {
    return 'NewVideoMessageState.errorState(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorNewVideoMessageStateImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of NewVideoMessageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorNewVideoMessageStateImplCopyWith<_$ErrorNewVideoMessageStateImpl>
      get copyWith => __$$ErrorNewVideoMessageStateImplCopyWithImpl<
          _$ErrorNewVideoMessageStateImpl>(this, _$identity);

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
    required TResult Function(LoadingNewVideoMessageState value) loading,
    required TResult Function(ErrorNewVideoMessageState value) errorState,
    required TResult Function(IdleNewVideoMessageState value) idlePostState,
    required TResult Function(EdittingVideoNewVideoMessageState value)
        editingVideo,
  }) {
    return errorState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingNewVideoMessageState value)? loading,
    TResult? Function(ErrorNewVideoMessageState value)? errorState,
    TResult? Function(IdleNewVideoMessageState value)? idlePostState,
    TResult? Function(EdittingVideoNewVideoMessageState value)? editingVideo,
  }) {
    return errorState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingNewVideoMessageState value)? loading,
    TResult Function(ErrorNewVideoMessageState value)? errorState,
    TResult Function(IdleNewVideoMessageState value)? idlePostState,
    TResult Function(EdittingVideoNewVideoMessageState value)? editingVideo,
    required TResult orElse(),
  }) {
    if (errorState != null) {
      return errorState(this);
    }
    return orElse();
  }
}

abstract class ErrorNewVideoMessageState implements NewVideoMessageState {
  const factory ErrorNewVideoMessageState({required final AppFailure failure}) =
      _$ErrorNewVideoMessageStateImpl;

  AppFailure get failure;

  /// Create a copy of NewVideoMessageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorNewVideoMessageStateImplCopyWith<_$ErrorNewVideoMessageStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$IdleNewVideoMessageStateImplCopyWith<$Res> {
  factory _$$IdleNewVideoMessageStateImplCopyWith(
          _$IdleNewVideoMessageStateImpl value,
          $Res Function(_$IdleNewVideoMessageStateImpl) then) =
      __$$IdleNewVideoMessageStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$IdleNewVideoMessageStateImplCopyWithImpl<$Res>
    extends _$NewVideoMessageStateCopyWithImpl<$Res,
        _$IdleNewVideoMessageStateImpl>
    implements _$$IdleNewVideoMessageStateImplCopyWith<$Res> {
  __$$IdleNewVideoMessageStateImplCopyWithImpl(
      _$IdleNewVideoMessageStateImpl _value,
      $Res Function(_$IdleNewVideoMessageStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of NewVideoMessageState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$IdleNewVideoMessageStateImpl implements IdleNewVideoMessageState {
  const _$IdleNewVideoMessageStateImpl();

  @override
  String toString() {
    return 'NewVideoMessageState.idlePostState()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IdleNewVideoMessageStateImpl);
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
    required TResult Function(LoadingNewVideoMessageState value) loading,
    required TResult Function(ErrorNewVideoMessageState value) errorState,
    required TResult Function(IdleNewVideoMessageState value) idlePostState,
    required TResult Function(EdittingVideoNewVideoMessageState value)
        editingVideo,
  }) {
    return idlePostState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingNewVideoMessageState value)? loading,
    TResult? Function(ErrorNewVideoMessageState value)? errorState,
    TResult? Function(IdleNewVideoMessageState value)? idlePostState,
    TResult? Function(EdittingVideoNewVideoMessageState value)? editingVideo,
  }) {
    return idlePostState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingNewVideoMessageState value)? loading,
    TResult Function(ErrorNewVideoMessageState value)? errorState,
    TResult Function(IdleNewVideoMessageState value)? idlePostState,
    TResult Function(EdittingVideoNewVideoMessageState value)? editingVideo,
    required TResult orElse(),
  }) {
    if (idlePostState != null) {
      return idlePostState(this);
    }
    return orElse();
  }
}

abstract class IdleNewVideoMessageState implements NewVideoMessageState {
  const factory IdleNewVideoMessageState() = _$IdleNewVideoMessageStateImpl;
}

/// @nodoc
abstract class _$$EdittingVideoNewVideoMessageStateImplCopyWith<$Res> {
  factory _$$EdittingVideoNewVideoMessageStateImplCopyWith(
          _$EdittingVideoNewVideoMessageStateImpl value,
          $Res Function(_$EdittingVideoNewVideoMessageStateImpl) then) =
      __$$EdittingVideoNewVideoMessageStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {File video,
      Uint8List selectedThumbnail,
      List<Uint8List> videoThumbnails,
      VideoEditingTools currentTool});
}

/// @nodoc
class __$$EdittingVideoNewVideoMessageStateImplCopyWithImpl<$Res>
    extends _$NewVideoMessageStateCopyWithImpl<$Res,
        _$EdittingVideoNewVideoMessageStateImpl>
    implements _$$EdittingVideoNewVideoMessageStateImplCopyWith<$Res> {
  __$$EdittingVideoNewVideoMessageStateImplCopyWithImpl(
      _$EdittingVideoNewVideoMessageStateImpl _value,
      $Res Function(_$EdittingVideoNewVideoMessageStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of NewVideoMessageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? video = null,
    Object? selectedThumbnail = null,
    Object? videoThumbnails = null,
    Object? currentTool = null,
  }) {
    return _then(_$EdittingVideoNewVideoMessageStateImpl(
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

class _$EdittingVideoNewVideoMessageStateImpl
    implements EdittingVideoNewVideoMessageState {
  const _$EdittingVideoNewVideoMessageStateImpl(
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
    return 'NewVideoMessageState.editingVideo(video: $video, selectedThumbnail: $selectedThumbnail, videoThumbnails: $videoThumbnails, currentTool: $currentTool)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EdittingVideoNewVideoMessageStateImpl &&
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

  /// Create a copy of NewVideoMessageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EdittingVideoNewVideoMessageStateImplCopyWith<
          _$EdittingVideoNewVideoMessageStateImpl>
      get copyWith => __$$EdittingVideoNewVideoMessageStateImplCopyWithImpl<
          _$EdittingVideoNewVideoMessageStateImpl>(this, _$identity);

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
    required TResult Function(LoadingNewVideoMessageState value) loading,
    required TResult Function(ErrorNewVideoMessageState value) errorState,
    required TResult Function(IdleNewVideoMessageState value) idlePostState,
    required TResult Function(EdittingVideoNewVideoMessageState value)
        editingVideo,
  }) {
    return editingVideo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingNewVideoMessageState value)? loading,
    TResult? Function(ErrorNewVideoMessageState value)? errorState,
    TResult? Function(IdleNewVideoMessageState value)? idlePostState,
    TResult? Function(EdittingVideoNewVideoMessageState value)? editingVideo,
  }) {
    return editingVideo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingNewVideoMessageState value)? loading,
    TResult Function(ErrorNewVideoMessageState value)? errorState,
    TResult Function(IdleNewVideoMessageState value)? idlePostState,
    TResult Function(EdittingVideoNewVideoMessageState value)? editingVideo,
    required TResult orElse(),
  }) {
    if (editingVideo != null) {
      return editingVideo(this);
    }
    return orElse();
  }
}

abstract class EdittingVideoNewVideoMessageState
    implements NewVideoMessageState {
  const factory EdittingVideoNewVideoMessageState(
          {required final File video,
          required final Uint8List selectedThumbnail,
          required final List<Uint8List> videoThumbnails,
          required final VideoEditingTools currentTool}) =
      _$EdittingVideoNewVideoMessageStateImpl;

  File get video;
  Uint8List get selectedThumbnail;
  List<Uint8List> get videoThumbnails;
  VideoEditingTools get currentTool;

  /// Create a copy of NewVideoMessageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EdittingVideoNewVideoMessageStateImplCopyWith<
          _$EdittingVideoNewVideoMessageStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
