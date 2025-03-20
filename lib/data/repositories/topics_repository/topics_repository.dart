
import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';

abstract class TopicRepository {
  Future<Result<List<Topic>>> getTopics();
}
