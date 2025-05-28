import 'package:damma_project/core/utils/models/user_model.dart' show UserModel;
import 'package:damma_project/core/utils/routing/routes.dart';
import 'package:damma_project/core/utils/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/app_colors.dart';

class ProfileInfo extends StatelessWidget {
  final UserModel profile;

  const ProfileInfo(this.profile, {super.key});

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
                Wrap(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.friendView);
                      },
                      child: Text(
                        'الاصدقاء',
                        style: AppStyles.styleMedium12.copyWith(
                          color: AppColors.blackTextColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 20.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, Routes.requestesSendedView);
                      },
                      child: Text(
                        'طلبات الصداقة المرسلة',
                        style: AppStyles.styleMedium12.copyWith(
                          color: AppColors.blackTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          AppTextButton(
            backgroundColor: AppColors.inactiveButtonColor,
            borderRadius: 10.r,
            buttonWidth: 343.w,
            buttonHeight: 40.h,
            buttonText: "تعديل",
            textStyle: AppStyles.styleMedium14
                .copyWith(color: AppColors.blackTextColor),
            onPressed: () {
              Navigator.pushNamed(context, Routes.upateProfileView,
                  arguments: profile.id);
            },
          ),
          SizedBox(height: 20.h),
          Divider(
              color: AppColors.inactiveButtonColor, thickness: 8, height: 20.h),
        ],
      ),
    );
  }
}
