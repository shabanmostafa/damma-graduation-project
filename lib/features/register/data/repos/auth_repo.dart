import 'package:dartz/dartz.dart';

import '../../../../core/utils/models/user_model/user_model.dart';

abstract class AuthRepo {
  Future<Either<String, UserModel>> login({
    required String email,
    required String password,
  });

  // Future<Either<String, UserModel>> register({
  //   required String name,
  //   required String email,
  //   required String phone,
  //   required String gender,
  //   required String password,
  //   required String confirmPassword,
  // });
}
