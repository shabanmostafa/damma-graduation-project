import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/features/profile/manager/cubit/profile_cubit.dart';
import 'package:damma_project/features/profile/manager/cubit/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../home/presentation/widgets/post_section.dart';
import '../../../profile/presentation/widgets/text_button_profile.dart';

class ProfilePosts extends StatelessWidget {
  const ProfilePosts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final cubit = context.read<ProfileCubit>();
        final posts = cubit.posts;

        if (posts.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 60.h),
            child: Text('لم يتم النشر بعد',
                style: AppStyles.styleMedium14.copyWith(
                  color: AppColors.hintTextColor,
                )),
          );
        }

        return Column(
          children: [
            PostSection(postModel: posts[0]),
            if (cubit.showAllPosts) ...[
              for (int i = 1; i < posts.length; i++) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(),
                ),
                PostSection(postModel: posts[i]),
              ],
            ] else if (posts.length > 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButtonProfile(
                    text: 'عرض كل المنشورات',
                    onPressed: () => cubit.toggleShowAllPosts(),
                  ),
                  Icon(Icons.arrow_forward,
                      color: AppColors.blackTextColor, size: 16.r),
                ],
              ),
            Divider(
              color: AppColors.inactiveButtonColor,
              thickness: 8,
              height: 20.h,
            ),
          ],
        );
      },
    );
  }
}
