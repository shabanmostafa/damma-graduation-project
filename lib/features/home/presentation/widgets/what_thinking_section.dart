import 'package:damma_project/features/home/presentation/widgets/custom_circleAvatar.dart';
import 'package:damma_project/features/home/presentation/widgets/what_thinking_box.dart';
import 'package:flutter/material.dart';

class WhatThinkingSection extends StatelessWidget {
  const WhatThinkingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        children: [
          const CustomCircleAvatar(),
          const SizedBox(width: 10),
          const WhatThinkingBox(),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.image, color: Colors.green, size: 28),
            onPressed: () {}, // زر لإضافة صورة
          ),
        ],
      ),
    );
  }
}
