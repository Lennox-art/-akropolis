// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_download_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MediaDownloadState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(ProgressModel? progress) downloadingMedia,
    required TResult Function(MediaData media) downloadedMedia,
    required TResult Function(AppFailure failure) errorDownloadingMedia,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(ProgressModel? progress)? downloadingMedia,
    TResult? Function(MediaData media)? downloadedMedia,
    TResult? Function(AppFailure failure)? errorDownloadingMedia,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(ProgressModel? progress)? downloadingMedia,
    TResult Function(MediaData media)? downloadedMedia,
    TResult Function(AppFailure failure)? errorDownloadingMedia,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialMediaState value) initial,
    required TResult Function(DownloadingMediaState value) downloadingMedia,
    required TResult Function(DownloadedMediaState value) downloadedMedia,
    required TResult Function(ErrorDownloadMediaState value)
        errorDownloadingMedia,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialMediaState value)? initial,
    TResult? Function(DownloadingMediaState value)? downloadingMedia,
    TResult? Function(DownloadedMediaState value)? downloadedMedia,
    TResult? Function(ErrorDownloadMediaState value)? errorDownloadingMedia,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialMediaState value)? initial,
    TResult Function(DownloadingMediaState value)? downloadingMedia,
    TResult Function(DownloadedMediaState value)? downloadedMedia,
    TResult Function(ErrorDownloadMediaState value)? errorDownloadingMedia,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaDownloadStateCopyWith<$Res> {
  factory $MediaDownloadStateCopyWith(
          MediaDownloadState value, $Res Function(MediaDownloadState) then) =
      _$MediaDownloadStateCopyWithImpl<$Res, MediaDownloadState>;
}

/// @nodoc
class _$MediaDownloadStateCopyWithImpl<$Res, $Val extends MediaDownloadState>
    implements $MediaDownloadStateCopyWith<$Res> {
  _$MediaDownloadStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MediaDownloadState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialMediaStateImplCopyWith<$Res> {
  factory _$$InitialMediaStateImplCopyWith(_$InitialMediaStateImpl value,
          $Res Function(_$InitialMediaStateImpl) then) =
      __$$InitialMediaStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialMediaStateImplCopyWithImpl<$Res>
    extends _$MediaDownloadStateCopyWithImpl<$Res, _$InitialMediaStateImpl>
    implements _$$InitialMediaStateImplCopyWith<$Res> {
  __$$InitialMediaStateImplCopyWithImpl(_$InitialMediaStateImpl _value,
      $Res Function(_$InitialMediaStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MediaDownloadState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialMediaStateImpl implements InitialMediaState {
  const _$InitialMediaStateImpl();

  @override
  String toString() {
    return 'MediaDownloadState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialMediaStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(ProgressModel? progress) downloadingMedia,
    required TResult Function(MediaData media) downloadedMedia,
    required TResult Function(AppFailure failure) errorDownloadingMedia,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(ProgressModel? progress)? downloadingMedia,
    TResult? Function(MediaData media)? downloadedMedia,
    TResult? Function(AppFailure failure)? errorDownloadingMedia,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(ProgressModel? progress)? downloadingMedia,
    TResult Function(MediaData media)? downloadedMedia,
    TResult Function(AppFailure failure)? errorDownloadingMedia,
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
    required TResult Function(InitialMediaState value) initial,
    required TResult Function(DownloadingMediaState value) downloadingMedia,
    required TResult Function(DownloadedMediaState value) downloadedMedia,
    required TResult Function(ErrorDownloadMediaState value)
        errorDownloadingMedia,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialMediaState value)? initial,
    TResult? Function(DownloadingMediaState value)? downloadingMedia,
    TResult? Function(DownloadedMediaState value)? downloadedMedia,
    TResult? Function(ErrorDownloadMediaState value)? errorDownloadingMedia,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialMediaState value)? initial,
    TResult Function(DownloadingMediaState value)? downloadingMedia,
    TResult Function(DownloadedMediaState value)? downloadedMedia,
    TResult Function(ErrorDownloadMediaState value)? errorDownloadingMedia,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class InitialMediaState implements MediaDownloadState {
  const factory InitialMediaState() = _$InitialMediaStateImpl;
}

/// @nodoc
abstract class _$$DownloadingMediaStateImplCopyWith<$Res> {
  factory _$$DownloadingMediaStateImplCopyWith(
          _$DownloadingMediaStateImpl value,
          $Res Function(_$DownloadingMediaStateImpl) then) =
      __$$DownloadingMediaStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ProgressModel? progress});
}

/// @nodoc
class __$$DownloadingMediaStateImplCopyWithImpl<$Res>
    extends _$MediaDownloadStateCopyWithImpl<$Res, _$DownloadingMediaStateImpl>
    implements _$$DownloadingMediaStateImplCopyWith<$Res> {
  __$$DownloadingMediaStateImplCopyWithImpl(_$DownloadingMediaStateImpl _value,
      $Res Function(_$DownloadingMediaStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MediaDownloadState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = freezed,
  }) {
    return _then(_$DownloadingMediaStateImpl(
      progress: freezed == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as ProgressModel?,
    ));
  }
}

/// @nodoc

class _$DownloadingMediaStateImpl implements DownloadingMediaState {
  const _$DownloadingMediaStateImpl({this.progress});

  @override
  final ProgressModel? progress;

  @override
  String toString() {
    return 'MediaDownloadState.downloadingMedia(progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DownloadingMediaStateImpl &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, progress);

  /// Create a copy of MediaDownloadState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DownloadingMediaStateImplCopyWith<_$DownloadingMediaStateImpl>
      get copyWith => __$$DownloadingMediaStateImplCopyWithImpl<
          _$DownloadingMediaStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(ProgressModel? progress) downloadingMedia,
    required TResult Function(MediaData media) downloadedMedia,
    required TResult Function(AppFailure failure) errorDownloadingMedia,
  }) {
    return downloadingMedia(progress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(ProgressModel? progress)? downloadingMedia,
    TResult? Function(MediaData media)? downloadedMedia,
    TResult? Function(AppFailure failure)? errorDownloadingMedia,
  }) {
    return downloadingMedia?.call(progress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(ProgressModel? progress)? downloadingMedia,
    TResult Function(MediaData media)? downloadedMedia,
    TResult Function(AppFailure failure)? errorDownloadingMedia,
    required TResult orElse(),
  }) {
    if (downloadingMedia != null) {
      return downloadingMedia(progress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialMediaState value) initial,
    required TResult Function(DownloadingMediaState value) downloadingMedia,
    required TResult Function(DownloadedMediaState value) downloadedMedia,
    required TResult Function(ErrorDownloadMediaState value)
        errorDownloadingMedia,
  }) {
    return downloadingMedia(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialMediaState value)? initial,
    TResult? Function(DownloadingMediaState value)? downloadingMedia,
    TResult? Function(DownloadedMediaState value)? downloadedMedia,
    TResult? Function(ErrorDownloadMediaState value)? errorDownloadingMedia,
  }) {
    return downloadingMedia?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialMediaState value)? initial,
    TResult Function(DownloadingMediaState value)? downloadingMedia,
    TResult Function(DownloadedMediaState value)? downloadedMedia,
    TResult Function(ErrorDownloadMediaState value)? errorDownloadingMedia,
    required TResult orElse(),
  }) {
    if (downloadingMedia != null) {
      return downloadingMedia(this);
    }
    return orElse();
  }
}

