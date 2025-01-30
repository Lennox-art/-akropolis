import 'dart:collection';

import 'package:akropolis/components/toast/toast.dart';
import 'package:akropolis/features/for_you_feed/models/for_you_models.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/networking/media_stack_network_requests.dart';
import 'package:akropolis/utils/enums.dart';
import 'package:common_fn/common_fn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'for_you_news_state.dart';
part 'for_you_news_cubit.freezed.dart';

class ForYouNewsCubit extends Cubit<ForYouNewsState> {
  final LinkedHashSet<MediaStackArticleModel> cachedNews = LinkedHashSet();

  ForYouNewsCubit() : super(const ForYouNewsState.loading());

  Future<List<MediaStackArticleModel>?> fetchNews({
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

        return pageList<MediaStackArticleModel>(
          cachedNews.take(pageSize).toList(),
          page: page == 1 ? 0 : page,
          pageSize: pageSize,
        );
      }

      var response = await sendGetMediaStackNews(
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
            ForYouNewsLoadedState(
              toast: ToastError(
                title: f.failure.failureType.name,
                message: f.failure.message,
              ),
            ),
          );
          return null;
        },
        success: (s) {
          MediaStackResponse apiResponse = MediaStackResponse.fromJson(s.data!);
          cachedNews.addAll(apiResponse.data);

          emit(
            ForYouNewsLoadedState(
              toast: ToastSuccess(
                title: "World News",
                message: "Fetched ${apiResponse.pagination.count} articles",
              ),
            ),
          );
          return apiResponse.data;
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