import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/data/services/data_storage_service/remote_data_storage_service.dart';
import 'package:akropolis/presentation/features/news_feed/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exception_base/exception_base.dart';
import 'package:logging_service/logging_service.dart';

class FirestoreRemoteStorageService extends RemoteDataStorageService {
  final CollectionReference userCollectionRef = FirebaseFirestore.instance.collection(AppUser.collection).withConverter<AppUser>(
        fromFirestore: (snapshot, _) => AppUser.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson(),
      );

  CollectionReference get userPostsCollectionRef => FirebaseFirestore.instance.collection(NewsChannel.userPosts.collection).withConverter<NewsPost>(
        fromFirestore: (snapshot, _) => NewsPost.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson(),
      );

  CollectionReference get headlinePostsCollectionRef =>
      FirebaseFirestore.instance.collection(NewsChannel.newsHeadlines.collection).withConverter<NewsPost>(
            fromFirestore: (snapshot, _) => NewsPost.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
          );

  CollectionReference get worldNewsPostsCollectionRef =>
      FirebaseFirestore.instance.collection(NewsChannel.worldNews.collection).withConverter<NewsPost>(
            fromFirestore: (snapshot, _) => NewsPost.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
          );

  CollectionReference get localNewsPostsCollectionRef =>
      FirebaseFirestore.instance.collection(NewsChannel.worldNews.collection).withConverter<NewsPost>(
            fromFirestore: (snapshot, _) => NewsPost.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
          );

  CollectionReference get topicCollectionRef => FirebaseFirestore.instance.collection("topics").withConverter<Topic>(
        fromFirestore: (snapshot, _) => Topic.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson(),
      );

  CollectionReference get threadCollectionRef => FirebaseFirestore.instance.collection("threads").withConverter<ThreadRemote>(
        fromFirestore: (snapshot, _) => ThreadRemote.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson(),
      );

  CollectionReference messagesCollectionRef({required String threadId}) =>
      threadCollectionRef.doc(threadId).collection('messages').withConverter<MessageRemote>(
            fromFirestore: (snapshot, _) => MessageRemote.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
          );

  CollectionReference postCommentCollectionRef({required String collection, required String postId}) =>
      FirebaseFirestore.instance.collection(collection).doc(postId).collection(PostComment.collection).withConverter<PostComment>(
            fromFirestore: (snapshot, _) => PostComment.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
          );

  DocumentReference postReference({required String collection, required String postId}) =>
      FirebaseFirestore.instance.collection(collection).doc(postId).withConverter<NewsPost>(
            fromFirestore: (snapshot, _) => NewsPost.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
          );

  final LoggingService _log;

  FirestoreRemoteStorageService({
    required LoggingService log,
  }) : _log = log;