abstract class DownloadingMediaState implements MediaDownloadState {
  const factory DownloadingMediaState({final ProgressModel? progress}) =
      _$DownloadingMediaStateImpl;

  ProgressModel? get progress;

  /// Create a copy of MediaDownloadState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DownloadingMediaStateImplCopyWith<_$DownloadingMediaStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DownloadedMediaStateImplCopyWith<$Res> {
  factory _$$DownloadedMediaStateImplCopyWith(_$DownloadedMediaStateImpl value,
          $Res Function(_$DownloadedMediaStateImpl) then) =
      __$$DownloadedMediaStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({MediaData media});
}

/// @nodoc
class __$$DownloadedMediaStateImplCopyWithImpl<$Res>
    extends _$MediaDownloadStateCopyWithImpl<$Res, _$DownloadedMediaStateImpl>
    implements _$$DownloadedMediaStateImplCopyWith<$Res> {
  __$$DownloadedMediaStateImplCopyWithImpl(_$DownloadedMediaStateImpl _value,
      $Res Function(_$DownloadedMediaStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MediaDownloadState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? media = null,
  }) {
    return _then(_$DownloadedMediaStateImpl(
      media: null == media
          ? _value.media
          : media // ignore: cast_nullable_to_non_nullable
              as MediaData,
    ));
  }
}

/// @nodoc

class _$DownloadedMediaStateImpl implements DownloadedMediaState {
  const _$DownloadedMediaStateImpl({required this.media});

  @override
  final MediaData media;

  @override
  String toString() {
    return 'MediaDownloadState.downloadedMedia(media: $media)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DownloadedMediaStateImpl &&
            (identical(other.media, media) || other.media == media));
  }

  @override
  int get hashCode => Object.hash(runtimeType, media);

  /// Create a copy of MediaDownloadState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DownloadedMediaStateImplCopyWith<_$DownloadedMediaStateImpl>
      get copyWith =>
          __$$DownloadedMediaStateImplCopyWithImpl<_$DownloadedMediaStateImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(ProgressModel? progress) downloadingMedia,
    required TResult Function(MediaData media) downloadedMedia,
    required TResult Function(AppFailure failure) errorDownloadingMedia,
  }) {
    return downloadedMedia(media);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(ProgressModel? progress)? downloadingMedia,
    TResult? Function(MediaData media)? downloadedMedia,
    TResult? Function(AppFailure failure)? errorDownloadingMedia,
  }) {
    return downloadedMedia?.call(media);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(ProgressModel? progress)? downloadingMedia,
    TResult Function(MediaData media)? downloadedMedia,
    TResult Function(AppFailure failure)? errorDownloadingMedia,
    required TResult orElse(),
  }) {
    if (downloadedMedia != null) {
      return downloadedMedia(media);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialMediaState value) initial,
    required TResult Function(DownloadingMediaState value) downloadingMedia,
    required TResult Function(DownloadedMediaState value) downloadedMedia,
    required TResult Function(ErrorDownloadMediaState value)
        errorDownloadingMedia,
  }) {
    return downloadedMedia(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialMediaState value)? initial,
    TResult? Function(DownloadingMediaState value)? downloadingMedia,
    TResult? Function(DownloadedMediaState value)? downloadedMedia,
    TResult? Function(ErrorDownloadMediaState value)? errorDownloadingMedia,
  }) {
    return downloadedMedia?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialMediaState value)? initial,
    TResult Function(DownloadingMediaState value)? downloadingMedia,
    TResult Function(DownloadedMediaState value)? downloadedMedia,
    TResult Function(ErrorDownloadMediaState value)? errorDownloadingMedia,
    required TResult orElse(),
  }) {
    if (downloadedMedia != null) {
      return downloadedMedia(this);
    }
    return orElse();
  }
}

