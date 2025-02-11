import 'package:akropolis/features/news_feed/view/news_card.dart';
import 'package:akropolis/features/news_feed/models/models.dart';
import 'package:akropolis/features/news_feed/view_models/for_you_news_cubit/for_you_news_cubit.dart';
import 'package:akropolis/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paged_list_view/paged_list_view.dart';

class ForYouContent extends StatelessWidget {
  const ForYouContent({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<PagedListState> pagedListKey = GlobalKey<PagedListState>();

    return RefreshIndicator(
      onRefresh: () => pagedListKey.currentState!.refresh(),
      child: PagedList<NewsPost>(
        key: pagedListKey,
        firstPageProgressIndicatorBuilder: (_) => const CircularProgressIndicator.adaptive(),
        newPageProgressIndicatorBuilder: (_) => const CircularProgressIndicator.adaptive(),
        itemBuilder: (_, news, i) => NewsCard(
          post: news,
          newsChannel: NewsChannel.userPosts,
        ),
        fetchPage: (int page, int pageSize, bool initialFetch) async {
          /*return BlocProvider.of<ForYouNewsCubit>(context).fetchNews(
            page: page,
            pageSize: pageSize,
            fromCache: initialFetch,
            language: Language.en,
            sources: NewsSourceEnum.values.map((s) => s.name).toList(),
          );*/
          return BlocProvider.of<ForYouNewsCubit>(context).fetchUserPostsNews(
            pageSize: pageSize,
            fromCache: initialFetch,
          );
        },
      ),
    );
  }
}
