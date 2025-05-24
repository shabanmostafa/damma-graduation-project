import 'package:damma_project/features/my_friends/data/models/my_friends_model/my_friends_model.dart';
import 'package:dartz/dartz.dart';

abstract class MyFriendsRepo {
  Future<Either<String, List<MyFriendsModel>>> getFriendsList();
}
