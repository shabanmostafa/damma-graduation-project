import 'package:damma_project/core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets.dart';

class PostActions extends StatelessWidget {
  final VoidCallback onLikePressed;
  final bool isLiked;
  final VoidCallback onCommentPressed;

  const PostActions({
    super.key,
    required this.onLikePressed,
    required this.isLiked,
    required this.onCommentPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: onLikePressed,
            child: Row(
              children: [
                Text(
                  isLiked ? 'إلغاء الإعجاب' : 'أعجبني',
                  style: AppStyles.styleMedium12
                      .copyWith(color: AppColors.blackTextColor),
                ),
                horizontalSpace(5),
                SvgPicture.asset(
                  isLiked ? Assets.svgsLike : Assets.svgsLikeOutlined,
                  width: 22.w,
                  height: 22.h,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onCommentPressed,
            child: const ActionButton(
              asset: Assets.svgsCommen,
              label: 'تعليق',
            ),
          ),
          const ActionButton(asset: Assets.svgsShare, label: 'مشاركة'),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String asset;
  final String label;

  const ActionButton({
    super.key,
    required this.asset,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style:
              AppStyles.styleMedium12.copyWith(color: AppColors.blackTextColor),
        ),
        horizontalSpace(5),
        SvgPicture.asset(asset, width: 20.w, height: 20.h),
      ],
    );
  }
}
