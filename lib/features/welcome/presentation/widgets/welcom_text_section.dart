import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/l10n.dart';

class WelcomeTextSection extends StatelessWidget {
  const WelcomeTextSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 216.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).letsStart,
              style: AppStyles.styleBold36.copyWith(
                color: AppColors.whiteColor,
                fontSize: 40.sp,
              ),
            ),
            Text(
              S.of(context).createAccountToKnowInfo,
              style: AppStyles.styleLight16
                  .copyWith(color: AppColors.whiteColor, fontSize: 20.sp),
            ),
          ],
        ),
      ),
    );
  }
}
