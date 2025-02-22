import 'package:flutter/material.dart';

class PostActions extends StatelessWidget {
  const PostActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.thumb_up_off_alt, color: Colors.grey[700]),
              label: Text("أعجبني", style: TextStyle(color: Colors.grey[700])),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.comment_outlined, color: Colors.grey[700]),
              label: Text("تعليق", style: TextStyle(color: Colors.grey[700])),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.repeat, color: Colors.grey[700]),
              label:
                  Text("إعادة نشر", style: TextStyle(color: Colors.grey[700])),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.share, color: Colors.grey[700]),
              label: Text("مشاركة", style: TextStyle(color: Colors.grey[700])),
            ),
          ),
        ],
      ),
    );
  }
}
