import 'package:damma_project/core/utils/assets.dart';
import 'package:damma_project/core/utils/spacing.dart';
import 'package:damma_project/features/home/manager/home_cubit.dart';
import 'package:damma_project/features/home/presentation/views/widgets/custom_circleAvatar.dart';
import 'package:damma_project/features/home/presentation/views/widgets/what_thinking_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WhatThinkingSection extends StatelessWidget {
  const WhatThinkingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<HomeCubit>().state is HomeSuccess
        ? (context.read<HomeCubit>().state as HomeSuccess).user
        : null;

    return Row(
      children: [
        CustomCircleAvatar(imagePath: user?.profileImageUrl),
        horizontalSpace(8),
        const WhatThinkingBox(),
        const SizedBox(width: 10),
        GestureDetector(child: SvgPicture.asset(Assets.svgsAddImage)),
      ],
    );
  }
}
