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
        Container(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            Assets.welcomeImg,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Positioned(
            top: 162.h,
            left: 85.w,
            right: 85.w,
            child: Image.asset(Assets.appLogo),
          ),
        ),
        const WelcomeTextSection(),
        const ButtonsSection(),
      ],
    );
  }
}
