abstract class RegisterRepo {
  Future<String> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String dateOfBirth,
    String? phoneNumber,
    String? profileImage,
    String? coverImage,
  });

}
