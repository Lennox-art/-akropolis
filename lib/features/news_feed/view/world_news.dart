import 'package:akropolis/features/news_feed/view/news_card.dart';
import 'package:akropolis/features/news_feed/models/models.dart';
import 'package:akropolis/features/news_feed/view_models/world_news_cubit/world_news_cubit.dart';
import 'package:akropolis/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paged_list_view/paged_list_view.dart';

class WorldNewsContent extends StatelessWidget {
  const WorldNewsContent({super.key});

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
          collection: worldNewsCollection,
        ),
        fetchPage: (int page, int pageSize, bool initialFetch) async {
          return BlocProvider.of<WorldNewsCubit>(context).fetchWorldNews(
            pageSize: pageSize,
            fromCache: initialFetch,
          );
        },
      ),
    );
  }
}
