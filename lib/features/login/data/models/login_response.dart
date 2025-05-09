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
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      id: json['id'],
    );
  }
}