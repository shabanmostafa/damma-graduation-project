import 'package:damma_project/core/utils/models/user_model.dart' show UserModel;
import 'package:damma_project/core/utils/routing/routes.dart';
import 'package:damma_project/core/utils/spacing.dart';
import 'package:damma_project/core/utils/widgets/app_text_button.dart';
import 'package:damma_project/features/profile/presentation/views/widgets/text_button_profile.dart';
import 'package:damma_project/features/search/data/models/search_model/search_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/app_colors.dart';

class IsFriendProfileInfo extends StatelessWidget {
  final UserModel profile;
  final onPressed;


  const IsFriendProfileInfo(this.profile, {super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h),
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
          verticalSpace(2),

          SizedBox(height: 20.h),
          AppTextButton(
              backgroundColor: AppColors.primaryColor,
              borderRadius: 10.r,
              buttonWidth: 343.w,
              buttonHeight: 40.h,
              buttonText: "الغاء الصداقة",
              textStyle: AppStyles.styleMedium14
                  .copyWith(color: AppColors.whiteColor),
              onPressed:onPressed

          ),
          SizedBox(height: 20.h),
          Divider(
              color: AppColors.inactiveButtonColor, thickness: 8, height: 20.h),
        ],
      ),
    );
  }
}
