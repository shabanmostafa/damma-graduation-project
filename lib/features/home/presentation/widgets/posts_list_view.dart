import 'package:damma_project/features/home/presentation/widgets/post_card_view.dart';
import 'package:damma_project/features/home/presentation/widgets/what_thinking_section.dart';
import 'package:flutter/material.dart';

class PostsListView extends StatelessWidget {
  const PostsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        WhatThinkingSection(), // ✅ إضافة قسم كتابة المنشور
        PostCard(
          username: "شعبان مصطفي",
          userImage: "assets/1.jpg",
          postImage: "assets/images/1.jpg",
          description: "أيٌظلم لي ليلُ و انتِ قمري",
          likes: 32,
          comments: 77,
          shares: 9,
        ),
        PostCard(
          username: "سيف الدين حاتم",
          userImage: "assets/images/1.jpg",
          postImage: null, // بوست بدون صورة
          description: "زي اخويا شعبان م بيقول أيٌظلم لي ليلُ و انتِ قمري",
          likes: 50,
          comments: 20,
          shares: 8,
        ),
        PostCard(
          username: "شعبان مصطفي",
          userImage: "assets/images/1.jpg",
          postImage: "assets/4.jpg",
          description: "أيٌظلم لي ليلُ و انتِ قمري",
          likes: 32,
          comments: 77,
          shares: 9,
        ),
        PostCard(
          username: "سيف الدين حاتم",
          userImage: "assets/images/1.jpg",
          postImage: null, // بوست بدون صورة
          description: "زي اخويا شعبان م بيقول أيٌظلم لي ليلُ و انتِ قمري",
          likes: 50,
          comments: 20,
          shares: 8,
        ),
      ],
    );
  }
}
