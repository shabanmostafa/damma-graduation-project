// import 'package:damma_project/core/utils/app_styles.dart';
// import 'package:damma_project/core/utils/assets.dart';
// import 'package:damma_project/core/utils/spacing.dart';
// import 'package:damma_project/core/utils/widgets/custom_app_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class SettingsViewBody extends StatelessWidget {
//   const SettingsViewBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const CustomAppBar(needArrow: false, text: "الاعدادات"),
//           verticalSpace(32),
//           SvgPicture.asset(
//             Assets.svgsBlackLogo,
//           ),
//           verticalSpace(40),
//           Text(
//             "إعدادات الصفحة الشخصية",
//             style: AppStyles.styleBold16,
//           ),
//           verticalSpace(20),
//           Text(
//             "الصفحة الشخصية",
//             style: AppStyles.styleBold16,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/assets.dart';
import 'package:damma_project/core/utils/routing/routes.dart';
import 'package:damma_project/core/utils/spacing.dart';
import 'package:damma_project/core/utils/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(needArrow: false, text: "الإعدادات"),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SvgPicture.asset(
                    Assets.svgsBlackLogo,
                    height: 80.h,
                  ),
                ),
                verticalSpace(32),
                _buildSettingItem(
                    title: "إعدادات الصصفحة الشخصية",
                    onTap: () {
                      Navigator.pushNamed(context, Routes.upateProfileView);
                    }),
                verticalSpace(16),
                _buildSettingItem(
                    title: "الصفحة الشخصية",
                    onTap: () {
                      Navigator.pushNamed(context, Routes.profileView);
                    }),
                // Add more setting items here as needed
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem({
    required String title,
    IconData icon = Icons.person_outline,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.r,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey.shade800, size: 22.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: AppStyles.styleMedium16.copyWith(
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade600, size: 24.sp),
          ],
        ),
      ),
    );
  }
}
