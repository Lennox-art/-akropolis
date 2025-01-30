// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'camera_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CameraState {
  ToastMessage? get toast => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ToastMessage? toast) loading,
    required TResult Function(ToastMessage? toast) uninitialized,
    required TResult Function(
            List<CameraDescription> deviceCameras, ToastMessage? toast)
        initialized,
    required TResult Function(
            List<CameraDescription> deviceCameras,
            CameraDescription camera,
            CameraController cameraController,
            CameraSettings camSettings,
            ToastMessage? toast)
        preview,
    required TResult Function(
            CameraDescription camera,
            CameraController controller,
            CameraSettings camSettings,
            ToastMessage? toast)
        recording,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ToastMessage? toast)? loading,
    TResult? Function(ToastMessage? toast)? uninitialized,
    TResult? Function(
            List<CameraDescription> deviceCameras, ToastMessage? toast)?
        initialized,
    TResult? Function(
            List<CameraDescription> deviceCameras,
            CameraDescription camera,
            CameraController cameraController,
            CameraSettings camSettings,
            ToastMessage? toast)?
        preview,
    TResult? Function(CameraDescription camera, CameraController controller,
            CameraSettings camSettings, ToastMessage? toast)?
        recording,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ToastMessage? toast)? loading,
    TResult Function(ToastMessage? toast)? uninitialized,
    TResult Function(
            List<CameraDescription> deviceCameras, ToastMessage? toast)?
        initialized,
    TResult Function(
            List<CameraDescription> deviceCameras,
            CameraDescription camera,
            CameraController cameraController,
            CameraSettings camSettings,
            ToastMessage? toast)?
        preview,
    TResult Function(CameraDescription camera, CameraController controller,
            CameraSettings camSettings, ToastMessage? toast)?
        recording,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CameraLoadingState value) loading,
    required TResult Function(CameraUninitializedState value) uninitialized,
    required TResult Function(CameraInitializedState value) initialized,
    required TResult Function(CameraPreviewState value) preview,
    required TResult Function(CameraRecordingState value) recording,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CameraLoadingState value)? loading,
    TResult? Function(CameraUninitializedState value)? uninitialized,
    TResult? Function(CameraInitializedState value)? initialized,
    TResult? Function(CameraPreviewState value)? preview,
    TResult? Function(CameraRecordingState value)? recording,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CameraLoadingState value)? loading,
    TResult Function(CameraUninitializedState value)? uninitialized,
    TResult Function(CameraInitializedState value)? initialized,
    TResult Function(CameraPreviewState value)? preview,
    TResult Function(CameraRecordingState value)? recording,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of CameraState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CameraStateCopyWith<CameraState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CameraStateCopyWith<$Res> {
  factory $CameraStateCopyWith(
          CameraState value, $Res Function(CameraState) then) =
      _$CameraStateCopyWithImpl<$Res, CameraState>;
  @useResult
  $Res call({ToastMessage? toast});

  $ToastMessageCopyWith<$Res>? get toast;
}

