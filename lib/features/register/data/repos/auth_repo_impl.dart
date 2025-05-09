import 'package:dartz/dartz.dart';

import '../../../../core/utils/api/dio_consumer.dart';
import '../../../../core/utils/api/endpoints.dart';
import '../../../../core/utils/errors/failure.dart';
import '../../../../core/utils/models/user_model/user_model.dart';
import '../../../../core/utils/secure/secure_storage_service.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final DioConsumer apiService;
  final SecureStorageService secureStorageService;

  AuthRepoImpl(
    this.apiService,
    this.secureStorageService,
  );

  @override
  Future<Either<String, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiService.post(
        Endpoints.login,
        data: {
          ApiKey.email: email,
          ApiKey.password: password,
        },
      );

      final user = UserModel.fromJson(response);
      await secureStorageService.setValue(ApiKey.accessToken, user.data!.token ?? "");

      final username = response['data']['username'] ?? '';
      await secureStorageService.setValue('username', username);

      return Right(user);
    } on ServerFailure catch (e) {
      return Left(e.errorMessage);
    }
  }

  // @override
  // Future<Either<String, UserModel>> register({
  //   required String name,
  //   required String email,
  //   required String phone,
  //   required String gender,
  //   required String password,
  //   required String confirmPassword,
  // }) async {
  //   try {
  //     final response = await apiService.post(
  //       Endpoints.register,
  //       data: {
  //         ApiKey.name: name,
  //         ApiKey.email: email,
  //         ApiKey.phone: phone,
  //         ApiKey.gender: gender,
  //         ApiKey.password: password,
  //         ApiKey.passwordConfirmation: confirmPassword,
  //       },
  //     );
  //     final userModel = UserModel.fromJson(response);

  //     if (userModel.data!.token != null) {
  //       await secureStorageService.setValue(
  //           ApiKey.token, userModel.data!.token!);
  //     }

  //     return Right(userModel);
  //   } on ServerFailure catch (e) {
  //     return Left(e.errorMessage);
  //   }
  // }
}
