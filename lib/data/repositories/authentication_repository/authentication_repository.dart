import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  Future<Result<User>> getCurrentUser();

  Future<Result<User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Result<User>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Result<User>> signInWithGoogle();

  Future<Result<void>> resetPassword({
    required String email,
  });

  Future<Result<void>> logout();
}
