import 'package:dio/dio.dart';
import '../../../../../core/utils/api/api_consumer.dart';
import '../../../../../core/utils/api/endpoints.dart';
import 'register_repo.dart';

class CustomException implements Exception {
  final String message;
  CustomException(this.message);
  @override
  String toString() => message;
}

class RegisterRepoImpl implements RegisterRepo {
  final ApiConsumer api;

  RegisterRepoImpl(this.api);

  @override
  Future<String> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String dateOfBirth,
    String? phoneNumber,
    String? profileImage,
    String? coverImage,
  }) async {
    try {
      final formData = FormData.fromMap({
        'FirstName': firstName,
        'LastName': lastName,
        'Email': email,
        'Password': password,
        'DateOfBirth': dateOfBirth,
        if (phoneNumber != null) 'PhoneNumber': phoneNumber,
        if (profileImage != null)
          'ProfileImage': await MultipartFile.fromFile(profileImage),
        if (coverImage != null)
          'CoverImage': await MultipartFile.fromFile(coverImage),
      });

      final response = await api.post(
        Endpoints.register,
        data: formData,
        isFromData: true,
      );

      if (response is String) {
        // رسالة النجاح أو الخطأ كـ String
        if (response
            .contains('Please check your email for the verification code.')) {
          return 'من فضلك تحقق من بريدك الإلكتروني للحصول على رمز التفعيل.';
        }

        // ترجمات للخطأ
        final errorTranslations = {
          'Email may already be registered': 'البريد الإلكتروني مسجل بالفعل',
          'Invalid date format': 'تنسيق تاريخ الميلاد غير صحيح',
          'Invalid email format': 'تنسيق البريد الإلكتروني غير صحيح',
        };

        for (final key in errorTranslations.keys) {
          if (response.contains(key)) {
            throw CustomException(errorTranslations[key]!);
          }
        }

        throw CustomException('حدث خطأ غير متوقع');
      }

      // لو الرد مش String (غالباً JSON) تعاملك معاه كـ JSON Model (لو حبيت)
      // ممكن ترجع رسالة عامة أو ترمي Exception لأنك مش متوقع JSON في حالة النجاح
      throw CustomException('حدث خطأ غير متوقع');
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data.toString() ?? 'حدث خطأ في الاتصال بالخادم';
      throw CustomException(_mapErrorToArabic(errorMessage));
    }
  }

  String _mapErrorToArabic(String message) {
    final errorTranslations = {
      'Email may already be registered': 'البريد الإلكتروني مسجل بالفعل',
      'Invalid date format': 'تنسيق تاريخ الميلاد غير صحيح',
      'Invalid email format': 'تنسيق البريد الإلكتروني غير صحيح',
    };

    for (final key in errorTranslations.keys) {
      if (message.contains(key)) return errorTranslations[key]!;
    }

    return 'حدث خطأ غير متوقع';
  }
}
