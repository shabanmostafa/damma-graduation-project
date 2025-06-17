import 'package:damma_project/features/profile/data/models/reaction_model.dart';

import 'comment_model.dart';

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

