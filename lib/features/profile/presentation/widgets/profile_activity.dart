import 'package:damma_project/core/utils/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/widgets/app_text_button.dart';

class ProfileActivity extends StatelessWidget {
  const ProfileActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text('نشاطك', style: AppStyles.styleBold18),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.addPostView,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text('إنشاء منشور',
                          style: AppStyles.styleMedium12.copyWith(
                            color: AppColors.primaryColor,
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Align(
            alignment: Alignment.topRight,
            child: AppTextButton(
              borderRadius: 16.r,
              buttonHeight: 32.h,
              buttonWidth: 80.w,
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