abstract class DownloadedMediaState implements MediaDownloadState {
  const factory DownloadedMediaState({required final MediaData media}) =
      _$DownloadedMediaStateImpl;

  MediaData get media;

  /// Create a copy of MediaDownloadState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DownloadedMediaStateImplCopyWith<_$DownloadedMediaStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorDownloadMediaStateImplCopyWith<$Res> {
  factory _$$ErrorDownloadMediaStateImplCopyWith(
          _$ErrorDownloadMediaStateImpl value,
          $Res Function(_$ErrorDownloadMediaStateImpl) then) =
      __$$ErrorDownloadMediaStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppFailure failure});
}

/// @nodoc
class __$$ErrorDownloadMediaStateImplCopyWithImpl<$Res>
    extends _$MediaDownloadStateCopyWithImpl<$Res,
        _$ErrorDownloadMediaStateImpl>
    implements _$$ErrorDownloadMediaStateImplCopyWith<$Res> {
  __$$ErrorDownloadMediaStateImplCopyWithImpl(
      _$ErrorDownloadMediaStateImpl _value,
      $Res Function(_$ErrorDownloadMediaStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MediaDownloadState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$ErrorDownloadMediaStateImpl(
      failure: null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as AppFailure,
    ));
  }
}

/// @nodoc

class _$ErrorDownloadMediaStateImpl implements ErrorDownloadMediaState {
  const _$ErrorDownloadMediaStateImpl({required this.failure});

  @override
  final AppFailure failure;

  @override
  String toString() {
    return 'MediaDownloadState.errorDownloadingMedia(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorDownloadMediaStateImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of MediaDownloadState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorDownloadMediaStateImplCopyWith<_$ErrorDownloadMediaStateImpl>
      get copyWith => __$$ErrorDownloadMediaStateImplCopyWithImpl<
          _$ErrorDownloadMediaStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(ProgressModel? progress) downloadingMedia,
    required TResult Function(MediaData media) downloadedMedia,
    required TResult Function(AppFailure failure) errorDownloadingMedia,
  }) {
    return errorDownloadingMedia(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(ProgressModel? progress)? downloadingMedia,
    TResult? Function(MediaData media)? downloadedMedia,
    TResult? Function(AppFailure failure)? errorDownloadingMedia,
  }) {
    return errorDownloadingMedia?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(ProgressModel? progress)? downloadingMedia,
    TResult Function(MediaData media)? downloadedMedia,
    TResult Function(AppFailure failure)? errorDownloadingMedia,
    required TResult orElse(),
  }) {
    if (errorDownloadingMedia != null) {
      return errorDownloadingMedia(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialMediaState value) initial,
    required TResult Function(DownloadingMediaState value) downloadingMedia,
    required TResult Function(DownloadedMediaState value) downloadedMedia,
    required TResult Function(ErrorDownloadMediaState value)
        errorDownloadingMedia,
  }) {
    return errorDownloadingMedia(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialMediaState value)? initial,
    TResult? Function(DownloadingMediaState value)? downloadingMedia,
    TResult? Function(DownloadedMediaState value)? downloadedMedia,
    TResult? Function(ErrorDownloadMediaState value)? errorDownloadingMedia,
  }) {
    return errorDownloadingMedia?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialMediaState value)? initial,
    TResult Function(DownloadingMediaState value)? downloadingMedia,
    TResult Function(DownloadedMediaState value)? downloadedMedia,
    TResult Function(ErrorDownloadMediaState value)? errorDownloadingMedia,
    required TResult orElse(),
  }) {
    if (errorDownloadingMedia != null) {
      return errorDownloadingMedia(this);
    }
    return orElse();
  }
}

abstract class ErrorDownloadMediaState implements MediaDownloadState {
  const factory ErrorDownloadMediaState({required final AppFailure failure}) =
      _$ErrorDownloadMediaStateImpl;

  AppFailure get failure;

  /// Create a copy of MediaDownloadState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorDownloadMediaStateImplCopyWith<_$ErrorDownloadMediaStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
