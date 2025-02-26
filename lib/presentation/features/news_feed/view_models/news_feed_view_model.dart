import 'package:akropolis/domain/use_cases/fetch_post_comments_use_case.dart';
import 'package:akropolis/presentation/features/home/models/home_models.dart';
import 'package:akropolis/presentation/features/news_feed/models/enums.dart';
import 'package:flutter/cupertino.dart';

class NewsFeedViewModel extends ChangeNotifier {
  FetchPostCommentsUseCase fetchPostCommentsUseCase;

  final List<NewsFeedTabEnum> allTabs = NewsFeedTabEnum.values;
  final List<Story> _stories = const [
    Story(
      title: "CNN",
      url: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/CNN_International_logo.svg/2048px-CNN_International_logo.svg.png",
    ),
    Story(
      title: "Sky Sports",
      url: "https://play-lh.googleusercontent.com/-kP0io9_T-LULzdpmtb4E-nFYFwDIKW7cwBhOSRwjn6T2ri0hKhz112s-ksI26NFCKOg",
    ),
    Story(
      title: "Jhane k",
      url: "https://mymodernmet.com/wp/wp-content/uploads/2019/09/100k-ai-faces-4.jpg",
    ),
    Story(
      title: "Keliim.n",
      url:
      "https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://media.easy-peasy.ai/cd6f334c-db74-42d9-882b-b99d9e810dc0/e933bb79-b9b4-40a3-8417-2b15f44d5c45.png",
    ),
  ];

  NewsFeedTabEnum _currentTab = NewsFeedTabEnum.forYou;

  NewsFeedViewModel(this.fetchPostCommentsUseCase);

  void changeTab(NewsFeedTabEnum tab) {
    _currentTab = tab;
    notifyListeners();
  }

  List<Story> get stories => _stories;
  NewsFeedTabEnum get currentTab => _currentTab;

}