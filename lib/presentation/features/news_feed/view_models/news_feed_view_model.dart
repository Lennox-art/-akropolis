import 'package:akropolis/domain/use_cases/fetch_post_comments_use_case.dart';
import 'package:akropolis/presentation/features/home/models/home_models.dart';
import 'package:akropolis/presentation/features/news_feed/models/enums.dart';
import 'package:flutter/cupertino.dart';

class NewsFeedViewModel extends ChangeNotifier {
  final FetchPostCommentsUseCase fetchPostCommentsUseCase;

  final List<NewsFeedTabEnum> allTabs = NewsFeedTabEnum.values;

  NewsFeedTabEnum _currentTab = NewsFeedTabEnum.forYou;

  NewsFeedViewModel(this.fetchPostCommentsUseCase);

  void changeTab(NewsFeedTabEnum tab) {
    _currentTab = tab;
    notifyListeners();
  }


  NewsFeedTabEnum get currentTab => _currentTab;

}