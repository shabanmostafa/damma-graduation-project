import 'package:flutter/material.dart';

class PostInfo extends StatelessWidget {
  const PostInfo(
      {super.key,
      required this.likes,
      required this.comments,
      required this.shares});
  final int likes;
  final int comments;
  final int shares;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$likes إعجاب",
              style: TextStyle(color: Colors.grey[700], fontSize: 12)),
          Text("$comments تعليق • $shares إعادة نشر",
              style: TextStyle(color: Colors.grey[700], fontSize: 12)),
        ],
      ),
    );
  }
}
