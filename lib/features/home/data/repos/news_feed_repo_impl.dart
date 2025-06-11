import 'package:damma_project/core/utils/api/api_consumer.dart';
import 'package:damma_project/core/utils/api/endpoints.dart';
import 'package:dartz/dartz.dart';
import '../models/news_feed_model/news_feed_model.dart';
import 'news_feed_repo.dart';

class NewsFeedRepoImpl implements NewsFeedRepo {
  final ApiConsumer api;

  NewsFeedRepoImpl(this.api);

  @override
  Future<Either<String, List<NewsFeedModel>>> fetchNewsFeed() async {
    try {
      final response = await api.get(Endpoints.newsFeed);
      final List<NewsFeedModel> posts =
          (response as List).map((e) => NewsFeedModel.fromJson(e)).toList();
      return Right(posts);
    } catch (error) {
      return Left(error.toString());
    }
  }

  @override
  Future<Either<String, void>> addComment(int postId, String content) async {
    try {
      await api.post(
        Endpoints.addComment,
        data: {
          'id': postId,
          'comment': content,
        },
      );
      return const Right(null);
    } catch (error) {
      return Left(error.toString());
    }
  }

  @override
  Future<Either<String, void>> addReaction(
      int postId, String reactionType) async {
    try {
      await api.post(
        Endpoints.addReaction,
        data: {
          'id': postId,
          'type': reactionType,
        },
      );
      return const Right(null);
    } catch (error) {
      return Left(error.toString());
    }
  }

  @override
  Future<Either<String, void>> removeReaction(int postId) async {
    try {
      await api.delete(
        Endpoints.removeReaction,
        data: {'postId': postId},
      );
      return const Right(null);
    } catch (error) {
      return Left(error.toString());
    }
  }
}
