import 'package:akropolis/features/authentication/models/authentication_models.dart';
import 'package:akropolis/components/toast/toast.dart';
import 'package:akropolis/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.dart';

part 'user_cubit.freezed.dart';

class UserCubit extends Cubit<UserState> {
  final Map<String, AppUser> userCache = {};

  final CollectionReference userCollectionRef = FirebaseFirestore.instance
      .collection(AppUser.collection)
      .withConverter<AppUser>(
        fromFirestore: (snapshot, _) => AppUser.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson(),
      );

  UserCubit() : super(const UserState.loaded());

  Future<void> saveAppUser(AppUser user) async {
    try {
      emit(const LoadingUserState());
      await userCollectionRef.doc(user.id).set(user);
      userCache.putIfAbsent(user.id, () => user);
      emit(const LoadedUserState());
    } catch (e, trace) {
      addError("Error saving user ${user.displayName}", trace);
    }
  }

  Future<AppUser?> getCurrentUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;
      return findUserById(user.uid);
    } catch (e, trace) {
      addError("Error getting current user", trace);
      return null;
    }
  }

  Future<AppUser?> findUserById(String id) async {
    try {
      if (userCache.containsKey(id)) return userCache[id];
      var data = await userCollectionRef.doc(id).get();
      AppUser? user = data.data() as AppUser?;

      if (user != null) {
        userCache.putIfAbsent(user.id, () => user);
      }

      return user;
    } catch (e, trace) {
      addError("Error fetching user $id", trace);
      return null;
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    log.error(error, trace: stackTrace);

    emit(
      LoadedUserState(
        toast: ToastError(
          message: error.toString(),
        ),
      ),
    );
    super.onError(error, stackTrace);
  }

}