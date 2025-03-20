import 'dart:collection';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/topics_repository/topics_repository.dart';
import 'package:akropolis/data/services/data_storage_service/remote_data_storage_service.dart';

class TopicRepositoryImpl extends TopicRepository {
  final LinkedHashSet<Topic> _cachedTopics = LinkedHashSet();
  final RemoteDataStorageService _remoteDataStorageService;

  TopicRepositoryImpl({
    required RemoteDataStorageService remoteDataStorageService,
  }) : _remoteDataStorageService = remoteDataStorageService;

  @override
  Future<Result<List<Topic>>> getTopics() async {
    if (_cachedTopics.isNotEmpty) return Result.success(data: _cachedTopics.toList(growable: false));

    Result<List<Topic>> topicResults = await _remoteDataStorageService.fetchTopics();
    switch (topicResults) {
      case Success<List<Topic>>():
        _cachedTopics.addAll(topicResults.data);
        return topicResults;
      case Error<List<Topic>>():
        return Result.error(failure: topicResults.failure);
    }
  }
}
