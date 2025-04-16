class ErrorModel {
  final String? message;
  final Data? data;
  final bool? status;
  final int? code;

  const ErrorModel({this.message, this.data, this.status, this.code});

  ErrorModel copyWith({String? message, Data? data, bool? status, int? code}) {
    return ErrorModel(
      message: message ?? this.message,
      data: data ?? this.data,
      status: status ?? this.status,
      code: code ?? this.code,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'message': message,
      'data': data?.toJson(),
      'status': status,
      'code': code,
    };
  }

  static ErrorModel fromJson(Map<String, Object?> json) {
    return ErrorModel(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, Object?>),
      status: json['status'] as bool?,
      code: json['code'] as int?,
    );
  }

  @override
  String toString() {
    return '''ErrorModel(
      message: $message,
      data: ${data.toString()},
      status: $status,
      code: $code
    )''';
  }

  @override
  bool operator ==(Object other) {
    return other is ErrorModel &&
        other.message == message &&
        other.data == data &&
        other.status == status &&
        other.code == code;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, message, data, status, code);
  }
}

class Data {
  final List<String>? name;
  final List<String>? email;
  final List<String>? phone;
  final List<String>? gender;
  final List<String>? password;

  const Data({this.name, this.email, this.phone, this.gender, this.password});

  Data copyWith(
      {List<String>? name,
      List<String>? email,
      List<String>? phone,
      List<String>? gender,
      List<String>? password}) {
    return Data(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      password: password ?? this.password,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'gender': gender,
      'password': password,
    };
  }

  static Data fromJson(Map<String, Object?> json) {
    return Data(
      name: json['name'] as List<String>?,
      email: json['email'] as List<String>?,
      phone: json['phone'] as List<String>?,
      gender: json['gender'] as List<String>?,
      password: json['password'] as List<String>?,
    );
  }

  @override
  String toString() {
    return '''Data(
      name: $name,
      email: $email,
      phone: $phone,
      gender: $gender,
      password: $password
    )''';
  }

  @override
  bool operator ==(Object other) {
    return other is Data &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.gender == gender &&
        other.password == password;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, name, email, phone, gender, password);
  }
}
