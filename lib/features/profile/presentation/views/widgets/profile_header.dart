import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/assets.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Stack(
          children: [
            SizedBox(
              width: 375.w,
              height: 150.h,
              child: Image.asset(
                'assets/images/onBoarding3.png',
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: CircleAvatar(
                backgroundColor: AppColors.hintTextColor,
                radius: 16.r,
                child: SvgPicture.asset(Assets.svgsClock),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: -30.h,
          left: (375.w / 2) - 60.r,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -6,
                child: CircleAvatar(
                  radius: 65.r,
                  backgroundColor: AppColors.whiteColor,
                ),
              ),
              CircleAvatar(
                radius: 60.r,
                backgroundImage: const AssetImage('assets/images/shaban.jpg'),
              ),
              Positioned(
                bottom: 8,
                right: 4,
                child: CircleAvatar(
                  backgroundColor: AppColors.hintTextColor,
                  radius: 16.r,
                  child: SvgPicture.asset(Assets.svgsClock),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
