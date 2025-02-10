import 'dart:collection';

import 'package:akropolis/components/toast/toast.dart';
import 'package:akropolis/features/news_feed/models/models.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common_fn/common_fn.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'world_news_state.dart';

part 'world_news_cubit.freezed.dart';

class WorldNewsCubit extends Cubit<WorldNewsState> {
  final LinkedHashSet<NewsPost> cachedNews = LinkedHashSet();
  final CollectionReference postsCollectionRef = FirebaseFirestore.instance.collection(worldNewsCollection).withConverter<NewsPost>(
    fromFirestore: (snapshot, _) => NewsPost.fromJson(snapshot.data()!),
    toFirestore: (model, _) => model.toJson(),
  );
  DocumentSnapshot? lastFetchedUserPost;

  WorldNewsCubit() : super(const WorldNewsState.loaded());


  Future<List<NewsPost>?> fetchWorldNews({
    required int pageSize,
    required bool fromCache,
    List<String> keywords = const [],
  }) async {
    try {

      if (fromCache && cachedNews.isNotEmpty) {

        return pageList<NewsPost>(
          cachedNews.take(pageSize).toList(),
          page: 0,
          pageSize: pageSize,
        );
      }

      var query = postsCollectionRef.orderBy("publishedAt", descending: true).limit(pageSize);
      if(lastFetchedUserPost != null) query = query.startAfterDocument(lastFetchedUserPost!);

      var qs = await query.get();

      //cache last
      lastFetchedUserPost = qs.docs.lastOrNull;
      List<NewsPost> data = qs.docs.map((e) => e.data() as NewsPost).toList();
      cachedNews.addAll(data);

      return data;
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
