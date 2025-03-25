import 'dart:typed_data';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/local_models/local_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:akropolis/data/repositories/message_repository/message_repository.dart';
import 'package:akropolis/data/repositories/user_repository/user_repository.dart';
import 'package:akropolis/data/services/data_storage_service/local_data_storage_service.dart';
import 'package:akropolis/data/services/file_storage_service/local_file_storage_service.dart';
import 'package:akropolis/data/services/file_storage_service/remote_file_storage_service.dart';
import 'package:akropolis/domain/models/thread_model.dart';
import 'package:common_fn/common_fn.dart';
import 'package:exception_base/exception_base.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FetchThreadsUseCase {
  final MessageRepository _messageRepository;
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  FetchThreadsUseCase({
    required MessageRepository messageRepository,
    required UserRepository userRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _messageRepository = messageRepository,
        _userRepository = userRepository,
        _authenticationRepository = authenticationRepository;

  Future<Result<Thread>> _fromThreadRemote(ThreadRemote threadRemote) async {
    Result<AppUser?> participant1Result = await _userRepository.findUserById(id: threadRemote.participant1);
    late AppUser participant1;
    switch (participant1Result) {
      case Success<AppUser?>():
        AppUser? user = participant1Result.data;
        if (user == null) {
          return Error(
            failure: AppFailure(
              message: "Participant 1 data not found",
            ),
          );
        }
        participant1 = user;
        break;
      case Error<AppUser?>():
        return Error(failure: participant1Result.failure);
    }

    Result<AppUser?> participant2Result = await _userRepository.findUserById(id: threadRemote.participant2);
    late AppUser participant2;
    switch (participant2Result) {
      case Success<AppUser?>():
        AppUser? user = participant2Result.data;
        if (user == null) {
          return Error(
            failure: AppFailure(
              message: "Participant 2 data not found",
            ),
          );
        }
        participant2 = user;
        break;
      case Error<AppUser?>():
        return Error(failure: participant2Result.failure);
    }

    return Success(data: Thread(threadRemote, participant1, participant2));
  }

  Future<Result<List<Thread>>> fetchThreads({
    required int pageSize,
    required String userId,
    DateTime? lastFetchedCreatedAt,
  }) async {
    Result<List<ThreadRemote>> remoteThreadsResult = await _messageRepository.fetchMyThreads(
      pageSize: pageSize,
      userId: userId,
      lastFetchedCreatedAt: lastFetchedCreatedAt,
    );

    switch (remoteThreadsResult) {
      case Success<List<ThreadRemote>>():
        List<Result<Thread>> threadConversionResult = await Future.wait(remoteThreadsResult.data.map(_fromThreadRemote).toList());
        List<Thread> convertedThreads = threadConversionResult.whereType<Success<Thread>>().map((e) => e.data).toList();
        return Success(data: convertedThreads);

      case Error<List<ThreadRemote>>():
        return Error(failure: remoteThreadsResult.failure);
    }
  }
}
