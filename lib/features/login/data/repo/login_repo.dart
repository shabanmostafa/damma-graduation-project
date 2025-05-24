import 'package:damma_project/features/login/data/models/login_response.dart';

abstract class LoginRepo {
  Future<LoginResponse> login(String email, String password);
}
