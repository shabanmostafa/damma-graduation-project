import 'package:damma_project/core/utils/api/api_consumer.dart';
import 'package:damma_project/core/utils/models/user_model.dart';
import 'package:damma_project/core/utils/api/endpoints.dart';
import 'package:damma_project/features/home/data/repos/home_user_repo.dart.dart';
import 'package:dartz/dartz.dart';

class HomeUserRepoImpl implements HomeUserRepo {
  final ApiConsumer api;
  UserModel? user;

  HomeUserRepoImpl(this.api);

  @override
  Future<Either<String, UserModel>> getHomeUserData(int id) async {
    try {
      final response = await api.get(
        Endpoints.basicInfo,
        queryParameters: {'id': id},
      );
      final profile = UserModel.fromJson(response);
      user = profile; // Save user globally
      return Right(profile);
    } catch (error) {
      return Left(error.toString());
    }
  }
}