/// @nodoc
class _$CameraStateCopyWithImpl<$Res, $Val extends CameraState>
    implements $CameraStateCopyWith<$Res> {
  _$CameraStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CameraState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? toast = freezed,
  }) {
    return _then(_value.copyWith(
      toast: freezed == toast
          ? _value.toast
          : toast // ignore: cast_nullable_to_non_nullable
              as ToastMessage?,
    ) as $Val);
  }

  /// Create a copy of CameraState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ToastMessageCopyWith<$Res>? get toast {
    if (_value.toast == null) {
      return null;
    }

    return $ToastMessageCopyWith<$Res>(_value.toast!, (value) {
      return _then(_value.copyWith(toast: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CameraLoadingStateImplCopyWith<$Res>
    implements $CameraStateCopyWith<$Res> {
  factory _$$CameraLoadingStateImplCopyWith(_$CameraLoadingStateImpl value,
          $Res Function(_$CameraLoadingStateImpl) then) =
      __$$CameraLoadingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ToastMessage? toast});

  @override
  $ToastMessageCopyWith<$Res>? get toast;
}

/// @nodoc
class __$$CameraLoadingStateImplCopyWithImpl<$Res>
    extends _$CameraStateCopyWithImpl<$Res, _$CameraLoadingStateImpl>
    implements _$$CameraLoadingStateImplCopyWith<$Res> {
  __$$CameraLoadingStateImplCopyWithImpl(_$CameraLoadingStateImpl _value,
      $Res Function(_$CameraLoadingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CameraState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? toast = freezed,
  }) {
    return _then(_$CameraLoadingStateImpl(
      toast: freezed == toast
          ? _value.toast
          : toast // ignore: cast_nullable_to_non_nullable
              as ToastMessage?,
    ));
  }
}

/// @nodoc

class _$CameraLoadingStateImpl implements CameraLoadingState {
  const _$CameraLoadingStateImpl({this.toast});

  @override
  final ToastMessage? toast;

  @override
  String toString() {
    return 'CameraState.loading(toast: $toast)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraLoadingStateImpl &&
            (identical(other.toast, toast) || other.toast == toast));
  }

  @override
  int get hashCode => Object.hash(runtimeType, toast);

  /// Create a copy of CameraState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CameraLoadingStateImplCopyWith<_$CameraLoadingStateImpl> get copyWith =>
      __$$CameraLoadingStateImplCopyWithImpl<_$CameraLoadingStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ToastMessage? toast) loading,
    required TResult Function(ToastMessage? toast) uninitialized,
    required TResult Function(
            List<CameraDescription> deviceCameras, ToastMessage? toast)
        initialized,
    required TResult Function(
            List<CameraDescription> deviceCameras,
            CameraDescription camera,
            CameraController cameraController,
            CameraSettings camSettings,
            ToastMessage? toast)
        preview,
    required TResult Function(
            CameraDescription camera,
            CameraController controller,
            CameraSettings camSettings,
            ToastMessage? toast)
        recording,
  }) {
    return loading(toast);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ToastMessage? toast)? loading,
    TResult? Function(ToastMessage? toast)? uninitialized,
    TResult? Function(
            List<CameraDescription> deviceCameras, ToastMessage? toast)?
        initialized,
    TResult? Function(
            List<CameraDescription> deviceCameras,
            CameraDescription camera,
            CameraController cameraController,
            CameraSettings camSettings,
            ToastMessage? toast)?
        preview,
    TResult? Function(CameraDescription camera, CameraController controller,
            CameraSettings camSettings, ToastMessage? toast)?
        recording,
  }) {
    return loading?.call(toast);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ToastMessage? toast)? loading,
    TResult Function(ToastMessage? toast)? uninitialized,
    TResult Function(
            List<CameraDescription> deviceCameras, ToastMessage? toast)?
        initialized,
    TResult Function(
            List<CameraDescription> deviceCameras,
            CameraDescription camera,
            CameraController cameraController,
            CameraSettings camSettings,
            ToastMessage? toast)?
        preview,
    TResult Function(CameraDescription camera, CameraController controller,
            CameraSettings camSettings, ToastMessage? toast)?
        recording,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(toast);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CameraLoadingState value) loading,
    required TResult Function(CameraUninitializedState value) uninitialized,
    required TResult Function(CameraInitializedState value) initialized,
    required TResult Function(CameraPreviewState value) preview,
    required TResult Function(CameraRecordingState value) recording,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CameraLoadingState value)? loading,
    TResult? Function(CameraUninitializedState value)? uninitialized,
    TResult? Function(CameraInitializedState value)? initialized,
    TResult? Function(CameraPreviewState value)? preview,
    TResult? Function(CameraRecordingState value)? recording,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CameraLoadingState value)? loading,
    TResult Function(CameraUninitializedState value)? uninitialized,
    TResult Function(CameraInitializedState value)? initialized,
    TResult Function(CameraPreviewState value)? preview,
    TResult Function(CameraRecordingState value)? recording,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class CameraLoadingState implements CameraState {
  const factory CameraLoadingState({final ToastMessage? toast}) =
      _$CameraLoadingStateImpl;

  @override
  ToastMessage? get toast;

  /// Create a copy of CameraState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CameraLoadingStateImplCopyWith<_$CameraLoadingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CameraUninitializedStateImplCopyWith<$Res>
    implements $CameraStateCopyWith<$Res> {
  factory _$$CameraUninitializedStateImplCopyWith(
          _$CameraUninitializedStateImpl value,
          $Res Function(_$CameraUninitializedStateImpl) then) =
      __$$CameraUninitializedStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ToastMessage? toast});

  @override
  $ToastMessageCopyWith<$Res>? get toast;
}

