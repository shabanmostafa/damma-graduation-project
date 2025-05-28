// friend_state.dart
abstract class FriendState {}

class FriendInitial extends FriendState {}

class FriendLoading extends FriendState {}

class FriendRequestSentSuccess extends FriendState {}

class FriendFailure extends FriendState {
  final String error;
  FriendFailure(this.error);
}
