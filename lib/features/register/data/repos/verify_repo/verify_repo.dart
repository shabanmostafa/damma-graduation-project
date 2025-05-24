abstract class VerifyRepo {
  Future<dynamic> verify(String email, String verificationCode);
  Future<String> resendVerificationCode(String email);
}