/// @nodoc
class __$$CameraUninitializedStateImplCopyWithImpl<$Res>
    extends _$CameraStateCopyWithImpl<$Res, _$CameraUninitializedStateImpl>
    implements _$$CameraUninitializedStateImplCopyWith<$Res> {
  __$$CameraUninitializedStateImplCopyWithImpl(
      _$CameraUninitializedStateImpl _value,
      $Res Function(_$CameraUninitializedStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CameraState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? toast = freezed,
  }) {
    return _then(_$CameraUninitializedStateImpl(
      toast: freezed == toast
          ? _value.toast
          : toast // ignore: cast_nullable_to_non_nullable
              as ToastMessage?,
    ));
  }
}

/// @nodoc

class _$CameraUninitializedStateImpl implements CameraUninitializedState {
  const _$CameraUninitializedStateImpl({this.toast});

  @override
  final ToastMessage? toast;

  @override
  String toString() {
    return 'CameraState.uninitialized(toast: $toast)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraUninitializedStateImpl &&
            (identical(other.toast, toast) || other.toast == toast));
  }

  @override
  int get hashCode => Object.hash(runtimeType, toast);

  /// Create a copy of CameraState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CameraUninitializedStateImplCopyWith<_$CameraUninitializedStateImpl>
      get copyWith => __$$CameraUninitializedStateImplCopyWithImpl<
          _$CameraUninitializedStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ToastMessage? toast) loading,
    required TResult Function(ToastMessage? toast) uninitialized,
    required TResult Function(
            List<CameraDescription> deviceCameras, ToastMessage? toast)
        initialized,
    required TResult Function(
            List<CameraDescription> deviceCameras,
            CameraDescription camera,
            CameraController cameraController,
            CameraSettings camSettings,
            ToastMessage? toast)
        preview,
    required TResult Function(
            CameraDescription camera,
            CameraController controller,
            CameraSettings camSettings,
            ToastMessage? toast)
        recording,
  }) {
    return uninitialized(toast);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ToastMessage? toast)? loading,
    TResult? Function(ToastMessage? toast)? uninitialized,
    TResult? Function(
            List<CameraDescription> deviceCameras, ToastMessage? toast)?
        initialized,
    TResult? Function(
            List<CameraDescription> deviceCameras,
            CameraDescription camera,
            CameraController cameraController,
            CameraSettings camSettings,
            ToastMessage? toast)?
        preview,
    TResult? Function(CameraDescription camera, CameraController controller,
            CameraSettings camSettings, ToastMessage? toast)?
        recording,
  }) {
    return uninitialized?.call(toast);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ToastMessage? toast)? loading,
    TResult Function(ToastMessage? toast)? uninitialized,
    TResult Function(
            List<CameraDescription> deviceCameras, ToastMessage? toast)?
        initialized,
    TResult Function(
            List<CameraDescription> deviceCameras,
            CameraDescription camera,
            CameraController cameraController,
            CameraSettings camSettings,
            ToastMessage? toast)?
        preview,
    TResult Function(CameraDescription camera, CameraController controller,
            CameraSettings camSettings, ToastMessage? toast)?
        recording,
    required TResult orElse(),
  }) {
    if (uninitialized != null) {
      return uninitialized(toast);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CameraLoadingState value) loading,
    required TResult Function(CameraUninitializedState value) uninitialized,
    required TResult Function(CameraInitializedState value) initialized,
    required TResult Function(CameraPreviewState value) preview,
    required TResult Function(CameraRecordingState value) recording,
  }) {
    return uninitialized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CameraLoadingState value)? loading,
    TResult? Function(CameraUninitializedState value)? uninitialized,
    TResult? Function(CameraInitializedState value)? initialized,
    TResult? Function(CameraPreviewState value)? preview,
    TResult? Function(CameraRecordingState value)? recording,
  }) {
    return uninitialized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CameraLoadingState value)? loading,
    TResult Function(CameraUninitializedState value)? uninitialized,
    TResult Function(CameraInitializedState value)? initialized,
    TResult Function(CameraPreviewState value)? preview,
    TResult Function(CameraRecordingState value)? recording,
    required TResult orElse(),
  }) {
    if (uninitialized != null) {
      return uninitialized(this);
    }
    return orElse();
  }
}

