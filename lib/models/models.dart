import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.g.dart';
part 'models.freezed.dart';


@JsonSerializable()
class AppUser {
  final String id;

  String displayName;

  final String username;

  final String email;

  String? profilePicture;

  Set<String>? topics;

  AppUser({
    required this.id,
    required this.displayName,
    required this.username,
    required this.email,
    this.profilePicture,
    required this.topics,
  });

  static const String collection = "user";

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}


@freezed
class ToastMessage with _$ToastMessage {
  const factory ToastMessage.error({
    @Default("Error") String title,
    @Default('Something went wrong') String message,
  }) = ToastError;

  const factory ToastMessage.success({
    @Default("Success") String title,
    required String message,
  }) = ToastSuccess;

  const factory ToastMessage.info({
    @Default("Info") String title,
    required String message,
  }) = ToastInfo;
}