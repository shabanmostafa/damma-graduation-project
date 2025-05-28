import 'package:dartz/dartz.dart';
import 'package:damma_project/core/utils/api/api_consumer.dart';
import 'package:damma_project/core/utils/api/endpoints.dart';

abstract class FriendRepo {
  Future<Either<String, void>> sendFriendRequest(int receiverId);
}