abstract class CameraUninitializedState implements CameraState {
  const factory CameraUninitializedState({final ToastMessage? toast}) =
      _$CameraUninitializedStateImpl;

  @override
  ToastMessage? get toast;

  /// Create a copy of CameraState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CameraUninitializedStateImplCopyWith<_$CameraUninitializedStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CameraInitializedStateImplCopyWith<$Res>
    implements $CameraStateCopyWith<$Res> {
  factory _$$CameraInitializedStateImplCopyWith(
          _$CameraInitializedStateImpl value,
          $Res Function(_$CameraInitializedStateImpl) then) =
      __$$CameraInitializedStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CameraDescription> deviceCameras, ToastMessage? toast});

  @override
  $ToastMessageCopyWith<$Res>? get toast;
}

/// @nodoc
class __$$CameraInitializedStateImplCopyWithImpl<$Res>
    extends _$CameraStateCopyWithImpl<$Res, _$CameraInitializedStateImpl>
    implements _$$CameraInitializedStateImplCopyWith<$Res> {
  __$$CameraInitializedStateImplCopyWithImpl(
      _$CameraInitializedStateImpl _value,
      $Res Function(_$CameraInitializedStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CameraState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceCameras = null,
    Object? toast = freezed,
  }) {
    return _then(_$CameraInitializedStateImpl(
      deviceCameras: null == deviceCameras
          ? _value._deviceCameras
          : deviceCameras // ignore: cast_nullable_to_non_nullable
              as List<CameraDescription>,
      toast: freezed == toast
          ? _value.toast
          : toast // ignore: cast_nullable_to_non_nullable
              as ToastMessage?,
    ));
  }
}

/// @nodoc

class _$CameraInitializedStateImpl implements CameraInitializedState {
  const _$CameraInitializedStateImpl(
      {required final List<CameraDescription> deviceCameras, this.toast})
      : _deviceCameras = deviceCameras;

