class Reactions {
  String? reactionType;
  int? userID;
  String? firstName;
  String? lastName;
  String? profileImageUrl;

  Reactions(
      {this.reactionType,
        this.userID,
        this.firstName,
        this.lastName,
        this.profileImageUrl});

  Reactions.fromJson(Map<String, dynamic> json) {
    reactionType = json['reactionType'];
    userID = json['userID'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profileImageUrl = json['profileImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reactionType'] = reactionType;
    data['userID'] = userID;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['profileImageUrl'] = profileImageUrl;
    return data;
  }
}
