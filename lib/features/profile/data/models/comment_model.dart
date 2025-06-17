class Comments {
  int? commentId;
  String? content;
  int? userID;
  String? firstName;
  String? lastName;
  String? profileImageUrl;

  Comments(
      {this.commentId,
        this.content,
        this.userID,
        this.firstName,
        this.lastName,
        this.profileImageUrl});

  Comments.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    content = json['content'];
    userID = json['userID'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profileImageUrl = json['profileImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['commentId'] = commentId;
    data['content'] = content;
    data['userID'] = userID;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['profileImageUrl'] = profileImageUrl;
    return data;
  }
}

