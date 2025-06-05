import 'package:damma_project/core/utils/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeUserRepo {
  Future<Either<String, UserModel>> getHomeUserData(int id);
}
