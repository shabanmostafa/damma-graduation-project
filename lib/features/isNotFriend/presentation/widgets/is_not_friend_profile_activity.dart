import 'package:damma_project/core/utils/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/widgets/app_text_button.dart';

class IsNotFriendProfileActivity extends StatelessWidget {
  const IsNotFriendProfileActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Column(
        children: [
          SizedBox(height: 24.h),
          Align(
            alignment: Alignment.topRight,
            child: AppTextButton(
              borderRadius: 16.r,
              buttonHeight: 40.h,
              buttonWidth: 90.w,
              buttonText: 'المنشورات',
              onPressed: () {},
              textStyle:
                  AppStyles.styleMedium12.copyWith(color: AppColors.whiteColor),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
