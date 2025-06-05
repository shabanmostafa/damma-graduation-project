import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildPostStats({required int likeCount, required int commentCount}) {
  return Row(
    children: [
      Icon(Icons.favorite, color: AppColors.red500Color, size: 18.sp),
      horizontalSpace(5),
      Text('$likeCount اعجاب', style: AppStyles.styleMedium12),
      const Spacer(),
      Text('$commentCount تعليق', style: AppStyles.styleMedium12),
      horizontalSpace(10),
      Text('0 اعادة نشر', style: AppStyles.styleMedium12),
    ],
  );
}

Widget buildPostActions({
  required VoidCallback toggleLike,
  required VoidCallback openCommentSection,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      buildActionButton(
        icon: Icons.favorite_border,
        label: 'اعجاب',
        onPressed: toggleLike,
      ),
      buildActionButton(
        icon: Icons.comment_outlined,
        label: 'تعليق',
        onPressed: openCommentSection,
      ),
      buildActionButton(
        icon: Icons.share,
        label: 'مشاركة',
        onPressed: () {}, // Add sharing logic later
      ),
    ],
  );
}

Widget buildCommentInput(String? profileImageUrl) {
  return Row(
    children: [
      CircleAvatar(
        radius: 20.r,
        backgroundColor: AppColors.primaryColor.withOpacity(0.1),
        child: profileImageUrl != null
            ? ClipOval(
                child: Image.network(
                  profileImageUrl,
                  width: 40.w,
                  height: 40.h,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => buildSmallDefaultAvatar(),
                ),
              )
            : buildSmallDefaultAvatar(),
      ),
      horizontalSpace(8),
      Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            'اكتب تعليق...',
            style: AppStyles.styleMedium12,
          ),
        ),
      ),
    ],
  );
}

Widget buildDefaultAvatar() =>
    Icon(Icons.person, size: 25.r, color: AppColors.primaryColor);

Widget buildSmallDefaultAvatar() =>
    Icon(Icons.person, size: 20.r, color: AppColors.primaryColor);

Widget buildActionButton({
  required IconData icon,
  required String label,
  VoidCallback? onPressed,
  Color? color,
}) {
  return TextButton.icon(
    onPressed: onPressed,
    icon: Icon(icon, color: color ?? AppColors.blackTextColor, size: 20.sp),
    label: Text(
      label,
      style: AppStyles.styleMedium12.copyWith(
        color: color ?? AppColors.blackTextColor,
      ),
    ),
  );
}
