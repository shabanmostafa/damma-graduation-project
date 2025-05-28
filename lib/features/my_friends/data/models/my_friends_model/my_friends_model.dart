import 'datum.dart';

class MyFriendsModel {
	String? message;
	int? totalCount;
	List<Datum>? data;

	MyFriendsModel({this.message, this.totalCount, this.data});

	factory MyFriendsModel.fromJson(Map<String, dynamic> json) {
		return MyFriendsModel(
			message: json['message'] as String?,
			totalCount: json['totalCount'] as int?,
			data: (json['data'] as List<dynamic>?)
						?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
						.toList(),
		);
	}



	Map<String, dynamic> toJson() => {
				'message': message,
				'totalCount': totalCount,
				'data': data?.map((e) => e.toJson()).toList(),
			};
}
