class Datum {
	int? id;
	String? firstName;
	String? lastName;
	String? profileImageUrl;
	DateTime? createdAt;
	int? friendId;

	Datum({
		this.id, 
		this.firstName, 
		this.lastName, 
		this.profileImageUrl, 
		this.createdAt, 
		this.friendId, 
	});

	factory Datum.fromJson(Map<String, dynamic> json) => Datum(
				id: json['id'] as int?,
				firstName: json['firstName'] as String?,
				lastName: json['lastName'] as String?,
				profileImageUrl: json['profileImageUrl'] as String?,
				createdAt: json['createdAt'] == null
						? null
						: DateTime.parse(json['createdAt'] as String),
				friendId: json['friendId'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'firstName': firstName,
				'lastName': lastName,
				'profileImageUrl': profileImageUrl,
				'createdAt': createdAt?.toIso8601String(),
				'friendId': friendId,
			};
}
