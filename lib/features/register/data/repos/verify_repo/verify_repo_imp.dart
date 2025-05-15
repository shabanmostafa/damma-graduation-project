// import 'package:damma_project/features/register/data/repos/verify_repo/verify_repo.dart';

// import '../../../../../core/utils/api/api_consumer.dart';
// import '../../../../../core/utils/api/endpoints.dart';

// class VerifyRepoImpl implements VerifyRepo {
//   final ApiConsumer api;

//   VerifyRepoImpl(this.api);

//   @override
//   Future<String> verify(String email, String code) async {
//     try {
//       final response = await api.post(
//         Endpoints.verify, // Changed from login to verifyEmail
//         data: {
//           'email': email,
//           'code': code, // Changed from password to code
//         },
//         isFromData: false,
//       );

//       if (response is String && response == "Invalid email or Code.") {
//         throw Exception(response);
//       }

//       return "Account verified successfully";
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }
// }

import 'package:dio/dio.dart';
import '../../../../../core/utils/api/api_consumer.dart';
import '../../../../../core/utils/api/endpoints.dart';
import '../register_repos/register_repo_imp.dart';
import 'verify_repo.dart';

class VerifyRepoImpl implements VerifyRepo {
  final ApiConsumer api;

  VerifyRepoImpl(this.api);

  @override
  Future<String> verify(String email, String code) async {
    try {
      final response = await api.post(
        Endpoints.verify,
        data: {
          'email': email,
          'code': code,
        },
        isFromData: false,
      );

      if (response is String) {
        // رسالة النجاح
        if (response
            .contains("Email verified successfully. You can now log in.")) {
          return "تم تأكيد البريد الإلكتروني بنجاح. يمكنك الآن تسجيل الدخول.";
        }

        // ترجمات الأخطاء
        final errorTranslations = {
          "Invalid verification code.": "كود التحقق غير صحيح.",
          "Invalid email or Code.": "البريد الإلكتروني أو كود التحقق غير صحيح.",
        };

        for (final key in errorTranslations.keys) {
          if (response.contains(key)) {
            throw CustomException(errorTranslations[key]!);
          }
        }

        // رسالة غير معروفة
        throw CustomException("حدث خطأ غير متوقع: $response");
      }

      // رد غير متوقع (مش String)
      throw CustomException("استجابة غير معروفة من الخادم.");
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data.toString() ?? 'حدث خطأ في الاتصال بالخادم';
      throw CustomException(_mapErrorToArabic(errorMessage));
    }
  }

  String _mapErrorToArabic(String message) {
    final errorTranslations = {
      "Invalid verification code.": "كود التحقق غير صحيح.",
      "Invalid email or Code.": "البريد الإلكتروني أو كود التحقق غير صحيح.",
    };

    for (final key in errorTranslations.keys) {
      if (message.contains(key)) return errorTranslations[key]!;
    }

    return "البريد الإلكتروني أو كود التحقق غير صحيح.";
  }

  @override
Future<String> resendVerificationCode(String email) async {
  try {
    final response = await api.post(
      Endpoints.resendVerification,
      data: email, // Raw string body
      isFromData: false, // Important: to send raw string not as map
    );

    if (response is String && response.contains("Verification code resent successfully.")) {
      return "تم إعادة إرسال رمز التحقق بنجاح.";
    }

    throw CustomException("حدث خطأ غير متوقع: $response");
  } on DioException catch (e) {
    final errorMessage = e.response?.data.toString() ?? 'حدث خطأ في الاتصال بالخادم';
    throw CustomException("فشل إرسال رمز التحقق: $errorMessage");
  }
}

}
