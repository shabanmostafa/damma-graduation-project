class UserModel {
	int? id;
	String? firstName;
	String? lastName;
	String? dateOfBirth;
	String? profileImageUrl;
	String? coverImageUrl;

	UserModel({
		this.id, 
		this.firstName, 
		this.lastName, 
		this.dateOfBirth, 
		this.profileImageUrl, 
		this.coverImageUrl, 
	});

	factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
				id: json['id'] as int?,
				firstName: json['firstName'] as String?,
				lastName: json['lastName'] as String?,
				dateOfBirth: json['dateOfBirth'] as String?,
				profileImageUrl: json['profileImageUrl'] as String?,
				coverImageUrl: json['coverImageUrl'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'firstName': firstName,
				'lastName': lastName,
				'dateOfBirth': dateOfBirth,
				'profileImageUrl': profileImageUrl,
				'coverImageUrl': coverImageUrl,
			};
}
