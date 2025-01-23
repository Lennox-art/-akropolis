import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class AppUser {
  final String id;

  String displayName;

  final String username;

  final String email;

  String? profilePicture;

  AppUser({
    required this.id,
    required this.displayName,
    required this.username,
    required this.email,
    this.profilePicture,
  });

  static const String collection = "user";

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}

