import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
    emit(const LoadingAuthentication());

    UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = credential.user;

    emit(LoadedAuthentication(user: user));

    return user;
  }

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(const LoadingAuthentication());

    UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = credential.user;

    emit(LoadedAuthentication(user: user));
    return user;
  }
}
