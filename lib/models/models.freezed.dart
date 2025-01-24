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
mixin _$ToastMessage {
  String get title => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title, String message) error,
    required TResult Function(String title, String message) success,
    required TResult Function(String title, String message) info,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title, String message)? error,
    TResult? Function(String title, String message)? success,
    TResult? Function(String title, String message)? info,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title, String message)? error,
    TResult Function(String title, String message)? success,
    TResult Function(String title, String message)? info,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ToastError value) error,
    required TResult Function(ToastSuccess value) success,
    required TResult Function(ToastInfo value) info,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ToastError value)? error,
    TResult? Function(ToastSuccess value)? success,
    TResult? Function(ToastInfo value)? info,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ToastError value)? error,
    TResult Function(ToastSuccess value)? success,
    TResult Function(ToastInfo value)? info,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of ToastMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ToastMessageCopyWith<ToastMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ToastMessageCopyWith<$Res> {
  factory $ToastMessageCopyWith(
          ToastMessage value, $Res Function(ToastMessage) then) =
      _$ToastMessageCopyWithImpl<$Res, ToastMessage>;
  @useResult
  $Res call({String title, String message});
}

/// @nodoc
class _$ToastMessageCopyWithImpl<$Res, $Val extends ToastMessage>
    implements $ToastMessageCopyWith<$Res> {
  _$ToastMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ToastMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ToastErrorImplCopyWith<$Res>
    implements $ToastMessageCopyWith<$Res> {
  factory _$$ToastErrorImplCopyWith(
          _$ToastErrorImpl value, $Res Function(_$ToastErrorImpl) then) =
      __$$ToastErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String message});
}

/// @nodoc
class __$$ToastErrorImplCopyWithImpl<$Res>
    extends _$ToastMessageCopyWithImpl<$Res, _$ToastErrorImpl>
    implements _$$ToastErrorImplCopyWith<$Res> {
  __$$ToastErrorImplCopyWithImpl(
      _$ToastErrorImpl _value, $Res Function(_$ToastErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ToastMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
  }) {
    return _then(_$ToastErrorImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ToastErrorImpl implements ToastError {
  const _$ToastErrorImpl(
      {this.title = "Error", this.message = 'Something went wrong'});

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'ToastMessage.error(title: $title, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToastErrorImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, message);

  /// Create a copy of ToastMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToastErrorImplCopyWith<_$ToastErrorImpl> get copyWith =>
      __$$ToastErrorImplCopyWithImpl<_$ToastErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title, String message) error,
    required TResult Function(String title, String message) success,
    required TResult Function(String title, String message) info,
  }) {
    return error(title, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title, String message)? error,
    TResult? Function(String title, String message)? success,
    TResult? Function(String title, String message)? info,
  }) {
    return error?.call(title, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title, String message)? error,
    TResult Function(String title, String message)? success,
    TResult Function(String title, String message)? info,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(title, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ToastError value) error,
    required TResult Function(ToastSuccess value) success,
    required TResult Function(ToastInfo value) info,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ToastError value)? error,
    TResult? Function(ToastSuccess value)? success,
    TResult? Function(ToastInfo value)? info,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ToastError value)? error,
    TResult Function(ToastSuccess value)? success,
    TResult Function(ToastInfo value)? info,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ToastError implements ToastMessage {
  const factory ToastError({final String title, final String message}) =
      _$ToastErrorImpl;

  @override
  String get title;
  @override
  String get message;

  /// Create a copy of ToastMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToastErrorImplCopyWith<_$ToastErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToastSuccessImplCopyWith<$Res>
    implements $ToastMessageCopyWith<$Res> {
  factory _$$ToastSuccessImplCopyWith(
          _$ToastSuccessImpl value, $Res Function(_$ToastSuccessImpl) then) =
      __$$ToastSuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String message});
}

