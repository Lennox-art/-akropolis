import 'package:akropolis/domain/use_cases/fetch_post_comments_use_case.dart';
import 'package:akropolis/domain/use_cases/post_reply_use_case.dart';
import 'package:flutter/cupertino.dart';

class NewsDetailPostViewModel extends ChangeNotifier {
  final PostReplyUseCase _postReplyUseCase;
  final FetchPostCommentsUseCase _fetchPostCommentsUseCase;

  NewsDetailPostViewModel({
    required PostReplyUseCase postReplyUseCase,
    required FetchPostCommentsUseCase fetchPostCommentsUseCase,
  })  : _postReplyUseCase = postReplyUseCase,
        _fetchPostCommentsUseCase = fetchPostCommentsUseCase;
}
