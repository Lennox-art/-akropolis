import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:exception_base/exception_base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Result<void>> logout() async {
    try {
      await _firebaseAuth.signOut();
      return const Result.success(data: null);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<void>> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return const Result.success(data: null);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<User>> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      UserCredential? userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user == null) {
        return Result.error(
          failure: AppFailure(
            message: "Failed to sign in",
            trace: userCredential,
          ),
        );
      }

      return Result.success(data: user);
    } on FirebaseAuthException catch (e, trace) {
      if (e.code == 'user-not-found') {
        return Result.error(
          failure: AppFailure(
            message: 'No account found with this email.',
            trace: trace,
            failureType: FailureType.networkServerFailure,
          ),
        );
      }
      if (e.code == 'wrong-password') {
        return Result.error(
          failure: AppFailure(
            message: 'Incorrect password',
            trace: trace,
            failureType: FailureType.networkServerFailure,
          ),
        );
      }
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<User>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential? userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      User? user = userCredential.user;
      if (user == null) {
        return Result.error(
          failure: AppFailure(
            message: "Sign in with google failed",
            trace: userCredential,
          ),
        );
      }

      return Result.success(data: user);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<User>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential? userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user == null) {
        return Result.error(
          failure: AppFailure(
            message: "Failed to sign in",
            trace: userCredential,
          ),
        );
      }

      return Result.success(data: user);
    } on FirebaseAuthException catch (e, trace) {
      if (e.code == 'email-already-in-use') {
        return Result.error(
          failure: AppFailure(
            message: 'An account with this email already exists',
            trace: trace,
            failureType: FailureType.networkServerFailure,
          ),
        );
      }
      rethrow;
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<User>> getCurrentUser() async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user == null) {
        return Result.error(
          failure: AppFailure(
            message: "No current user",
          ),
        );
      }

      return Result.success(data: user);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }
}
