class MyFriendsModel {
  int? id;
  String? fristName;
  String? lastName;
  String? profileImageUrl;
  DateTime? createdAt;
  int? friendId;

  MyFriendsModel({
    this.id,
    this.fristName,
    this.lastName,
    this.profileImageUrl,
    this.createdAt,
    this.friendId,
  });

  factory MyFriendsModel.fromJson(Map<String, dynamic> json) => MyFriendsModel(
        id: json['id'] as int?,
        fristName: json['fristName'] as String?,
        lastName: json['lastName'] as String?,
        profileImageUrl: json['profileImageUrl'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        friendId: json['friendId'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'fristName': fristName,
        'lastName': lastName,
        'profileImageUrl': profileImageUrl,
        'createdAt': createdAt?.toIso8601String(),
        'friendId': friendId,
      };
}
