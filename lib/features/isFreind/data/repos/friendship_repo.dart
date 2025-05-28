// import 'package:dartz/dartz.dart';

// abstract class FriendshipRepo {
//   Future<Either<String, bool>> checkIsFriend(int friendId);
// }

import 'package:damma_project/core/utils/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class FriendshipRepo {
  Future<Either<Failure, bool>> checkIsFriend(int friendId);
}
