import 'dart:async';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/repositories/post_repository/post_repository.dart';
import 'package:akropolis/domain/models/news_card_model.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:flutter/cupertino.dart';

class NewsCardViewModel extends ChangeNotifier {
  final PostRepository _postRepository;

  NewsCardViewModel({
    required PostRepository postRepository,
  }) : _postRepository = postRepository;

  void addNewsPost({
    required NewsCardPostModel newsPost,
    required AppUser appUser,
  }) {
    _addUserToViewers(newsPost, appUser);
  }

  bool getAlreadyReacted(NewsPost post, AppUser user) => getIsLogReaction(post, user) || getIsEmpReaction(post, user);

  bool getIsLogReaction(NewsPost post, AppUser user) => post.reaction.log.contains(user.id);

  bool getIsEmpReaction(NewsPost post, AppUser user) => post.reaction.emp.contains(user.id);

  ReactionDistribution getDistribution(NewsPost post) => ReactionDistribution(post.reaction);

  Future<void> _addUserToViewers(NewsCardPostModel post, AppUser user) async {
    if (post.newsPost.viewers.contains(user.id)) return;

    Result<void> addViewerResult = await _postRepository.addUserToPostViewers(
      postId: post.newsPost.id,
      collection: post.newsChannel.collection,
      userId: user.id,
    );

    switch (addViewerResult) {
      case Success<void>():
        break;
      case Error<void>():
        break;
    }
  }

  Future<void> log(NewsCardPostModel post, AppUser user) async {
    if (getAlreadyReacted(post.newsPost, user)) return;

    post.newsPost.reaction.log.add(user.id);
    notifyListeners();

    Result<void> addViewerResult = await _postRepository.addUserToPostLogicianReaction(
      postId: post.newsPost.id,
      collection: post.newsChannel.collection,
      userId: user.id,
    );

    switch (addViewerResult) {
      case Success<void>():
        break;
      case Error<void>():
        post.newsPost.reaction.log.remove(user.id);
        notifyListeners();
        break;
    }
  }

  Future<void> emp(NewsCardPostModel post, AppUser user) async {
    if (getAlreadyReacted(post.newsPost, user)) return;

    post.newsPost.reaction.emp.add(user.id);
    notifyListeners();

    Result<void> addViewerResult = await _postRepository.addUserToPostEmpathyReaction(
      postId: post.newsPost.id,
      collection: post.newsChannel.collection,
      userId: user.id,
    );

    switch (addViewerResult) {
      case Success<void>():
        break;
      case Error<void>():
        post.newsPost.reaction.emp.remove(user.id);
        notifyListeners();
        break;
    }
  }
}
