import 'package:damma_project/features/home/presentation/widgets/comment_box.dart';
import 'package:damma_project/features/home/presentation/widgets/post_actions.dart';
import 'package:damma_project/features/home/presentation/widgets/post_content.dart';
import 'package:damma_project/features/home/presentation/widgets/post_info.dart';
import 'package:damma_project/features/home/presentation/widgets/publisher_info.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String username;
  final String userImage;
  final String? postImage;
  final String description;
  final int likes;
  final int comments;
  final int shares;

  const PostCard({
    super.key,
    required this.username,
    required this.userImage,
    this.postImage,
    required this.description,
    required this.likes,
    required this.comments,
    required this.shares,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PublisherInfo(userImage: userImage, username: username),
          PostContent(description: description, postImage: postImage),
          PostInfo(likes: likes, comments: comments, shares: shares),
          const Divider(),
          const PostActions(),
          const CommentBox(),
        ],
      ),
    );
  }
}
