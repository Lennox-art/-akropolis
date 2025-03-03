import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';

class NewsCardPostModel {
  final NewsPost newsPost;
  final NewsChannel newsChannel;
  final Result<MapEntry<String, MediaData>> thumbnail;
  final Result<Map<String, NewsCardCommentModel>> comments;
  final Result<int> replyCountResult;

  NewsCardPostModel({
    required this.newsPost,
    required this.newsChannel,
    required this.thumbnail,
    required this.comments,
    required this.replyCountResult,
  });
}

class NewsCardCommentModel {
  final PostComment postComment;
  final Result<MapEntry<String, MediaData>> thumbnail;

  NewsCardCommentModel({
    required this.postComment,
    required this.thumbnail,
  });
}
