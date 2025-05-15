import 'package:damma_project/core/utils/assets.dart';
import 'package:damma_project/core/utils/spacing.dart';
import 'package:damma_project/features/home/presentation/views/widgets/custom_circleAvatar.dart';
import 'package:damma_project/features/home/presentation/views/widgets/what_thinking_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WhatThinkingSection extends StatelessWidget {
  const WhatThinkingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomCircleAvatar(),
        horizontalSpace(8),
        const WhatThinkingBox(),
        const SizedBox(width: 10),
        GestureDetector(child: SvgPicture.asset(Assets.svgsAddImage)),
      ],
    );
  }
}
