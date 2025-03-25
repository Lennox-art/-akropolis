import 'dart:async';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/user_repository/user_repository.dart';
import 'package:flutter/cupertino.dart';

class NewThreadViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  StreamController<List<AppUser>> _userStream = StreamController.broadcast();

  NewThreadViewModel({required UserRepository userRepository}) : _userRepository = userRepository;

  Stream<List<AppUser>> get userStream => _userStream.stream;

  Future<void> searchUsers(String displayName) async {

    var userResult = await _userRepository.searchByDisplayName(
      query: displayName,
    );

    switch (userResult) {
      case Success<List<AppUser>>():
        _userStream.add(userResult.data);
        break;
      case Error<List<AppUser>>():
        break;
    }
  }
}
