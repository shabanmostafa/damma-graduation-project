import 'datum.dart';

class PendingFriends {
	String? message;
	int? count;
	List<Datum>? data;

	PendingFriends({this.message, this.count, this.data});

	factory PendingFriends.fromJson(Map<String, dynamic> json) {
		return PendingFriends(
			message: json['message'] as String?,
			count: json['count'] as int?,
			data: (json['data'] as List<dynamic>?)
						?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
						.toList(),
		);
	}



	Map<String, dynamic> toJson() => {
				'message': message,
				'count': count,
				'data': data?.map((e) => e.toJson()).toList(),
			};
}