  final List<CameraDescription> _deviceCameras;
  @override
  List<CameraDescription> get deviceCameras {
    if (_deviceCameras is EqualUnmodifiableListView) return _deviceCameras;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deviceCameras);
  }

  @override
  final ToastMessage? toast;

  @override
  String toString() {
    return 'CameraState.initialized(deviceCameras: $deviceCameras, toast: $toast)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraInitializedStateImpl &&
            const DeepCollectionEquality()
                .equals(other._deviceCameras, _deviceCameras) &&
            (identical(other.toast, toast) || other.toast == toast));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_deviceCameras), toast);

  /// Create a copy of CameraState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CameraInitializedStateImplCopyWith<_$CameraInitializedStateImpl>
      get copyWith => __$$CameraInitializedStateImplCopyWithImpl<
          _$CameraInitializedStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ToastMessage? toast) loading,
    required TResult Function(ToastMessage? toast) uninitialized,
    required TResult Function(
            List<CameraDescription> deviceCameras, ToastMessage? toast)
        initialized,
    required TResult Function(
            List<CameraDescription> deviceCameras,
            CameraDescription camera,
            CameraController cameraController,
            CameraSettings camSettings,
            ToastMessage? toast)
        preview,
    required TResult Function(
            CameraDescription camera,
            CameraController controller,
            CameraSettings camSettings,
            ToastMessage? toast)
        recording,
  }) {
    return initialized(deviceCameras, toast);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ToastMessage? toast)? loading,
    TResult? Function(ToastMessage? toast)? uninitialized,
    TResult? Function(
            List<CameraDescription> deviceCameras, ToastMessage? toast)?
        initialized,
    TResult? Function(
            List<CameraDescription> deviceCameras,
            CameraDescription camera,
            CameraController cameraController,
            CameraSettings camSettings,
            ToastMessage? toast)?
        preview,
    TResult? Function(CameraDescription camera, CameraController controller,
            CameraSettings camSettings, ToastMessage? toast)?
        recording,
  }) {
    return initialized?.call(deviceCameras, toast);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ToastMessage? toast)? loading,
    TResult Function(ToastMessage? toast)? uninitialized,
    TResult Function(
            List<CameraDescription> deviceCameras, ToastMessage? toast)?
        initialized,
    TResult Function(
            List<CameraDescription> deviceCameras,
            CameraDescription camera,
            CameraController cameraController,
            CameraSettings camSettings,
            ToastMessage? toast)?
        preview,
    TResult Function(CameraDescription camera, CameraController controller,
            CameraSettings camSettings, ToastMessage? toast)?
        recording,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized(deviceCameras, toast);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CameraLoadingState value) loading,
    required TResult Function(CameraUninitializedState value) uninitialized,
    required TResult Function(CameraInitializedState value) initialized,
    required TResult Function(CameraPreviewState value) preview,
    required TResult Function(CameraRecordingState value) recording,
  }) {
    return initialized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CameraLoadingState value)? loading,
    TResult? Function(CameraUninitializedState value)? uninitialized,
    TResult? Function(CameraInitializedState value)? initialized,
    TResult? Function(CameraPreviewState value)? preview,
    TResult? Function(CameraRecordingState value)? recording,
  }) {
    return initialized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CameraLoadingState value)? loading,
    TResult Function(CameraUninitializedState value)? uninitialized,
    TResult Function(CameraInitializedState value)? initialized,
    TResult Function(CameraPreviewState value)? preview,
    TResult Function(CameraRecordingState value)? recording,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized(this);
    }
    return orElse();
  }
}

abstract class CameraInitializedState implements CameraState {
  const factory CameraInitializedState(
      {required final List<CameraDescription> deviceCameras,
      final ToastMessage? toast}) = _$CameraInitializedStateImpl;

  List<CameraDescription> get deviceCameras;
  @override
  ToastMessage? get toast;

  /// Create a copy of CameraState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CameraInitializedStateImplCopyWith<_$CameraInitializedStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CameraPreviewStateImplCopyWith<$Res>
    implements $CameraStateCopyWith<$Res> {
  factory _$$CameraPreviewStateImplCopyWith(_$CameraPreviewStateImpl value,
          $Res Function(_$CameraPreviewStateImpl) then) =
      __$$CameraPreviewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<CameraDescription> deviceCameras,
      CameraDescription camera,
      CameraController cameraController,
      CameraSettings camSettings,
      ToastMessage? toast});

  $CameraSettingsCopyWith<$Res> get camSettings;
  @override
  $ToastMessageCopyWith<$Res>? get toast;
}

/// @nodoc
class __$$CameraPreviewStateImplCopyWithImpl<$Res>
    extends _$CameraStateCopyWithImpl<$Res, _$CameraPreviewStateImpl>
    implements _$$CameraPreviewStateImplCopyWith<$Res> {
  __$$CameraPreviewStateImplCopyWithImpl(_$CameraPreviewStateImpl _value,
      $Res Function(_$CameraPreviewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CameraState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceCameras = null,
    Object? camera = null,
    Object? cameraController = null,
    Object? camSettings = null,
    Object? toast = freezed,
  }) {
    return _then(_$CameraPreviewStateImpl(
      deviceCameras: null == deviceCameras
          ? _value._deviceCameras
          : deviceCameras // ignore: cast_nullable_to_non_nullable
              as List<CameraDescription>,
      camera: null == camera
          ? _value.camera
          : camera // ignore: cast_nullable_to_non_nullable
              as CameraDescription,
      cameraController: null == cameraController
          ? _value.cameraController
          : cameraController // ignore: cast_nullable_to_non_nullable
              as CameraController,
      camSettings: null == camSettings
          ? _value.camSettings
          : camSettings // ignore: cast_nullable_to_non_nullable
              as CameraSettings,
      toast: freezed == toast
          ? _value.toast
          : toast // ignore: cast_nullable_to_non_nullable
              as ToastMessage?,
    ));
  }

  /// Create a copy of CameraState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CameraSettingsCopyWith<$Res> get camSettings {
    return $CameraSettingsCopyWith<$Res>(_value.camSettings, (value) {
      return _then(_value.copyWith(camSettings: value));
    });
  }
}

