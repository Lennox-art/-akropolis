import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/user_story_repository/user_story_repository.dart';
import 'package:akropolis/data/services/data_storage_service/remote_data_storage_service.dart';

class UserStoryRepositoryImpl extends UserStoryRepository {
  final RemoteDataStorageService _remoteDataStorageService;

  UserStoryRepositoryImpl({required RemoteDataStorageService remoteDataStorageService}) : _remoteDataStorageService = remoteDataStorageService;

  @override
  Future<Result<List<UserStory>>> fetchOtherUserStories({
    required String userId,
    required int pageSize,
    DateTime? lastFetchedCreatedAt,
  }) async {
    return await _remoteDataStorageService.fetchOtherUserStories(
      pageSize: pageSize,
      userId: userId,
      lastFetchedCreatedAt: lastFetchedCreatedAt,
    );
  }

  @override
  Future<Result<List<UserStory>>> getCurrentUserStories({
    required String userId,
  }) async {
    return await _remoteDataStorageService.fetchUsersStories(
      userId: userId,
    );
  }

  @override
  Future<Result<UserStory>> createUserStory({required UserStory userStory}) async {
    return await _remoteDataStorageService.createUserStory(
      userStory: userStory,
    );
  }

  @override
  Future<Result<void>> addToViewers({required String userId, required String postId}) {
    // TODO: implement addToViewers
    throw UnimplementedError();
  }

}
