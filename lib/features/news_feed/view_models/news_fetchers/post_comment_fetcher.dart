import 'dart:collection';

import 'package:akropolis/features/news_feed/models/models.dart';
import 'package:akropolis/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common_fn/common_fn.dart';

class PostCommentFetcher {
  static final LinkedHashMap<String, List<PostComment>> cachedNews = LinkedHashMap();
  static final Map<String, DocumentSnapshot?> lastFetchedCommentMap = {};

  PostCommentFetcher._();


  static Future<List<PostComment>?> fetchPostsCommentsNews({
    required String postCollection,
    required String postId,
    required int pageSize,
    required bool fromCache,
    Function(String)? onError,
  }) async {
    try {
      if (fromCache && cachedNews.isNotEmpty && (cachedNews[postId]?.isNotEmpty ?? false)) {
        return pageList<PostComment>(
          cachedNews[postId]!.take(pageSize).toList(),
          page: 0,
          pageSize: pageSize,
        );
      }

      final CollectionReference newsPostCommentRef =
          FirebaseFirestore.instance.collection(postCollection).doc(postId).collection(PostComment.collection).withConverter<PostComment>(
                fromFirestore: (snapshot, _) => PostComment.fromJson(snapshot.data()!),
                toFirestore: (model, _) => model.toJson(),
              );

      var query = newsPostCommentRef.orderBy("commentedAt", descending: true).limit(pageSize);
      DocumentSnapshot? lastFetchedPostComment = lastFetchedCommentMap[postId];
      if (lastFetchedPostComment != null) query = query.startAfterDocument(lastFetchedPostComment);

      var qs = await query.get();

      //cache last
      lastFetchedPostComment = qs.docs.lastOrNull;
      lastFetchedCommentMap.update(postId, (_) => lastFetchedPostComment, ifAbsent: () => lastFetchedPostComment);

      List<PostComment> data = qs.docs.map((e) => e.data() as PostComment).toList();
      cachedNews.update(postId, (l) => l..addAll(data), ifAbsent: () => data);

      return data;
    } catch (e, trace) {
      log.error(e, trace: trace);
      onError?.call(e.toString());
      return null;
    }
  }
}