/// @nodoc

class _$CameraPreviewStateImpl implements CameraPreviewState {
  const _$CameraPreviewStateImpl(
      {required final List<CameraDescription> deviceCameras,
      required this.camera,
      required this.cameraController,
      required this.camSettings,
      this.toast})
      : _deviceCameras = deviceCameras;

  final List<CameraDescription> _deviceCameras;
  @override
  List<CameraDescription> get deviceCameras {
    if (_deviceCameras is EqualUnmodifiableListView) return _deviceCameras;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deviceCameras);
  }

  @override
  final CameraDescription camera;
  @override
  final CameraController cameraController;
  @override
  final CameraSettings camSettings;
  @override
  final ToastMessage? toast;

  @override
  String toString() {
    return 'CameraState.preview(deviceCameras: $deviceCameras, camera: $camera, cameraController: $cameraController, camSettings: $camSettings, toast: $toast)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraPreviewStateImpl &&
            const DeepCollectionEquality()
                .equals(other._deviceCameras, _deviceCameras) &&
            (identical(other.camera, camera) || other.camera == camera) &&
            (identical(other.cameraController, cameraController) ||
                other.cameraController == cameraController) &&
            (identical(other.camSettings, camSettings) ||
                other.camSettings == camSettings) &&
            (identical(other.toast, toast) || other.toast == toast));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_deviceCameras),
      camera,
      cameraController,
      camSettings,
      toast);

  /// Create a copy of CameraState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CameraPreviewStateImplCopyWith<_$CameraPreviewStateImpl> get copyWith =>
      __$$CameraPreviewStateImplCopyWithImpl<_$CameraPreviewStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ToastMessage? toast) loading,
    required TResult Function(ToastMessage? toast) uninitialized,
    required TResult Function(
            List<CameraDescription> deviceCameras, ToastMessage? toast)
        initialized,
    required TResult Function(
            List<CameraDescription> deviceCameras,
            CameraDescription camera,
            CameraController cameraController,
            CameraSettings camSettings,
            ToastMessage? toast)
        preview,
    required TResult Function(
            CameraDescription camera,
            CameraController controller,
            CameraSettings camSettings,
            ToastMessage? toast)
        recording,
  }) {
    return preview(deviceCameras, camera, cameraController, camSettings, toast);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ToastMessage? toast)? loading,
    TResult? Function(ToastMessage? toast)? uninitialized,
    TResult? Function(
            List<CameraDescription> deviceCameras, ToastMessage? toast)?
        initialized,
    TResult? Function(
            List<CameraDescription> deviceCameras,
            CameraDescription camera,
            CameraController cameraController,
            CameraSettings camSettings,
            ToastMessage? toast)?
        preview,
    TResult? Function(CameraDescription camera, CameraController controller,
            CameraSettings camSettings, ToastMessage? toast)?
        recording,
  }) {
    return preview?.call(
        deviceCameras, camera, cameraController, camSettings, toast);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ToastMessage? toast)? loading,
    TResult Function(ToastMessage? toast)? uninitialized,
    TResult Function(
            List<CameraDescription> deviceCameras, ToastMessage? toast)?
        initialized,
    TResult Function(
            List<CameraDescription> deviceCameras,
            CameraDescription camera,
            CameraController cameraController,
            CameraSettings camSettings,
            ToastMessage? toast)?
        preview,
    TResult Function(CameraDescription camera, CameraController controller,
            CameraSettings camSettings, ToastMessage? toast)?
        recording,
    required TResult orElse(),
  }) {
    if (preview != null) {
      return preview(
          deviceCameras, camera, cameraController, camSettings, toast);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CameraLoadingState value) loading,
    required TResult Function(CameraUninitializedState value) uninitialized,
    required TResult Function(CameraInitializedState value) initialized,
    required TResult Function(CameraPreviewState value) preview,
    required TResult Function(CameraRecordingState value) recording,
  }) {
    return preview(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CameraLoadingState value)? loading,
    TResult? Function(CameraUninitializedState value)? uninitialized,
    TResult? Function(CameraInitializedState value)? initialized,
    TResult? Function(CameraPreviewState value)? preview,
    TResult? Function(CameraRecordingState value)? recording,
  }) {
    return preview?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CameraLoadingState value)? loading,
    TResult Function(CameraUninitializedState value)? uninitialized,
    TResult Function(CameraInitializedState value)? initialized,
    TResult Function(CameraPreviewState value)? preview,
    TResult Function(CameraRecordingState value)? recording,
    required TResult orElse(),
  }) {
    if (preview != null) {
      return preview(this);
    }
    return orElse();
  }
}

