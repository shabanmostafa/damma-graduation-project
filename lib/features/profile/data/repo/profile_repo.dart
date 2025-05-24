import 'package:damma_project/core/utils/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepo {
  Future<Either<String, UserModel>> getProfileData(int id);
  Future<Either<String, UserModel>> updateCoverImage(String filePath);
  Future<Either<String, UserModel>> updateProfileImage(String filePath);
  Future<Either<String, UserModel>> updateFirstName(String firstName);
  Future<Either<String, UserModel>> updateLastName(String lastName);

  Future<Either<String, void>> logout();
  Future<Either<String, void>> delete();

  Future<Either<String, void>> getVerificationCode();
  Future<Either<String, void>> resetPassword(
      String newPassword, String verificationCode);
}
