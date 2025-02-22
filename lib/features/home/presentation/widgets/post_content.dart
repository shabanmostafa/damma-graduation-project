import 'package:flutter/material.dart';

class PostContent extends StatelessWidget {
  final String? postImage;
  final String description;

  const PostContent({
    super.key,
    this.postImage,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            description,
            style: const TextStyle(fontSize: 15),
            textAlign: TextAlign.right,
          ),
        ),
        if (postImage != null && postImage!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Image.asset(postImage!, fit: BoxFit.cover),
          ),
      ],
    );
  }
}
