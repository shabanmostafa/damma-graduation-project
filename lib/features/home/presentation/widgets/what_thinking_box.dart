import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/features/add_post/views/add_post_view.dart';
import 'package:flutter/material.dart';

class WhatThinkingBox extends StatelessWidget {
  const WhatThinkingBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPostView()),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Text(
            "بم تفكر؟",
            style: TextStyle(color: AppColors.hintTextColor, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
