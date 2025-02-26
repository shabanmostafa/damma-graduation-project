import 'package:damma_project/core/utils/assets.dart';
import 'package:damma_project/features/welcome/presentation/views/widgets/buttons_section.dart';
import 'package:damma_project/features/welcome/presentation/views/widgets/welcom_text_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeViewBody extends StatelessWidget {
  const WelcomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            Assets.svgsWelcome,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Positioned(
            top: 162.h,
            left: 85.w,
            right: 85.w,
            child: Image.asset(Assets.svgsLogoWithoutWord),
          ),
        ),
        const WelcomeTextSection(),
        const ButtonsSection(),
      ],
    );
  }
}
