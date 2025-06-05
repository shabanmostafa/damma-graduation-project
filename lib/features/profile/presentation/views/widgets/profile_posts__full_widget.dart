import 'package:damma_project/core/utils/models/user_model.dart';
import 'package:damma_project/features/profile/data/models/profile_post_model.dart';
import 'package:damma_project/features/profile/presentation/views/widgets/profile_post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';

class ProfilePostsFullWidget extends StatelessWidget {
  final List<Posts> posts;
  final UserModel profile;

  const ProfilePostsFullWidget(
      {super.key, required this.posts, required this.profile});

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 32.h),
        child: Text(
          'لا توجد منشورات بعد',
          style: AppStyles.styleMedium14.copyWith(
            color: AppColors.hintTextColor,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return PostCard(
          post: post,
          profile: profile,
        );
      },
    );
  }
}
