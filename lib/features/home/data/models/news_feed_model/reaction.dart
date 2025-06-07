class Reaction {
	String? reactionType;
	int? userId;
	String? firstName;
	String? lastName;
	String? profileImageUrl;

	Reaction({
		this.reactionType, 
		this.userId, 
		this.firstName, 
		this.lastName, 
		this.profileImageUrl, 
	});

	factory Reaction.fromJson(Map<String, dynamic> json) => Reaction(
				reactionType: json['reactionType'] as String?,
				userId: json['userID'] as int?,
				firstName: json['firstName'] as String?,
				lastName: json['lastName'] as String?,
				profileImageUrl: json['profileImageUrl'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'reactionType': reactionType,
				'userID': userId,
				'firstName': firstName,
				'lastName': lastName,
				'profileImageUrl': profileImageUrl,
			};
}
