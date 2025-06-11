import 'package:dartz/dartz.dart';
import '../models/news_feed_model/news_feed_model.dart';

abstract class NewsFeedRepo {
  Future<Either<String, List<NewsFeedModel>>> fetchNewsFeed();
  Future<Either<String, void>> addComment(int postId, String content);
  Future<Either<String, void>> addReaction(int postId, String reactionType);
  Future<Either<String, void>> removeReaction(int postId);
}
