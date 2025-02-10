import 'dart:collection';

import 'package:akropolis/components/toast/toast.dart';
import 'package:akropolis/features/create_post/models/models.dart';
import 'package:akropolis/utils/enums.dart';
import 'package:akropolis/features/world_news_feed/models/world_news_models.dart';
import 'package:akropolis/networking/world_news_network_requests.dart';
import 'package:akropolis/main.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:common_fn/common_fn.dart';

part 'world_news_state.dart';

part 'world_news_cubit.freezed.dart';

class WorldNewsCubit extends Cubit<WorldNewsState> {
  final LinkedHashSet<NewsPost> cachedNews = LinkedHashSet();

  WorldNewsCubit() : super(const WorldNewsState.loaded());


  @override
  void onError(Object error, StackTrace stackTrace) {
    log.error(error, trace: stackTrace);
    super.onError(error, stackTrace);
  }
}
