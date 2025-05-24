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

import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/assets.dart';
import 'package:damma_project/core/utils/routing/routes.dart';
import 'package:damma_project/core/utils/spacing.dart';
import 'package:damma_project/core/utils/widgets/custom_app_bar.dart';
import 'package:damma_project/features/profile/manager/cubit/profile_cubit.dart';
import 'package:damma_project/features/profile/manager/cubit/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ));
        } else if (state is ProfileSuccess) {
          final userId = state.profile.id; // ✅ This is correct now

          return Column(
            children: [
              const CustomAppBar(needArrow: false, text: "الإعدادات"),
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
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
                        title: "إعدادات الصفحة الشخصية",
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.upateProfileView,
                            arguments: userId,
                          );
                        },
                      ),
                      verticalSpace(16),
                      _buildSettingItem(
                        title: "الصفحة الشخصية",
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.profileView,
                            arguments: userId,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else if (state is ProfileFailure) {
          return Center(child: Text("حدث خطأ: ${state.error}"));
        } else {
          return const SizedBox.shrink(); // fallback
        }
      },
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