/// @nodoc
class __$$ToastSuccessImplCopyWithImpl<$Res>
    extends _$ToastMessageCopyWithImpl<$Res, _$ToastSuccessImpl>
    implements _$$ToastSuccessImplCopyWith<$Res> {
  __$$ToastSuccessImplCopyWithImpl(
      _$ToastSuccessImpl _value, $Res Function(_$ToastSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of ToastMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
  }) {
    return _then(_$ToastSuccessImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ToastSuccessImpl implements ToastSuccess {
  const _$ToastSuccessImpl({this.title = "Success", required this.message});

  @override
  @JsonKey()
  final String title;
  @override
  final String message;

  @override
  String toString() {
    return 'ToastMessage.success(title: $title, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToastSuccessImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, message);

  /// Create a copy of ToastMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToastSuccessImplCopyWith<_$ToastSuccessImpl> get copyWith =>
      __$$ToastSuccessImplCopyWithImpl<_$ToastSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title, String message) error,
    required TResult Function(String title, String message) success,
    required TResult Function(String title, String message) info,
  }) {
    return success(title, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title, String message)? error,
    TResult? Function(String title, String message)? success,
    TResult? Function(String title, String message)? info,
  }) {
    return success?.call(title, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title, String message)? error,
    TResult Function(String title, String message)? success,
    TResult Function(String title, String message)? info,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(title, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ToastError value) error,
    required TResult Function(ToastSuccess value) success,
    required TResult Function(ToastInfo value) info,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ToastError value)? error,
    TResult? Function(ToastSuccess value)? success,
    TResult? Function(ToastInfo value)? info,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ToastError value)? error,
    TResult Function(ToastSuccess value)? success,
    TResult Function(ToastInfo value)? info,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class ToastSuccess implements ToastMessage {
  const factory ToastSuccess(
      {final String title, required final String message}) = _$ToastSuccessImpl;

  @override
  String get title;
  @override
  String get message;

  /// Create a copy of ToastMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToastSuccessImplCopyWith<_$ToastSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToastInfoImplCopyWith<$Res>
    implements $ToastMessageCopyWith<$Res> {
  factory _$$ToastInfoImplCopyWith(
          _$ToastInfoImpl value, $Res Function(_$ToastInfoImpl) then) =
      __$$ToastInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String message});
}

/// @nodoc
class __$$ToastInfoImplCopyWithImpl<$Res>
    extends _$ToastMessageCopyWithImpl<$Res, _$ToastInfoImpl>
    implements _$$ToastInfoImplCopyWith<$Res> {
  __$$ToastInfoImplCopyWithImpl(
      _$ToastInfoImpl _value, $Res Function(_$ToastInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of ToastMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
  }) {
    return _then(_$ToastInfoImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ToastInfoImpl implements ToastInfo {
  const _$ToastInfoImpl({this.title = "Info", required this.message});

  @override
  @JsonKey()
  final String title;
  @override
  final String message;

  @override
  String toString() {
    return 'ToastMessage.info(title: $title, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToastInfoImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, message);

  /// Create a copy of ToastMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToastInfoImplCopyWith<_$ToastInfoImpl> get copyWith =>
      __$$ToastInfoImplCopyWithImpl<_$ToastInfoImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title, String message) error,
    required TResult Function(String title, String message) success,
    required TResult Function(String title, String message) info,
  }) {
    return info(title, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title, String message)? error,
    TResult? Function(String title, String message)? success,
    TResult? Function(String title, String message)? info,
  }) {
    return info?.call(title, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title, String message)? error,
    TResult Function(String title, String message)? success,
    TResult Function(String title, String message)? info,
    required TResult orElse(),
  }) {
    if (info != null) {
      return info(title, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ToastError value) error,
    required TResult Function(ToastSuccess value) success,
    required TResult Function(ToastInfo value) info,
  }) {
    return info(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ToastError value)? error,
    TResult? Function(ToastSuccess value)? success,
    TResult? Function(ToastInfo value)? info,
  }) {
    return info?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ToastError value)? error,
    TResult Function(ToastSuccess value)? success,
    TResult Function(ToastInfo value)? info,
    required TResult orElse(),
  }) {
    if (info != null) {
      return info(this);
    }
    return orElse();
  }
}

abstract class ToastInfo implements ToastMessage {
  const factory ToastInfo({final String title, required final String message}) =
      _$ToastInfoImpl;

  @override
  String get title;
  @override
  String get message;

  /// Create a copy of ToastMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToastInfoImplCopyWith<_$ToastInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
