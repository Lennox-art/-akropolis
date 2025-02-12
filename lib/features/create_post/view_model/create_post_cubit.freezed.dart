// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_post_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreatePostState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ToastMessage? message, UploadProgress? progress)
        loading,
    required TResult Function(ToastMessage? toast, CreatePostForm? form) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ToastMessage? message, UploadProgress? progress)? loading,
    TResult? Function(ToastMessage? toast, CreatePostForm? form)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ToastMessage? message, UploadProgress? progress)? loading,
    TResult Function(ToastMessage? toast, CreatePostForm? form)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingPostState value) loading,
    required TResult Function(LoadedPostState value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingPostState value)? loading,
    TResult? Function(LoadedPostState value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingPostState value)? loading,
    TResult Function(LoadedPostState value)? loaded,
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
abstract class _$$LoadingPostStateImplCopyWith<$Res> {
  factory _$$LoadingPostStateImplCopyWith(_$LoadingPostStateImpl value,
          $Res Function(_$LoadingPostStateImpl) then) =
      __$$LoadingPostStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ToastMessage? message, UploadProgress? progress});

  $ToastMessageCopyWith<$Res>? get message;
}

/// @nodoc
class __$$LoadingPostStateImplCopyWithImpl<$Res>
    extends _$CreatePostStateCopyWithImpl<$Res, _$LoadingPostStateImpl>
    implements _$$LoadingPostStateImplCopyWith<$Res> {
  __$$LoadingPostStateImplCopyWithImpl(_$LoadingPostStateImpl _value,
      $Res Function(_$LoadingPostStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreatePostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? progress = freezed,
  }) {
    return _then(_$LoadingPostStateImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as ToastMessage?,
      progress: freezed == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as UploadProgress?,
    ));
  }

  /// Create a copy of CreatePostState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ToastMessageCopyWith<$Res>? get message {
    if (_value.message == null) {
      return null;
    }

    return $ToastMessageCopyWith<$Res>(_value.message!, (value) {
      return _then(_value.copyWith(message: value));
    });
  }
}

/// @nodoc

class _$LoadingPostStateImpl implements LoadingPostState {
  const _$LoadingPostStateImpl({this.message, this.progress});

  @override
  final ToastMessage? message;
  @override
  final UploadProgress? progress;

  @override
  String toString() {
    return 'CreatePostState.loading(message: $message, progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingPostStateImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, progress);

  /// Create a copy of CreatePostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingPostStateImplCopyWith<_$LoadingPostStateImpl> get copyWith =>
      __$$LoadingPostStateImplCopyWithImpl<_$LoadingPostStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ToastMessage? message, UploadProgress? progress)
        loading,
    required TResult Function(ToastMessage? toast, CreatePostForm? form) loaded,
  }) {
    return loading(message, progress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ToastMessage? message, UploadProgress? progress)? loading,
    TResult? Function(ToastMessage? toast, CreatePostForm? form)? loaded,
  }) {
    return loading?.call(message, progress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ToastMessage? message, UploadProgress? progress)? loading,
    TResult Function(ToastMessage? toast, CreatePostForm? form)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(message, progress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingPostState value) loading,
    required TResult Function(LoadedPostState value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingPostState value)? loading,
    TResult? Function(LoadedPostState value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingPostState value)? loading,
    TResult Function(LoadedPostState value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LoadingPostState implements CreatePostState {
  const factory LoadingPostState(
      {final ToastMessage? message,
      final UploadProgress? progress}) = _$LoadingPostStateImpl;

  ToastMessage? get message;
  UploadProgress? get progress;

  /// Create a copy of CreatePostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingPostStateImplCopyWith<_$LoadingPostStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedPostStateImplCopyWith<$Res> {
  factory _$$LoadedPostStateImplCopyWith(_$LoadedPostStateImpl value,
          $Res Function(_$LoadedPostStateImpl) then) =
      __$$LoadedPostStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ToastMessage? toast, CreatePostForm? form});

  $ToastMessageCopyWith<$Res>? get toast;
  $CreatePostFormCopyWith<$Res>? get form;
}

/// @nodoc
class __$$LoadedPostStateImplCopyWithImpl<$Res>
    extends _$CreatePostStateCopyWithImpl<$Res, _$LoadedPostStateImpl>
    implements _$$LoadedPostStateImplCopyWith<$Res> {
  __$$LoadedPostStateImplCopyWithImpl(
      _$LoadedPostStateImpl _value, $Res Function(_$LoadedPostStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreatePostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? toast = freezed,
    Object? form = freezed,
  }) {
    return _then(_$LoadedPostStateImpl(
      toast: freezed == toast
          ? _value.toast
          : toast // ignore: cast_nullable_to_non_nullable
              as ToastMessage?,
      form: freezed == form
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as CreatePostForm?,
    ));
  }

  /// Create a copy of CreatePostState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ToastMessageCopyWith<$Res>? get toast {
    if (_value.toast == null) {
      return null;
    }

    return $ToastMessageCopyWith<$Res>(_value.toast!, (value) {
      return _then(_value.copyWith(toast: value));
    });
  }

  /// Create a copy of CreatePostState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CreatePostFormCopyWith<$Res>? get form {
    if (_value.form == null) {
      return null;
    }

    return $CreatePostFormCopyWith<$Res>(_value.form!, (value) {
      return _then(_value.copyWith(form: value));
    });
  }
}

/// @nodoc

class _$LoadedPostStateImpl implements LoadedPostState {
  const _$LoadedPostStateImpl({this.toast, this.form});

  @override
  final ToastMessage? toast;
  @override
  final CreatePostForm? form;

  @override
  String toString() {
    return 'CreatePostState.loaded(toast: $toast, form: $form)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedPostStateImpl &&
            (identical(other.toast, toast) || other.toast == toast) &&
            (identical(other.form, form) || other.form == form));
  }

  @override
  int get hashCode => Object.hash(runtimeType, toast, form);

  /// Create a copy of CreatePostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedPostStateImplCopyWith<_$LoadedPostStateImpl> get copyWith =>
      __$$LoadedPostStateImplCopyWithImpl<_$LoadedPostStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ToastMessage? message, UploadProgress? progress)
        loading,
    required TResult Function(ToastMessage? toast, CreatePostForm? form) loaded,
  }) {
    return loaded(toast, form);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ToastMessage? message, UploadProgress? progress)? loading,
    TResult? Function(ToastMessage? toast, CreatePostForm? form)? loaded,
  }) {
    return loaded?.call(toast, form);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ToastMessage? message, UploadProgress? progress)? loading,
    TResult Function(ToastMessage? toast, CreatePostForm? form)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(toast, form);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingPostState value) loading,
    required TResult Function(LoadedPostState value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingPostState value)? loading,
    TResult? Function(LoadedPostState value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingPostState value)? loading,
    TResult Function(LoadedPostState value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class LoadedPostState implements CreatePostState {
  const factory LoadedPostState(
      {final ToastMessage? toast,
      final CreatePostForm? form}) = _$LoadedPostStateImpl;

  ToastMessage? get toast;
  CreatePostForm? get form;

  /// Create a copy of CreatePostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedPostStateImplCopyWith<_$LoadedPostStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
