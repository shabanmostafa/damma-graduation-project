// class Endpoints {
//   static String baseUrl = 'https://vcare.integration25.com/api/';
//   static String login = 'auth/login';
//   static String register = 'auth/register';
//   static String fetchDoctors = 'doctor/index';

//   // static String getUserDataEndPoint(id) {
//   //   return 'user/get-user/$id';
//   // }
// }

// class ApiKey {
//   static String message = 'message';
//   static String data = 'data';
//   static String token = 'token';
//   static String username = 'username';
//   static String status = 'status';
//   static String code = 'code';
//   static String email = 'email';
//   static String password = 'password';
//   static String passwordConfirmation = 'password_confirmation';
//   static String name = 'name';
//   static String phone = 'phone';
//   static String gender = 'gender';
//   static String id = 'id';
// }
class Endpoints {
  static String baseUrl = 'http://dama.runasp.net/api/';
  static String login = 'Auth/login';
  static String register = 'Auth/register';
  static String verify = 'Auth/verify';
  static String resendVerification = 'Auth/resend-verification';
  static String basicInfo = 'Profile/basicInfo';
  static String getFriends = 'Profile/Friends';
  static String search = 'Search';
  static String coverImage = 'Setting/cover-image';
  static String profileImage = 'Setting/profile-image';
  static String updateFirstName = 'Setting/first-name';
  static String updateLastName = 'Setting/last-name';
  static String logout = 'Setting/logout';
  static String delete = 'Setting/account';
  static String getVerificationCodeToResetPassword =
      'Setting/get-verification-code';
  static String resetPasswordInProfile = 'Setting/reset-password';
  static const String isFriend = 'Profile/isFriend';
  static const String sendFriendRequest = 'Friends/sendFriendRequest';
  static const String deleteFriend = 'Friends';

  // static String getUserDataEndPoint(id) {
  //   return 'user/get-user/$id';
  // }
}

class ApiKey {
  static String accessToken = 'accessToken';
  static String refreshToken = 'refreshToken';
  static String id = 'id';
  static String email = 'email';
  static String password = 'password';
}
