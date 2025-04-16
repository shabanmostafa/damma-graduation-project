import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/svg.dart';

import '../assets.dart';
import '../spacing.dart';

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar({
    super.key,
    required this.errorText,
    required this.title,
    required this.containerColor,
    required this.bottomSvgColor,
    required this.topSvgColor,
    required this.icon,
  });

  final String title;
  final String errorText;
  final Color containerColor;
  final Color bottomSvgColor;
  final Color topSvgColor;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: containerColor,
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          child: Row(
            children: [
              horizontalSpace(48),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 18.sp, color: Colors.white),
                    ),
                    Text(errorText),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
            ),
            child: SvgPicture.asset(
              Assets.svgsBubbles,
              height: 48.h,
              width: 40.w,
              colorFilter: ColorFilter.mode(
                bottomSvgColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        Positioned(
          top: -15.h,
          left: 0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                Assets.svgsFail,
                height: 40.h,
                colorFilter: ColorFilter.mode(
                  topSvgColor,
                  BlendMode.srcIn,
                ),
              ),
              Center(
                child: icon,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
