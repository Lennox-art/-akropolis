import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';

abstract class UserStoryRepository {
  Future<Result<void>> addToViewers({required String userId, required String storyId});

  Future<Result<UserStory>> createUserStory({required UserStory userStory});

  Future<Result<List<UserStory>>> getCurrentUserStories({required String userId});

  Future<Result<List<UserStory>>> fetchOtherUserStories({
    required String userId,
    required int pageSize,
    DateTime? lastFetchedCreatedAt,
  });
}
