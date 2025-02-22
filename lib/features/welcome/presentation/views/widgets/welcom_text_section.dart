import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeTextSection extends StatelessWidget {
  const WelcomeTextSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Positioned(
        top: 446.h,
        left: 59.w,
        right: 20.w,
        bottom: 219,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'هيا نبدأ !',
              style: AppStyles.styleBold36.copyWith(
                  color: AppColors.whiteColor, fontFamily: 'GE SS Two'),
            ),
            Text(
              'انشأ حسابا لتستطيع الاطلاع علي اهم اخبار العرب ومعرفه اشخاص جدد',
              style: AppStyles.styleMedium20.copyWith(
                  color: AppColors.whiteColor, fontFamily: 'GE SS Two'),
            ),
          ],
        ),
      ),
    );
  }
}
