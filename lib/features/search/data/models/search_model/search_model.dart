class SearchModel {
	int? id;
	String? firstName;
	String? lastName;
	String? profileImageUrl;
	int? mutualFriendsCount;

	SearchModel({
		this.id, 
		this.firstName, 
		this.lastName, 
		this.profileImageUrl, 
		this.mutualFriendsCount, 
	});

	factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
				id: json['id'] as int?,
				firstName: json['firstName'] as String?,
				lastName: json['lastName'] as String?,
				profileImageUrl: json['profileImageUrl'] as String?,
				mutualFriendsCount: json['mutualFriendsCount'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'firstName': firstName,
				'lastName': lastName,
				'profileImageUrl': profileImageUrl,
				'mutualFriendsCount': mutualFriendsCount,
			};
}
