import 'package:damma_project/core/utils/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:damma_project/core/utils/api/api_consumer.dart';
import 'package:damma_project/core/utils/api/endpoints.dart';

import 'friendship_repo.dart';

class FriendshipRepoImpl implements FriendshipRepo {
  final ApiConsumer api;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  FriendshipRepoImpl(this.api);


  
@override
Future<Either<Failure, bool>> checkIsFriend(int friendId) async {
  try {
    final response = await api.get('${Endpoints.isFriend}/$friendId',);

    // Handle successful response (status code 200)
    if (response != null &&
        response is Map<String, dynamic> &&
        response.containsKey('isFriend')) {
      final isFriend = response['isFriend'] as bool;
      return Right(isFriend);
    }

    return Left(ServerFailure('Unexpected response format'));
  } on DioException catch (e) {
    // Handle specific case where backend incorrectly returns 404 with valid body
    if (e.response?.statusCode == 404 && e.response?.data != null) {
      final data = e.response?.data;
      if (data is Map<String, dynamic> && data.containsKey('isFriend')) {
        final isFriend = data['isFriend'] as bool;
        return Right(isFriend);
      }
    }

    // Any other Dio error
    return Left(ServerFailure(e.message ?? 'Network error'));
  } catch (e) {
    // Catch any other unexpected error
    return Left(ServerFailure(e.toString()));
  }
}


  // Future<Either<String, bool>> checkIsFriend(int friendId) async {
  //   try {
  //     final token = await storage.read(key: 'accessToken');
  //     if (token == null || token.isEmpty) {
  //       return const Left("Access token not found. Please log in again.");
  //     }

  //     final response = await api.get(
  //       '${Endpoints.isFriend}/$friendId',
  //       options: Options(headers: {'Authorization': 'Bearer $token'}),
  //     );

  //     return Right(response['isFriend'] == true);
  //   } catch (e) {
  //     return Left(e.toString());
  //   }
  // }
}
