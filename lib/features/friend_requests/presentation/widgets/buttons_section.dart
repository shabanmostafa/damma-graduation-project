import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonsSection extends StatelessWidget {
  const ButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppTextButton(
            buttonHeight: 40.h,
            buttonWidth: 54.w,
            buttonText: 'قبول',
            textStyle:
                AppStyles.styleLight12.copyWith(color: AppColors.whiteColor),
            onPressed: () {}),
        const SizedBox(width: 8),
        AppTextButton(
            backgroundColor: AppColors.hintTextColor,
            buttonHeight: 40.h,
            buttonWidth: 54.w,
            buttonText: 'رفض',
            textStyle: AppStyles.styleLight12
                .copyWith(color: AppColors.blackTextColor),
            onPressed: () {})
      ],
    );
  }
}
