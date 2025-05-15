import 'package:damma_project/features/friends_page/presentation/views/friends_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/app_colors.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

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
                Text('شعبان مصطفي', style: AppStyles.styleBold18),
                SizedBox(height: 4.h),
                Text('Flutter Developer',
                    style: AppStyles.styleMedium14
                        .copyWith(color: AppColors.blackTextColor)),
                Text('الجيزة - مصر',
                    style: AppStyles.styleMedium14
                        .copyWith(color: AppColors.hintTextColor)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FriendsPageView(),
                        ));
                  },
                  child: Text(
                    '٥٠٠+ صديق',
                    style: AppStyles.styleLight12.copyWith(
                      decoration: TextDecoration.underline,
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
