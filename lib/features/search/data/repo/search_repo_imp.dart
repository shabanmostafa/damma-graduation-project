import 'package:damma_project/features/search/data/models/search_model/search_model.dart';
import 'package:dartz/dartz.dart';
import 'package:damma_project/core/utils/api/api_consumer.dart';
import 'package:damma_project/core/utils/api/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  final ApiConsumer api;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  SearchRepoImpl(this.api);

  @override
  Future<Either<String, List<SearchModel>>> searchFriends(String query) async {
    try {
      final token = await storage.read(key: 'accessToken');

      if (token == null || token.isEmpty) {
        return const Left("Access token not found. Please log in again.");
      }

      final response = await api.get(
  '${Endpoints.search}?SearchTerm=$query',
  options: Options(headers: {'Authorization': 'Bearer $token'}),
);


      final List<SearchModel> searchResults =
          (response as List).map((e) => SearchModel.fromJson(e)).toList();

      return Right(searchResults);
    } catch (error) {
      return Left(error.toString());
    }
  }
}
