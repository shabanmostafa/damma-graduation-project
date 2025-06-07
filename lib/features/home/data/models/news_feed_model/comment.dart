class Comment {
	int? commentId;
	String? content;
	int? userId;
	String? firstName;
	String? lastName;
	String? profileImageUrl;

	Comment({
		this.commentId, 
		this.content, 
		this.userId, 
		this.firstName, 
		this.lastName, 
		this.profileImageUrl, 
	});

	factory Comment.fromJson(Map<String, dynamic> json) => Comment(
				commentId: json['commentId'] as int?,
				content: json['content'] as String?,
				userId: json['userID'] as int?,
				firstName: json['firstName'] as String?,
				lastName: json['lastName'] as String?,
				profileImageUrl: json['profileImageUrl'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'commentId': commentId,
				'content': content,
				'userID': userId,
				'firstName': firstName,
				'lastName': lastName,
				'profileImageUrl': profileImageUrl,
			};
}
