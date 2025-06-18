// 3. NewsFeedCubit
import 'package:bloc/bloc.dart';
import 'package:damma_project/features/home/data/models/news_feed_model/news_feed_model.dart';
import 'package:damma_project/features/home/data/repos/news_feed_repo.dart';
import 'package:equatable/equatable.dart';

part 'news_feed_state.dart';

class NewsFeedCubit extends Cubit<NewsFeedState> {
  final NewsFeedRepo newsFeedRepo;

  NewsFeedCubit(this.newsFeedRepo) : super(NewsFeedInitial());

  Future<void> fetchNewsFeed() async {
    emit(NewsFeedLoading());
    final result = await newsFeedRepo.fetchNewsFeed();
    result.fold(
      (error) => emit(NewsFeedFailure(error)),
      (posts) => emit(NewsFeedSuccess(posts)),
    );
  }

  Future<bool> addComment(int postId, String content) async {
    try {
      await newsFeedRepo.addComment(postId, content);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> addReaction(int postId, String reactionType) async {
    final result = await newsFeedRepo.addReaction(postId, reactionType);
    result.fold(
      (failure) => null,
      (_) => null,
    );
  }

  Future<void> removeReaction(int postId) async {
    final result = await newsFeedRepo.removeReaction(postId);
    result.fold(
      (failure) => null,
      (_) => null,
    );
  }
}
