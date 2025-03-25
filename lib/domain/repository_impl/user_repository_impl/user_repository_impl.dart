import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/user_repository/user_repository.dart';
import 'package:akropolis/data/services/data_storage_service/remote_data_storage_service.dart';
import 'package:exception_base/exception_base.dart';

class UserRepositoryImpl extends UserRepository {
  final RemoteDataStorageService _remoteDataStorageService;
  final Map<String, AppUser> userCache = {};

  UserRepositoryImpl({
    required RemoteDataStorageService remoteDataStorageService,
  }) : _remoteDataStorageService = remoteDataStorageService;

  @override
  Future<Result<AppUser?>> findUserById({
    required String id,
  }) async {
    try {
      Result<AppUser?> findUserResult = await _remoteDataStorageService.findUserById(
        id: id,
      );

      if (findUserResult is Success<AppUser?> && findUserResult.data != null) {
        userCache.putIfAbsent(findUserResult.data!.id, () => findUserResult.data!);
      }
      return findUserResult;
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
  Future<Result<AppUser>> saveAppUser({
    required AppUser appUser,
  }) async {
    try {
      Result<AppUser> saveUserResult = await _remoteDataStorageService.setUser(user: appUser);
      if (saveUserResult is Success<AppUser>) userCache.putIfAbsent(saveUserResult.data.id, () => saveUserResult.data);
      return saveUserResult;
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
  Future<Result<List<AppUser>>> searchByDisplayName({required String query}) async {
    try {
      return await _remoteDataStorageService.searchUserByDisplayName(displayName: query);
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
