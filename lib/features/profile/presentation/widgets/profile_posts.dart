import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/features/home/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../home/presentation/widgets/post_section.dart';
import '../../../profile/presentation/widgets/text_button_profile.dart';

class ProfilePosts extends StatefulWidget {
  final List<PostModel> posts;

  ProfilePosts({
    super.key,
    required this.posts,
  });

  @override
  State<ProfilePosts> createState() => _ProfilePostsState();
}

class _ProfilePostsState extends State<ProfilePosts> {
  bool showAllPosts = false;
  @override
  Widget build(BuildContext context) {
    if (widget.posts.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 60.h),
        child: Text(
          'لم يتم النشر بعد',
          style: AppStyles.styleMedium14.copyWith(
            color: AppColors.hintTextColor,
          ),
        ),
      );
    }

    return Column(
      children: [
        PostSection(postModel: widget.posts[0]),
        if (showAllPosts) ...[
          for (int i = 1; i < widget.posts.length; i++) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(),
            ),
            PostSection(postModel: widget.posts[i]),
          ],
        ] else if (widget.posts.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButtonProfile(
                text: 'عرض كل المنشورات',
                onPressed: () {
                  setState(() {
                    showAllPosts = !showAllPosts;
                  });
                  // Toggle the state
                },
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
  }
}
