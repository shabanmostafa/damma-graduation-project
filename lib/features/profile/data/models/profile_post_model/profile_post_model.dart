import 'post.dart';

class ProfilePostModel {
	List<Post>? posts;

	ProfilePostModel({this.posts});

	factory ProfilePostModel.fromJson(Map<String, dynamic> json) {
		return ProfilePostModel(
			posts: (json['posts'] as List<dynamic>?)
						?.map((e) => Post.fromJson(e as Map<String, dynamic>))
						.toList(),
		);
	}



	Map<String, dynamic> toJson() => {
				'posts': posts?.map((e) => e.toJson()).toList(),
			};
}
