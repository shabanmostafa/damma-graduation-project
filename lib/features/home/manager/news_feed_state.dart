// 4. news_feed_state.dart
part of 'news_feed_cubit.dart';

abstract class NewsFeedState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsFeedInitial extends NewsFeedState {}

class NewsFeedLoading extends NewsFeedState {}

class NewsFeedSuccess extends NewsFeedState {
  final List<NewsFeedModel> posts;
  NewsFeedSuccess(this.posts);
  @override
  List<Object?> get props => [posts];
}

class NewsFeedFailure extends NewsFeedState {
  final String error;
  NewsFeedFailure(this.error);
  @override
  List<Object?> get props => [error];
}
