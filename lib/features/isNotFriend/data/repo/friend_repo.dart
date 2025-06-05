import 'package:dartz/dartz.dart';

abstract class FriendRepo {
  Future<Either<String, void>> sendFriendRequest(int receiverId);
}
