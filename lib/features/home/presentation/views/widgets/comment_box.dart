import 'package:damma_project/features/home/presentation/views/widgets/custom_circleAvatar.dart';
import 'package:flutter/material.dart';

class CommentBox extends StatelessWidget {
  const CommentBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          const CustomCircleAvatar(),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                "اكتب تعليق...",
                style: TextStyle(color: Colors.grey[700], fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
