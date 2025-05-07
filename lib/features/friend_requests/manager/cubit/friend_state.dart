import 'package:damma_project/features/search/data/models/user_model.dart';

abstract class FriendState {}

class FriendInitial extends FriendState {}

class FriendLoading extends FriendState {}

class FriendSuccess extends FriendState {
  final List<UserModel> requests;
  final List<UserModel> suggestions;

  FriendSuccess({
    required this.requests,
    this.suggestions = const [],
  });
}

class FriendFailure extends FriendState {
  final String error;

  FriendFailure(this.error);
}
