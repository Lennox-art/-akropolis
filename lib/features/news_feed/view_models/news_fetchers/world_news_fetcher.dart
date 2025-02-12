import 'dart:collection';

import 'package:akropolis/features/news_feed/models/models.dart';
import 'package:akropolis/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common_fn/common_fn.dart';

class WorldNewsFetcher  {
  static final LinkedHashSet<NewsPost> cachedNews = LinkedHashSet();
  static final CollectionReference postsCollectionRef = FirebaseFirestore.instance.collection(NewsChannel.worldNews.collection,).withConverter<NewsPost>(
    fromFirestore: (snapshot, _) => NewsPost.fromJson(snapshot.data()!),
    toFirestore: (model, _) => model.toJson(),
  );
  static DocumentSnapshot? lastFetchedUserPost;

  WorldNewsFetcher._();

  static Future<List<NewsPost>?> fetchWorldNews({
    required int pageSize,
    required bool fromCache,
    List<String> keywords = const [],
    Function(String)? onError,
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
      log.error(e, trace: trace);
      onError?.call(e.toString());
      return null;
    }
  }

}