abstract class CameraPreviewState implements CameraState {
  const factory CameraPreviewState(
      {required final List<CameraDescription> deviceCameras,
      required final CameraDescription camera,
      required final CameraController cameraController,
      required final CameraSettings camSettings,
      final ToastMessage? toast}) = _$CameraPreviewStateImpl;

  List<CameraDescription> get deviceCameras;
  CameraDescription get camera;
  CameraController get cameraController;
  CameraSettings get camSettings;
  @override
  ToastMessage? get toast;

  /// Create a copy of CameraState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CameraPreviewStateImplCopyWith<_$CameraPreviewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CameraRecordingStateImplCopyWith<$Res>
    implements $CameraStateCopyWith<$Res> {
  factory _$$CameraRecordingStateImplCopyWith(_$CameraRecordingStateImpl value,
          $Res Function(_$CameraRecordingStateImpl) then) =
      __$$CameraRecordingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CameraDescription camera,
      CameraController controller,
      CameraSettings camSettings,
      ToastMessage? toast});

  $CameraSettingsCopyWith<$Res> get camSettings;
  @override
  $ToastMessageCopyWith<$Res>? get toast;
}

/// @nodoc
class __$$CameraRecordingStateImplCopyWithImpl<$Res>
    extends _$CameraStateCopyWithImpl<$Res, _$CameraRecordingStateImpl>
    implements _$$CameraRecordingStateImplCopyWith<$Res> {
  __$$CameraRecordingStateImplCopyWithImpl(_$CameraRecordingStateImpl _value,
      $Res Function(_$CameraRecordingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CameraState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? camera = null,
    Object? controller = null,
    Object? camSettings = null,
    Object? toast = freezed,
  }) {
    return _then(_$CameraRecordingStateImpl(
      camera: null == camera
          ? _value.camera
          : camera // ignore: cast_nullable_to_non_nullable
              as CameraDescription,
      controller: null == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as CameraController,
      camSettings: null == camSettings
          ? _value.camSettings
          : camSettings // ignore: cast_nullable_to_non_nullable
              as CameraSettings,
      toast: freezed == toast
          ? _value.toast
          : toast // ignore: cast_nullable_to_non_nullable
              as ToastMessage?,
    ));
  }

  /// Create a copy of CameraState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CameraSettingsCopyWith<$Res> get camSettings {
    return $CameraSettingsCopyWith<$Res>(_value.camSettings, (value) {
      return _then(_value.copyWith(camSettings: value));
    });
  }
}

/// @nodoc

class _$CameraRecordingStateImpl implements CameraRecordingState {
  const _$CameraRecordingStateImpl(
      {required this.camera,
      required this.controller,
      required this.camSettings,
      this.toast});

  @override
  final CameraDescription camera;
  @override
  final CameraController controller;
  @override
  final CameraSettings camSettings;
  @override
  final ToastMessage? toast;

