// import 'package:damma_project/core/utils/api/api_consumer.dart';
// import 'package:damma_project/core/utils/api/endpoints.dart';
// import 'package:damma_project/features/my_friends/data/models/my_friends_model/my_friends_model.dart';
// import 'package:dartz/dartz.dart';
// import 'my_friends_repo.dart';

// class MyFriendsRepoImpl implements MyFriendsRepo {
//   final ApiConsumer api;

//   MyFriendsRepoImpl(this.api);

//   @override
//   Future<Either<String, List<MyFriendsModel>>> getFriendsList() async {
//     try {
//       final response = await api.get(Endpoints.getFriends);

//       // Handle empty or invalid response
//       if (response == null || response is! Map<String, dynamic>) {
//         return const Right([]);
//       }

//       // Convert response to MyFriendsModel
//       final friendsModel = MyFriendsModel.fromJson(response);

//       // Return as list with single item (or empty if no data)
//       return Right(friendsModel.data != null ? [friendsModel] : []);
//     } catch (error) {
//       return Left(error.toString());
//     }
//   }

//   @override
//   Future<Either<String, void>> deleteFriend(int friendId) async {
//     try {
//       await api.delete('${Endpoints.deleteFriend}/$friendId');
//       return const Right(null);
//     } catch (error) {
//       return Left(error.toString());
//     }
//   }
// }

// import 'package:damma_project/core/utils/api/api_consumer.dart';
// import 'package:damma_project/core/utils/api/endpoints.dart';
// import 'package:damma_project/features/my_friends/data/models/my_friends_model/my_friends_model.dart';
// import 'package:dartz/dartz.dart';
// import 'my_friends_repo.dart';

// class MyFriendsRepoImpl implements MyFriendsRepo {
//   final ApiConsumer api;

//   MyFriendsRepoImpl(this.api);

//   @override
//   Future<Either<String, List<MyFriendsModel>>> getFriendsList() async {
//     try {
//       final response = await api.get(Endpoints.getFriends);

//       if (response == null || response is! Map<String, dynamic>) {
//         return const Right([]);
//       }

//       final friendsModel = MyFriendsModel.fromJson(response);
//       return Right(friendsModel.data != null ? [friendsModel] : []);
//     } catch (error) {
//       return Left(error.toString());
//     }
//   }

//   @override
//   @override
//   Future<Either<String, void>> deleteFriend(int friendId) async {
//     try {
//       await api.delete('${Endpoints.deleteFriend}/$friendId');
//       return const Right(null);
//     } catch (error) {
//       return Left(error.toString());
//     }
//   }
// }

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

      if (response == null || response is! Map<String, dynamic>) {
        return const Right([]);
      }

      final friendsModel = MyFriendsModel.fromJson(response);
      return Right(friendsModel.data != null ? [friendsModel] : []);
    } catch (error) {
      return Left(error.toString());
    }
  }

  @override
  Future<Either<String, void>> deleteFriend(int friendId) async {
    try {
      await api.delete('${Endpoints.deleteFriend}/$friendId');
      return const Right(null);
    } catch (error) {
      return Left(error.toString());
    }
  }
}
