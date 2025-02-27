import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
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
      FirebaseAuthError firebaseAuthError = FirebaseAuthError.fromCode(e.code);
      return Result.error(
        failure: AppFailure(
          message: firebaseAuthError.description,
          trace: trace,
          failureType: FailureType.networkServerFailure,
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
    } on FirebaseAuthException catch (e, trace) {
      FirebaseAuthError firebaseAuthError = FirebaseAuthError.fromCode(e.code);
      return Result.error(
        failure: AppFailure(
          message: firebaseAuthError.description,
          trace: trace,
          failureType: FailureType.networkServerFailure,
        ),
      );
    }catch (e, trace) {
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
      FirebaseAuthError firebaseAuthError = FirebaseAuthError.fromCode(e.code);
      return Result.error(
        failure: AppFailure(
          message: firebaseAuthError.description,
          trace: trace,
          failureType: FailureType.networkServerFailure,
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
