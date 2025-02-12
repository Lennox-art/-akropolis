// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_news_post_reply_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PostVideoReplyState {
  ToastMessage? get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? postId, ToastMessage? message, UploadProgress? progress)
        loading,
    required TResult Function(ToastMessage? message, CreatePostForm? replyForm)
        loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? postId, ToastMessage? message, UploadProgress? progress)?
        loading,
    TResult? Function(ToastMessage? message, CreatePostForm? replyForm)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? postId, ToastMessage? message, UploadProgress? progress)?
        loading,
    TResult Function(ToastMessage? message, CreatePostForm? replyForm)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingPostVideoReplyState value) loading,
    required TResult Function(LoadedPostVideoReplyState value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingPostVideoReplyState value)? loading,
    TResult? Function(LoadedPostVideoReplyState value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingPostVideoReplyState value)? loading,
    TResult Function(LoadedPostVideoReplyState value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of PostVideoReplyState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostVideoReplyStateCopyWith<PostVideoReplyState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostVideoReplyStateCopyWith<$Res> {
  factory $PostVideoReplyStateCopyWith(
          PostVideoReplyState value, $Res Function(PostVideoReplyState) then) =
      _$PostVideoReplyStateCopyWithImpl<$Res, PostVideoReplyState>;
  @useResult
  $Res call({ToastMessage? message});

  $ToastMessageCopyWith<$Res>? get message;
}

/// @nodoc
class _$PostVideoReplyStateCopyWithImpl<$Res, $Val extends PostVideoReplyState>
    implements $PostVideoReplyStateCopyWith<$Res> {
  _$PostVideoReplyStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostVideoReplyState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as ToastMessage?,
    ) as $Val);
  }

  /// Create a copy of PostVideoReplyState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ToastMessageCopyWith<$Res>? get message {
    if (_value.message == null) {
      return null;
    }

    return $ToastMessageCopyWith<$Res>(_value.message!, (value) {
      return _then(_value.copyWith(message: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoadingPostVideoReplyStateImplCopyWith<$Res>
    implements $PostVideoReplyStateCopyWith<$Res> {
  factory _$$LoadingPostVideoReplyStateImplCopyWith(
          _$LoadingPostVideoReplyStateImpl value,
          $Res Function(_$LoadingPostVideoReplyStateImpl) then) =
      __$$LoadingPostVideoReplyStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? postId, ToastMessage? message, UploadProgress? progress});

  @override
  $ToastMessageCopyWith<$Res>? get message;
}

/// @nodoc
class __$$LoadingPostVideoReplyStateImplCopyWithImpl<$Res>
    extends _$PostVideoReplyStateCopyWithImpl<$Res,
        _$LoadingPostVideoReplyStateImpl>
    implements _$$LoadingPostVideoReplyStateImplCopyWith<$Res> {
  __$$LoadingPostVideoReplyStateImplCopyWithImpl(
      _$LoadingPostVideoReplyStateImpl _value,
      $Res Function(_$LoadingPostVideoReplyStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostVideoReplyState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = freezed,
    Object? message = freezed,
    Object? progress = freezed,
  }) {
    return _then(_$LoadingPostVideoReplyStateImpl(
      postId: freezed == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String?,
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
}

/// @nodoc

class _$LoadingPostVideoReplyStateImpl implements LoadingPostVideoReplyState {
  const _$LoadingPostVideoReplyStateImpl(
      {this.postId, this.message, this.progress});

  @override
  final String? postId;
  @override
  final ToastMessage? message;
  @override
  final UploadProgress? progress;

  @override
  String toString() {
    return 'PostVideoReplyState.loading(postId: $postId, message: $message, progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingPostVideoReplyStateImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postId, message, progress);

  /// Create a copy of PostVideoReplyState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingPostVideoReplyStateImplCopyWith<_$LoadingPostVideoReplyStateImpl>
      get copyWith => __$$LoadingPostVideoReplyStateImplCopyWithImpl<
          _$LoadingPostVideoReplyStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? postId, ToastMessage? message, UploadProgress? progress)
        loading,
    required TResult Function(ToastMessage? message, CreatePostForm? replyForm)
        loaded,
  }) {
    return loading(postId, message, progress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? postId, ToastMessage? message, UploadProgress? progress)?
        loading,
    TResult? Function(ToastMessage? message, CreatePostForm? replyForm)? loaded,
  }) {
    return loading?.call(postId, message, progress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? postId, ToastMessage? message, UploadProgress? progress)?
        loading,
    TResult Function(ToastMessage? message, CreatePostForm? replyForm)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(postId, message, progress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingPostVideoReplyState value) loading,
    required TResult Function(LoadedPostVideoReplyState value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingPostVideoReplyState value)? loading,
    TResult? Function(LoadedPostVideoReplyState value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingPostVideoReplyState value)? loading,
    TResult Function(LoadedPostVideoReplyState value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LoadingPostVideoReplyState implements PostVideoReplyState {
  const factory LoadingPostVideoReplyState(
      {final String? postId,
      final ToastMessage? message,
      final UploadProgress? progress}) = _$LoadingPostVideoReplyStateImpl;

  String? get postId;
  @override
  ToastMessage? get message;
  UploadProgress? get progress;

  /// Create a copy of PostVideoReplyState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingPostVideoReplyStateImplCopyWith<_$LoadingPostVideoReplyStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedPostVideoReplyStateImplCopyWith<$Res>
    implements $PostVideoReplyStateCopyWith<$Res> {
  factory _$$LoadedPostVideoReplyStateImplCopyWith(
          _$LoadedPostVideoReplyStateImpl value,
          $Res Function(_$LoadedPostVideoReplyStateImpl) then) =
      __$$LoadedPostVideoReplyStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ToastMessage? message, CreatePostForm? replyForm});

  @override
  $ToastMessageCopyWith<$Res>? get message;
  $CreatePostFormCopyWith<$Res>? get replyForm;
}

/// @nodoc
class __$$LoadedPostVideoReplyStateImplCopyWithImpl<$Res>
    extends _$PostVideoReplyStateCopyWithImpl<$Res,
        _$LoadedPostVideoReplyStateImpl>
    implements _$$LoadedPostVideoReplyStateImplCopyWith<$Res> {
  __$$LoadedPostVideoReplyStateImplCopyWithImpl(
      _$LoadedPostVideoReplyStateImpl _value,
      $Res Function(_$LoadedPostVideoReplyStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostVideoReplyState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? replyForm = freezed,
  }) {
    return _then(_$LoadedPostVideoReplyStateImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as ToastMessage?,
      replyForm: freezed == replyForm
          ? _value.replyForm
          : replyForm // ignore: cast_nullable_to_non_nullable
              as CreatePostForm?,
    ));
  }

  /// Create a copy of PostVideoReplyState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CreatePostFormCopyWith<$Res>? get replyForm {
    if (_value.replyForm == null) {
      return null;
    }

    return $CreatePostFormCopyWith<$Res>(_value.replyForm!, (value) {
      return _then(_value.copyWith(replyForm: value));
    });
  }
}

/// @nodoc

class _$LoadedPostVideoReplyStateImpl implements LoadedPostVideoReplyState {
  const _$LoadedPostVideoReplyStateImpl({this.message, this.replyForm});

  @override
  final ToastMessage? message;
  @override
  final CreatePostForm? replyForm;

  @override
  String toString() {
    return 'PostVideoReplyState.loaded(message: $message, replyForm: $replyForm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedPostVideoReplyStateImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.replyForm, replyForm) ||
                other.replyForm == replyForm));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, replyForm);

  /// Create a copy of PostVideoReplyState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedPostVideoReplyStateImplCopyWith<_$LoadedPostVideoReplyStateImpl>
      get copyWith => __$$LoadedPostVideoReplyStateImplCopyWithImpl<
          _$LoadedPostVideoReplyStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? postId, ToastMessage? message, UploadProgress? progress)
        loading,
    required TResult Function(ToastMessage? message, CreatePostForm? replyForm)
        loaded,
  }) {
    return loaded(message, replyForm);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? postId, ToastMessage? message, UploadProgress? progress)?
        loading,
    TResult? Function(ToastMessage? message, CreatePostForm? replyForm)? loaded,
  }) {
    return loaded?.call(message, replyForm);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? postId, ToastMessage? message, UploadProgress? progress)?
        loading,
    TResult Function(ToastMessage? message, CreatePostForm? replyForm)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(message, replyForm);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingPostVideoReplyState value) loading,
    required TResult Function(LoadedPostVideoReplyState value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingPostVideoReplyState value)? loading,
    TResult? Function(LoadedPostVideoReplyState value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingPostVideoReplyState value)? loading,
    TResult Function(LoadedPostVideoReplyState value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class LoadedPostVideoReplyState implements PostVideoReplyState {
  const factory LoadedPostVideoReplyState(
      {final ToastMessage? message,
      final CreatePostForm? replyForm}) = _$LoadedPostVideoReplyStateImpl;

  @override
  ToastMessage? get message;
  CreatePostForm? get replyForm;

  /// Create a copy of PostVideoReplyState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedPostVideoReplyStateImplCopyWith<_$LoadedPostVideoReplyStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
