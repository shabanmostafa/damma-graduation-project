import 'comment.dart';
import 'reaction.dart';

class NewsFeedModel {
	int? userId;
	String? firstName;
	String? lastName;
	String? profileImageUrl;
	int? postId;
	String? postTitle;
	String? postBody;
	String? mediaUrl;
	int? totalComments;
	int? totalReactions;
	List<Comment>? comments;
	List<Reaction>? reactions;

	NewsFeedModel({
		this.userId, 
		this.firstName, 
		this.lastName, 
		this.profileImageUrl, 
		this.postId, 
		this.postTitle, 
		this.postBody, 
		this.mediaUrl, 
		this.totalComments, 
		this.totalReactions, 
		this.comments, 
		this.reactions, 
	});

	factory NewsFeedModel.fromJson(Map<String, dynamic> json) => NewsFeedModel(
				userId: json['userId'] as int?,
				firstName: json['firstName'] as String?,
				lastName: json['lastName'] as String?,
				profileImageUrl: json['profileImageUrl'] as String?,
				postId: json['postId'] as int?,
				postTitle: json['postTitle'] as String?,
				postBody: json['postBody'] as String?,
				mediaUrl: json['mediaUrl'] as String?,
				totalComments: json['totalComments'] as int?,
				totalReactions: json['totalReactions'] as int?,
				comments: (json['comments'] as List<dynamic>?)
						?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
						.toList(),
				reactions: (json['reactions'] as List<dynamic>?)
						?.map((e) => Reaction.fromJson(e as Map<String, dynamic>))
						.toList(),
			);

	Map<String, dynamic> toJson() => {
				'userId': userId,
				'firstName': firstName,
				'lastName': lastName,
				'profileImageUrl': profileImageUrl,
				'postId': postId,
				'postTitle': postTitle,
				'postBody': postBody,
				'mediaUrl': mediaUrl,
				'totalComments': totalComments,
				'totalReactions': totalReactions,
				'comments': comments?.map((e) => e.toJson()).toList(),
				'reactions': reactions?.map((e) => e.toJson()).toList(),
			};
}
