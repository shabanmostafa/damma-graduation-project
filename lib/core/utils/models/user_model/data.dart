import 'package:equatable/equatable.dart';

class Data extends Equatable {
	final String? token;
	final String? username;

	const Data({this.token, this.username});

	factory Data.fromJson(Map<String, dynamic> json) => Data(
				token: json['token'] as String?,
				username: json['username'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'token': token,
				'username': username,
			};

	@override
	List<Object?> get props => [token, username];
}
