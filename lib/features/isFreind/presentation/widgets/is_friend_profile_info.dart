import 'package:damma_project/core/utils/models/user_model.dart' show UserModel;
import 'package:damma_project/core/utils/routing/routes.dart';
import 'package:damma_project/core/utils/spacing.dart';
import 'package:damma_project/core/utils/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/app_colors.dart';

class IsFriendProfileInfo extends StatelessWidget {
  final UserModel profile;

  const IsFriendProfileInfo(this.profile, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${profile.firstName ?? ''} ${profile.lastName ?? ''}',
                    style: AppStyles.styleBold18),
                SizedBox(height: 4.h),
                Text(profile.dateOfBirth ?? '',
                    style: AppStyles.styleMedium14
                        .copyWith(color: AppColors.blackTextColor)),
              ],
            ),
          ),
          verticalSpace(5),
          Row(
            mainAxisSize:
                MainAxisSize.min, // so it wraps content, no extra space
            children: [
              AppTextButton(
                borderRadius: 16.r,
                buttonHeight: 40.h,
                buttonWidth: 85.w,
                buttonText: 'صديق',
                onPressed: () {},
                textStyle: AppStyles.styleMedium12
                    .copyWith(color: AppColors.whiteColor),
              ),
              SizedBox(width: 8.w), // spacing between button and icon
              Icon(
                Icons.check_circle_outline, // correct outlined check icon
                size: 28.sp,
                color: AppColors
                    .primaryColor, // or white if you want to match text color
              ),
            ],
          ),
          verticalSpace(5),
          Divider(
              color: AppColors.inactiveButtonColor, thickness: 8, height: 20.h),
        ],
      ),
    );
  }
}
