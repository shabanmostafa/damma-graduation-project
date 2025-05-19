import 'package:damma_project/core/utils/models/user_model.dart' show UserModel;
import 'package:damma_project/core/utils/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/app_colors.dart';

class FriendsInfo extends StatelessWidget {
  final UserModel profile;

  const FriendsInfo(this.profile, {super.key});

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
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Divider(
              color: AppColors.inactiveButtonColor, thickness: 8, height: 20.h),
        ],
      ),
    );
  }
}
