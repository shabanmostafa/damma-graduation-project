import 'package:damma_project/core/utils/api/api_consumer.dart';
import 'package:damma_project/core/utils/api/endpoints.dart';
import 'package:damma_project/features/profile/data/repo/profile_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:damma_project/core/utils/models/user_model.dart';
import 'package:dio/dio.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ApiConsumer api;

  ProfileRepoImpl(this.api);

  @override
  Future<Either<String, UserModel>> getProfileData() async {
    try {
      final response = await api.get(Endpoints.basicInfo);
      final profile = UserModel.fromJson(response);
      return Right(profile);
    } catch (error) {
      return Left(error.toString());
    }
  }

  @override
  Future<Either<String, UserModel>> updateCoverImage(String filePath) async {
    try {
      final file =
          await MultipartFile.fromFile(filePath, filename: 'cover.jpg');
      final formData = FormData.fromMap({
        'CoverImage': file,
      });

      await api.put(
        Endpoints.coverImage,
        data: formData,
        isFormData: true,
      );

      // Get updated user profile
      return await getProfileData();
    } catch (error) {
      return Left(error.toString());
    }
  }

  @override
  Future<Either<String, UserModel>> updateProfileImage(String filePath) async {
    try {
      final file =
          await MultipartFile.fromFile(filePath, filename: 'profile.jpg');
      final formData = FormData.fromMap({
        'ProfileImage': file,
      });

      await api.put(
        Endpoints.profileImage,
        data: formData,
        isFormData: true,
      );

      // Get updated user profile
      return await getProfileData();
    } catch (error) {
      return Left(error.toString());
    }
  }

  @override
  Future<Either<String, UserModel>> updateFirstName(String firstName) async {
    try {
      await api.put(
        Endpoints.updateFirstName,
        queryParameters: {'firstName': firstName},
      );
      return await getProfileData();
    } catch (error) {
      return Left(error.toString());
    }
  }

  @override
  Future<Either<String, UserModel>> updateLastName(String lastName) async {
    try {
      await api.put(
        Endpoints.updateLastName,
        queryParameters: {'lastName': lastName},
      );
      return await getProfileData();
    } catch (error) {
      return Left(error.toString());
    }
  }

  @override
  Future<Either<String, void>> logout() async {
    try {
      await api.post(Endpoints.logout);
      return const Right(null);
    } catch (error) {
      return Left(error.toString());
    }
  }

  @override
  Future<Either<String, void>> delete() async {
    try {
      await api.delete(Endpoints.delete);
      return const Right(null);
    } catch (error) {
      return Left(error.toString());
    }
  }

  @override
  Future<Either<String, void>> getVerificationCode() async {
    try {
      await api.get(Endpoints.getVerificationCodeToResetPassword);
      return const Right(null);
    } catch (error) {
      return Left(error.toString());
    }
  }

  @override
  Future<Either<String, void>> resetPassword(
      String newPassword, String verificationCode) async {
    try {
      final data = {
        'newPassword': newPassword,
        'verificationCode': verificationCode,
      };
      await api.post(Endpoints.resetPasswordInProfile, data: data);
      return const Right(null);
    } catch (error) {
      return Left(error.toString());
    }
  }
}
