import 'package:akropolis/components/toast/toast.dart';
import 'package:akropolis/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'authentication_state.dart';

part 'authentication_cubit.freezed.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(const AuthenticationState.loaded());

  User? getCurrentUser() => FirebaseAuth.instance.currentUser;

  Future<void> logout() async => await FirebaseAuth.instance.signOut();

  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      emit(const LoadingAuthentication());

      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = credential.user;
      if (user == null) throw Exception("Sign up failed");

      await user.sendEmailVerification();

      emit(
        LoadedAuthentication(
          toast: ToastSuccess(message: "Account created for $email"),
          user: user,
        ),
      );

      return user;
    } catch (e, trace) {
      addError("Error creating account", trace);
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      emit(const LoadingAuthentication());

      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = credential.user;
      if (user == null) throw Exception("Sign in failed");

      emit(
        LoadedAuthentication(
          toast: ToastSuccess(message: "Signed in from ${user.email}"),
          user: user,
        ),
      );
      return user;
    } catch (e, trace) {
      addError("Error signing in", trace);
      return null;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {

      emit(const LoadingAuthentication());

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential? userCredential =
          await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      User? user = userCredential.user;
      if (user == null) throw Exception("Sign in with google failed");

      emit(
        LoadedAuthentication(
          toast: ToastSuccess(message: "Signed in from ${user.email}"),
          user: user,
        ),
      );
      return user;
    } catch (e, trace) {
      addError("Error signing in with google", trace);
      return null;
    }
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    try {
      emit(const LoadingAuthentication());

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      emit(
        LoadedAuthentication(
          toast: ToastSuccess(message: "Check $email for email"),
        ),
      );
    } catch (e, trace) {
      addError("Error signing in", trace);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    log.error(error, trace: stackTrace);


    emit(
      LoadedAuthentication(
        toast: ToastError(
          message: error.toString(),
        ),
      ),
    );
    super.onError(error, stackTrace);
  }
}