  @override
  String toString() {
    return 'CameraState.recording(camera: $camera, controller: $controller, camSettings: $camSettings, toast: $toast)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraRecordingStateImpl &&
            (identical(other.camera, camera) || other.camera == camera) &&
            (identical(other.controller, controller) ||
                other.controller == controller) &&
            (identical(other.camSettings, camSettings) ||
                other.camSettings == camSettings) &&
            (identical(other.toast, toast) || other.toast == toast));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, camera, controller, camSettings, toast);

  /// Create a copy of CameraState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CameraRecordingStateImplCopyWith<_$CameraRecordingStateImpl>
      get copyWith =>
          __$$CameraRecordingStateImplCopyWithImpl<_$CameraRecordingStateImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ToastMessage? toast) loading,
    required TResult Function(ToastMessage? toast) uninitialized,
    required TResult Function(
            List<CameraDescription> deviceCameras, ToastMessage? toast)
        initialized,
    required TResult Function(
            List<CameraDescription> deviceCameras,
            CameraDescription camera,
            CameraController cameraController,
            CameraSettings camSettings,
            ToastMessage? toast)
        preview,
    required TResult Function(
            CameraDescription camera,
            CameraController controller,
            CameraSettings camSettings,
            ToastMessage? toast)
        recording,
  }) {
    return recording(camera, controller, camSettings, toast);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ToastMessage? toast)? loading,
    TResult? Function(ToastMessage? toast)? uninitialized,
    TResult? Function(
            List<CameraDescription> deviceCameras, ToastMessage? toast)?
        initialized,
    TResult? Function(
            List<CameraDescription> deviceCameras,
            CameraDescription camera,
            CameraController cameraController,
            CameraSettings camSettings,
            ToastMessage? toast)?
        preview,
    TResult? Function(CameraDescription camera, CameraController controller,
            CameraSettings camSettings, ToastMessage? toast)?
        recording,
  }) {
    return recording?.call(camera, controller, camSettings, toast);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ToastMessage? toast)? loading,
    TResult Function(ToastMessage? toast)? uninitialized,
    TResult Function(
            List<CameraDescription> deviceCameras, ToastMessage? toast)?
        initialized,
    TResult Function(
            List<CameraDescription> deviceCameras,
            CameraDescription camera,
            CameraController cameraController,
            CameraSettings camSettings,
            ToastMessage? toast)?
        preview,
    TResult Function(CameraDescription camera, CameraController controller,
            CameraSettings camSettings, ToastMessage? toast)?
        recording,
    required TResult orElse(),
  }) {
    if (recording != null) {
      return recording(camera, controller, camSettings, toast);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CameraLoadingState value) loading,
    required TResult Function(CameraUninitializedState value) uninitialized,
    required TResult Function(CameraInitializedState value) initialized,
    required TResult Function(CameraPreviewState value) preview,
    required TResult Function(CameraRecordingState value) recording,
  }) {
    return recording(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CameraLoadingState value)? loading,
    TResult? Function(CameraUninitializedState value)? uninitialized,
    TResult? Function(CameraInitializedState value)? initialized,
    TResult? Function(CameraPreviewState value)? preview,
    TResult? Function(CameraRecordingState value)? recording,
  }) {
    return recording?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CameraLoadingState value)? loading,
    TResult Function(CameraUninitializedState value)? uninitialized,
    TResult Function(CameraInitializedState value)? initialized,
    TResult Function(CameraPreviewState value)? preview,
    TResult Function(CameraRecordingState value)? recording,
    required TResult orElse(),
  }) {
    if (recording != null) {
      return recording(this);
    }
    return orElse();
  }
}

abstract class CameraRecordingState implements CameraState {
  const factory CameraRecordingState(
      {required final CameraDescription camera,
      required final CameraController controller,
      required final CameraSettings camSettings,
      final ToastMessage? toast}) = _$CameraRecordingStateImpl;

  CameraDescription get camera;
  CameraController get controller;
  CameraSettings get camSettings;
  @override
  ToastMessage? get toast;

  /// Create a copy of CameraState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CameraRecordingStateImplCopyWith<_$CameraRecordingStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
