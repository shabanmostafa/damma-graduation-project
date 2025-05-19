import 'package:damma_project/core/utils/api/api_consumer.dart';
import 'package:damma_project/core/utils/api/endpoints.dart';
import 'package:damma_project/features/my_friends/data/models/my_friends_model/my_friends_model.dart';
import 'package:dartz/dartz.dart';
import 'my_friends_repo.dart';

class MyFriendsRepoImpl implements MyFriendsRepo {
  final ApiConsumer api;

  MyFriendsRepoImpl(this.api);

  @override
  Future<Either<String, List<MyFriendsModel>>> getFriendsList() async {
    try {
      final response = await api.get(Endpoints.getFriends);

      // The response is a JSON array
      final List<MyFriendsModel> friends = (response as List)
          .map((friendJson) => MyFriendsModel.fromJson(friendJson))
          .toList();

      return Right(friends);
    } catch (error) {
      return Left(error.toString());
    }
  }
}