  @override
  Future<Result<AppUser?>> findUserById({required String id}) async {
    try {
      DocumentSnapshot user = await userCollectionRef.doc(id).get();
      return Result.success(data: user.data() as AppUser?);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<AppUser>> setUser({required AppUser user}) async {
    try {
      await userCollectionRef.doc(user.id).set(user);
      return Result.success(data: user);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<NewsPost>> setUserPost({
    required NewsPost post,
  }) async {
    try {
      await userPostsCollectionRef.doc(post.id).set(post);
      return Result.success(data: post);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<List<NewsPost>>> fetchHeadlines({
    required int pageSize,
    required List<String> keywords,
  }) async {
    try {
      //.where(field, arrayContainsAny: keywords);
      QuerySnapshot headlinesSnapshot = await headlinePostsCollectionRef.orderBy("publishedAt", descending: true).limit(pageSize).get();
      List<NewsPost> headlines = headlinesSnapshot.docs.map((d) => d.data() as NewsPost).toList();
      return Result.success(data: headlines);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<List<NewsPost>>> fetchLocalNews({
    required int pageSize,
    required String country,
    required List<String> keywords,
  }) async {
    try {
      //.where(field, arrayContainsAny: keywords);
      QuerySnapshot localNewsSnapshot =
          await worldNewsPostsCollectionRef.orderBy("publishedAt", descending: true).limit(pageSize).where("country", isEqualTo: country).get();
      List<NewsPost> localNews = localNewsSnapshot.docs.map((d) => d.data() as NewsPost).toList();
      return Result.success(data: localNews);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<List<NewsPost>>> fetchUserPostsNews({
    required int pageSize,
    required List<String> keywords,
  }) async {
    try {
      //.where(field, arrayContainsAny: keywords);
      QuerySnapshot userPostsSnapshot = await userPostsCollectionRef.orderBy("publishedAt", descending: true).limit(pageSize).get();
      List<NewsPost> userNews = userPostsSnapshot.docs.map((d) => d.data() as NewsPost).toList();
      return Result.success(data: userNews);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<List<NewsPost>>> fetchWorldNews({
    required int pageSize,
    String? country,
    required List<String> keywords,
  }) async {
    try {
      //.where(field, arrayContainsAny: keywords);

      Query q = worldNewsPostsCollectionRef.orderBy("publishedAt", descending: true).limit(pageSize);
      if (country != null) q = q.where("country", isEqualTo: country);

      QuerySnapshot worldNewsSnapshot = await q.get();
      List<NewsPost> localNews = worldNewsSnapshot.docs.map((d) => d.data() as NewsPost).toList();
      return Result.success(data: localNews);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<PostComment>> setPostComment({
    required String collection,
    required PostComment comment,
  }) async {
    try {
      await postCommentCollectionRef(collection: collection, postId: comment.postId).doc(comment.id).set(comment);
      return Result.success(data: comment);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<List<PostComment>>> fetchPostComments({
    required int pageSize,
    required String collection,
    required String postId,
  }) async {
    try {
      QuerySnapshot commentsSnapshot = await postCommentCollectionRef(collection: collection, postId: postId).limit(pageSize).get();
      List<PostComment> postComments = commentsSnapshot.docs.map((d) => d.data() as PostComment).toList();
      return Result.success(data: postComments);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<int>> countPostComments({
    required String collection,
    required String postId,
  }) async {
    try {
      AggregateQuerySnapshot commentsCount = await postCommentCollectionRef(collection: collection, postId: postId).count().get();
      int count = commentsCount.count ?? 0;
      return Result.success(data: count);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<void>> addUserToPostViewers({
    required String postId,
    required String collection,
    required String userId,
  }) async {
    try {
      await postReference(collection: collection, postId: postId).update({
        'viewers': FieldValue.arrayUnion([userId])
      });
      return const Result.success(data: null);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<void>> addUserToPostEmpathyReaction({
    required String postId,
    required String collection,
    required String userId,
  }) async {
    try {
      await postReference(collection: collection, postId: postId).update({
        'reaction.emp': FieldValue.arrayUnion([userId])
      });
      return const Result.success(data: null);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<void>> addUserToPostLogicianReaction({
    required String postId,
    required String collection,
    required String userId,
  }) async {
    try {
      await postReference(collection: collection, postId: postId).update({
        'reaction.log': FieldValue.arrayUnion([userId])
      });
      return const Result.success(data: null);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<void>> addUserToPostCommentEmpathyReaction({
    required String postId,
    required String collection,
    required String commentId,
    required String userId,
  }) async {
    try {
      await postCommentCollectionRef(collection: collection, postId: postId).doc(commentId).update({
        'reaction.emp': FieldValue.arrayUnion([userId])
      });
      return const Result.success(data: null);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<void>> addUserToPostCommentLogicianReaction({
    required String postId,
    required String collection,
    required String commentId,
    required String userId,
  }) async {
    try {
      await postCommentCollectionRef(collection: collection, postId: postId).doc(commentId).update({
        'reaction.log': FieldValue.arrayUnion([userId])
      });
      return const Result.success(data: null);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<int>> countUserPosts({required String userId}) async {
    try {
      AggregateQuerySnapshot userPostCountSnapshot = await userPostsCollectionRef.where('author.id', isEqualTo: userId).count().get();

      int? postCount = userPostCountSnapshot.count;
      if (postCount == null) {
        return Result.error(
          failure: AppFailure(
            message: "No post count",
            failureType: FailureType.illegalStateFailure,
          ),
        );
      }
      return Result.success(data: postCount);
    } on FirebaseException catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.code,
          trace: trace,
          failureType: FailureType.networkServerFailure,
        ),
      );
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<List<Topic>>> fetchTopics() async {
    topicCollectionRef.get();
    try {
      QuerySnapshot topicSnapshot = await topicCollectionRef.get();
      List<Topic> topics = topicSnapshot.docs.map((d) => d.data() as Topic).toList();
      return Result.success(data: topics);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<List<ThreadRemote>>> fetchMyThreads({
    required int pageSize,
    required String userId,
    DateTime? lastFetchedCreatedAt,
  }) async {
    try {
      var q1 = threadCollectionRef.where('participant1', isEqualTo: userId).limit(pageSize).orderBy('createdAt', descending: true);
      var q2 = threadCollectionRef.where('participant2', isEqualTo: userId).limit(pageSize).orderBy('createdAt', descending: true);

      if (lastFetchedCreatedAt != null) {
        q1.startAfter([lastFetchedCreatedAt]);
        q1.startAfter([lastFetchedCreatedAt]);
      }

      var result = await Future.wait([q1.get(), q2.get()]);

      List<ThreadRemote> threads = result.expand((r) => r.docs.map((d) => d.data() as ThreadRemote)).toList();
      return Result.success(data: threads);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<List<MessageRemote>>> fetchThreadMessages({
    required int pageSize,
    required String threadId,
    DateTime? lastFetchedCreatedAt,
  }) async {
    try {
      var q1 = messagesCollectionRef(threadId: threadId).limit(pageSize).orderBy('createdAt', descending: true);
      if (lastFetchedCreatedAt != null) {
        q1.startAfter([lastFetchedCreatedAt]);
      }
      List<MessageRemote> messages = (await q1.get()).docs.map((d) => d.data() as MessageRemote).toList();
      return Result.success(data: messages);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<MessageRemote>> sendMessage({
    required String threadId,
    required MessageRemote message,
  }) async {
    try {
      await messagesCollectionRef(threadId: threadId).doc(message.id).set(message);
      return Result.success(data: message);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<List<AppUser>>> searchUserByDisplayName({
    required String displayName,
  }) async {
    try {
      var qs = await userCollectionRef.orderBy('displayName').startAt([displayName]).get();
      List<AppUser> users = qs.docs.map((d) => d.data() as AppUser).toList();
      return Result.success(data: users);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<ThreadRemote?>> fetchAThreads({required String threadId}) async {
    try {
      var threadResult = await threadCollectionRef.doc(threadId).get();
      ThreadRemote? remoteThread = threadResult.data() as ThreadRemote?;
      return Result.success(data: remoteThread);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<ThreadRemote>> createAThread({required ThreadRemote thread}) async {
    try {
      await threadCollectionRef.doc(thread.id).set(thread);
      return Result.success(data: thread);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<int>> countMessagesInThread({
    required String threadId,
  }) async {
    try {
      AggregateQuerySnapshot countSnapShot = await messagesCollectionRef(threadId: threadId).count().get();
      int count = countSnapShot.count ?? 0;
      return Success(data: count);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }

  @override
  Future<Result<ThreadRemote?>> fetchThreadWithForParticipants({
    required String participant1,
    required String participant2,
  }) async {
    try {
      var q1 = threadCollectionRef.where('participant1', isEqualTo: participant1).where('participant2', isEqualTo: participant2).limit(1);
      var q2 = threadCollectionRef.where('participant2', isEqualTo: participant2).where('participant2', isEqualTo: participant1).limit(1);

      var result = await Future.wait([q1.get(), q2.get()]);
      ThreadRemote? remoteThread = result.expand((r) => r.docs.map((d) => d.data() as ThreadRemote)).firstOrNull;
      return Success(data: remoteThread);
    } catch (e, trace) {
      return Result.error(
        failure: AppFailure(
          message: e.toString(),
          trace: trace,
        ),
      );
    }
  }
}
