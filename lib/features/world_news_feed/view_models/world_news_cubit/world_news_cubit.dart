import 'dart:collection';

import 'package:akropolis/components/toast/toast.dart';
import 'package:akropolis/utils/enums.dart';
import 'package:akropolis/features/world_news_feed/models/world_news_models.dart';
import 'package:akropolis/features/world_news_feed/view_models/world_news_network_requests.dart';
import 'package:akropolis/main.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:common_fn/common_fn.dart';

part 'world_news_state.dart';

part 'world_news_cubit.freezed.dart';

class WorldNewsCubit extends Cubit<WorldNewsState> {
  final LinkedHashSet<WorldNewsModel> cachedNews = LinkedHashSet();

  WorldNewsCubit() : super(const WorldNewsState.loaded());

  Future<List<WorldNewsModel>?> fetchNews({
    required int page,
    required int pageSize,
    required bool fromCache,
    Language? language,
    String? domains,
    String? excludeDomains,
    String? keywords,
    List<String> sources = const [],
    DateTime? from,
    DateTime? to,
  }) async {
    try {

      if (fromCache && cachedNews.isNotEmpty) {

        return pageList<WorldNewsModel>(
          cachedNews.take(pageSize).toList(),
          page: page == 1 ? 0 : page,
          pageSize: pageSize,
        );
      }

      var response = await getEverythingNewsApi(
        page: page,
        pageSize: pageSize,
        language: language?.name,
        domains: domains,
        excludeDomains: excludeDomains,
        keywords: keywords,
        sources: sources,
        from: from,
        to: to,
      );

      return response.map(
        fail: (f) {
          emit(
            LoadedWorldNewsState(
              toast: ToastError(
                title: f.failure.failureType.name,
                message: f.failure.message,
              ),
            ),
          );
          return null;
        },
        success: (s) {
          NewsApiResponse apiResponse = NewsApiResponse.fromJson(s.data!);
          cachedNews.addAll(apiResponse.articles);

          emit(
            LoadedWorldNewsState(
              toast: ToastSuccess(
                title: "World News",
                message: "Fetched ${apiResponse.totalResults} articles",
              ),
            ),
          );
          return apiResponse.articles;
        },
      );

    } catch(e, trace) {
      addError(e, trace);
      return null;
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    log.error(error, trace: stackTrace);
    super.onError(error, stackTrace);
  }
}
