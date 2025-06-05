class ProfilePostModel {
  List<Posts>? posts;

  ProfilePostModel({this.posts});

  ProfilePostModel.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (posts != null) {
      data['posts'] = posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Posts {
  int? postId;
  String? postTitle;
  String? postBody;
  String? mediaUrl; // <-- التعديل هنا
  int? totalComments;
  int? totalReactions;
  List<Comments>? comments;
  List<Reactions>? reactions;

  Posts({
    this.postId,
    this.postTitle,
    this.postBody,
    this.mediaUrl,
    this.totalComments,
    this.totalReactions,
    this.comments,
    this.reactions,
  });

  Posts.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    postTitle = json['postTitle'];
    postBody = json['postBody'];
    mediaUrl = json['mediaUrl']; // <-- نفس التعديل
    totalComments = json['totalComments'];
    totalReactions = json['totalReactions'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
    if (json['reactions'] != null) {
      reactions = <Reactions>[];
      json['reactions'].forEach((v) {
        reactions!.add(Reactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['postId'] = postId;
    data['postTitle'] = postTitle;
    data['postBody'] = postBody;
    data['mediaUrl'] = mediaUrl; // <-- نفس التعديل
    data['totalComments'] = totalComments;
    data['totalReactions'] = totalReactions;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    if (reactions != null) {
      data['reactions'] = reactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

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
