import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/features/add_post/presentation/views/add_post_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../generated/l10n.dart';

class WhatThinkingBox extends StatelessWidget {
  const WhatThinkingBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration:
                  const Duration(milliseconds: 500), // مدة الانتقال
              pageBuilder: (_, __, ___) =>
                  const AddPostView(), // الصفحة الجديدة
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(
                  opacity: animation, // تأثير الـ Fade-in
                  child: child,
                );
              },
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.hintTextColor.withOpacity(.25),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            S.of(context).whatDoYouThink,
            style: AppStyles.styleLight12
                .copyWith(color: AppColors.blackTextColor, fontSize: 14.sp),
          ),
        ),
      ),
    );
  }
}
