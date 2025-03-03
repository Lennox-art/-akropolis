import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_models.g.dart';

enum FirebaseAuthError {
  invalidCredential("Invalid email or password."),
  userNotFound("No account found with this email."),
  wrongPassword("Incorrect password."),
  emailAlreadyInUse("This email is already in use."),
  invalidEmail("Please enter a valid email."),
  weakPassword("Your password is too weak."),
  userDisabled("This account has been disabled."),
  tooManyRequests("Too many failed attempts. Try again later."),
  operationNotAllowed("This operation is not allowed."),
  networkError("Network error. Check your connection."),
  unknown("An unknown error occurred. Please try again.");

  final String description;
  const FirebaseAuthError(this.description);

  /// Convert FirebaseAuthException code to our enum
  static FirebaseAuthError fromCode(String code) {
    switch (code) {
      case 'invalid-credential':
        return FirebaseAuthError.invalidCredential;
      case 'user-not-found':
        return FirebaseAuthError.userNotFound;
      case 'wrong-password':
        return FirebaseAuthError.wrongPassword;
      case 'email-already-in-use':
        return FirebaseAuthError.emailAlreadyInUse;
      case 'invalid-email':
        return FirebaseAuthError.invalidEmail;
      case 'weak-password':
        return FirebaseAuthError.weakPassword;
      case 'user-disabled':
        return FirebaseAuthError.userDisabled;
      case 'too-many-requests':
        return FirebaseAuthError.tooManyRequests;
      case 'operation-not-allowed':
        return FirebaseAuthError.operationNotAllowed;
      case 'network-request-failed':
        return FirebaseAuthError.networkError;
      default:
        return FirebaseAuthError.unknown;
    }
  }
}

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

//enum AuthorType { journalist, editor }
enum AuthorType {
  user,
  publisher;

  static Map<String, AuthorType> authorTypeEnumMap = {
    for (var e in values) e.name: e
  };
}

class Author {
  final String id;
  final String name;
  final String? imageUrl;
  final AuthorType type;

  Author({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.type,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    id: json['id'] as String,
    name: json['name'] as String,
    imageUrl: json['imageUrl'] as String?,
    type: AuthorType.authorTypeEnumMap[json['type']]!,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    'imageUrl': imageUrl,
    'type': type.name,
  };
}

class NewsPost {
  final String id;
  final String thumbnailUrl;
  final String postUrl;
  final String title;
  final String description;
  final Author author;
  final DateTime publishedAt;
  final Set<String> viewers;
  final PostReaction reaction;

  NewsPost({
    required this.id,
    required this.thumbnailUrl,
    required this.postUrl,
    required this.title,
    required this.description,
    required this.author,
    required this.viewers,
    required this.publishedAt,
    required this.reaction,
  });

  factory NewsPost.fromJson(Map<String, dynamic> json) => NewsPost(
    id: json['id'] as String,
    thumbnailUrl: json['thumbnailUrl'] as String,
    postUrl: json['postUrl'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    author: Author.fromJson(json['author'] as Map<String, dynamic>),
    viewers:
    (json['viewers'] as List<dynamic>).map((e) => e as String).toSet(),
    publishedAt: DateTime.parse(json['publishedAt'] as String),
    reaction:
    PostReaction.fromJson(json['reaction'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'thumbnailUrl': thumbnailUrl,
    'postUrl': postUrl,
    'title': title,
    'description': description,
    'author': author.toJson(),
    'publishedAt': publishedAt.toIso8601String(),
    'viewers': viewers.toList(),
    'reaction': reaction.toJson(),
  };

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    if(other is! NewsPost) return false;
    return id == other.id;
  }
}

class PostReaction {
  final Set<String> log;
  final Set<String> emp;

  PostReaction({
    required this.log,
    required this.emp,
  });

  factory PostReaction.fromJson(Map<String, dynamic> json) => PostReaction(
    log: (json['log'] as List<dynamic>).map((e) => e as String).toSet(),
    emp: (json['emp'] as List<dynamic>).map((e) => e as String).toSet(),
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'log': log.toList(),
    'emp': emp.toList(),
  };
}

class PostComment {
  final String id;
  final String postId;
  final String thumbnailUrl;
  final String postUrl;
  final Author author;
  final DateTime commentedAt;
  final PostReaction reaction;

  PostComment({
    required this.id,
    required this.postId,
    required this.thumbnailUrl,
    required this.postUrl,
    required this.author,
    required this.commentedAt,
    required this.reaction,
  });

  static const collection = 'comments';

  factory PostComment.fromJson(Map<String, dynamic> json) => PostComment(
    id: json['id'] as String,
    postId: json['postId'] as String,
    thumbnailUrl: json['thumbnailUrl'] as String,
    postUrl: json['postUrl'] as String,
    author: Author.fromJson(json['author'] as Map<String, dynamic>),
    commentedAt: DateTime.parse(json['commentedAt'] as String),
    reaction: PostReaction.fromJson(json['reaction'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'postId': postId,
    'thumbnailUrl': thumbnailUrl,
    'postUrl': postUrl,
    'author': author.toJson(),
    'commentedAt': commentedAt.toIso8601String(),
    'reaction': reaction.toJson(),
  };
}