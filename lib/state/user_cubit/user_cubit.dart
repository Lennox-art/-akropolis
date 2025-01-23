import 'package:akropolis/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.dart';

part 'user_cubit.freezed.dart';

class UserCubit extends Cubit<UserState> {

  final Map<String, AppUser> userCache = {};

  final CollectionReference userCollectionRef = FirebaseFirestore
      .instance
      .collection(AppUser.collection)
      .withConverter<AppUser>(
    fromFirestore: (snapshot, _) => AppUser.fromJson(snapshot.data()!),
    toFirestore: (model, _) => model.toJson(),
  );

  UserCubit() : super(const UserState.loaded());

  Future<void> saveAppUser(AppUser user) async {
    emit(const LoadingUserState());
    await userCollectionRef.doc(user.id).set(user);
    userCache.putIfAbsent(user.id, () => user);
    emit(const LoadedUserState());
  }

  Future<AppUser?> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if(user == null) return null;
    return findUserById(user.uid);
  }

  Future<AppUser?> findUserById(String id) async {
    if(userCache.containsKey(id)) return userCache[id];
    var data = await userCollectionRef.doc(id).get();
    AppUser? user = data.data() as AppUser?;

    if(user != null) {
      userCache.putIfAbsent(user.id, () => user);
    }

    return user;
  }

}
