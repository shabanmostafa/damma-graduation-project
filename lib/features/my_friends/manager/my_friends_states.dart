import 'package:damma_project/features/my_friends/data/models/my_friends_model/my_friends_model.dart';

abstract class MyFriendsState {}

class MyFriendsInitial extends MyFriendsState {}

class MyFriendsLoading extends MyFriendsState {}

class MyFriendsSuccess extends MyFriendsState {
  final List<MyFriendsModel> friends;

  MyFriendsSuccess(this.friends);
}

class MyFriendsFailure extends MyFriendsState {
  final String error;

  MyFriendsFailure(this.error);
}
