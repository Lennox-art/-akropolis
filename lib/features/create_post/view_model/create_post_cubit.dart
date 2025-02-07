import 'dart:io';

import 'package:akropolis/features/create_post/models/models.dart';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_post_state.dart';

part 'create_post_cubit.freezed.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostForm? form;

  CreatePostCubit() : super(const CreatePostState.loaded());

  Future<void> createNewPost({
    required XFile file,
    required User user,
  }) async {
    File tempFilePath = await File(file.path).writeAsBytes(
      await file.readAsBytes(),
    );

    form = CreatePostForm.create(
      userId: user.uid,
      videoData: tempFilePath,
    );

    emit(
      LoadedPostState(form: form),
    );
  }

}
