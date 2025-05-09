

import '../../../../core/utils/api/api_consumer.dart';
import '../../../../core/utils/api/endpoints.dart';
import '../models/login_response.dart';

class LoginRepoImpl {
  final ApiConsumer api;

  LoginRepoImpl(this.api);

  Future<LoginResponse> login(String email, String password) async {
    final response = await api.post(
      Endpoints.login,
      data: {
        'email': email,
        'password': password,
      },
      isFromData: false,
    );

    if (response is String && response == "Invalid email or password.") {
      throw Exception(response);
    }

    return LoginResponse.fromJson(response);
  }
}
