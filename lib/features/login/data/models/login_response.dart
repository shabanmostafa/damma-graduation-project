class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final int id;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.id,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'],
      refreshToken: json['refreshToken'],
      id: json['id'],
    );
  }
}
