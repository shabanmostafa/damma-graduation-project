

// import '../../../../core/utils/api/api_consumer.dart';
// import '../../../../core/utils/api/endpoints.dart';
// import '../models/login_response.dart';

// class LoginRepoImpl {
//   final ApiConsumer api;

//   LoginRepoImpl(this.api);

//   Future<LoginResponse> login(String email, String password) async {
//     final response = await api.post(
//       Endpoints.login,
//       data: {
//         'email': email,
//         'password': password,
//       },
//       isFromData: false,
//     );

//     if (response is String && response == "Invalid email or password.") {
//       throw Exception(response);
//     }

//     return LoginResponse.fromJson(response);
//   }
// }
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/utils/api/api_consumer.dart';
import '../../../../core/utils/api/endpoints.dart';
import '../models/login_response.dart';

class LoginRepoImpl {
  final ApiConsumer api;

  LoginRepoImpl(this.api);

  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await api.post(
        Endpoints.login,
        data: {
          'email': email,
          'password': password,
        },
        isFromData: false,
      );

      if (response is String && response == "Invalid email or password.") {
        throw Exception("البريد الإلكتروني أو كلمة المرور غير صحيحة.");
      }

      return LoginResponse.fromJson(response);
    } on DioException catch (e) {
      if (e.response != null &&
          (e.response?.statusCode == 400 || e.response?.statusCode == 401)) {
        throw Exception("البريد الإلكتروني أو كلمة المرور غير صحيحة.");
      } else {
        throw Exception("حدث خطأ ما. يرجى المحاولة لاحقًا.");
      }
    } on SocketException {
      throw Exception("تحقق من اتصالك بالإنترنت وحاول مرة أخرى.");
    } catch (e) {
      throw Exception("حدث خطأ غير متوقع.");
    }
  }
}
