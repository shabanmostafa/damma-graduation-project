import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/assets.dart';
import 'package:damma_project/core/utils/widgets/app_text_button.dart';
import 'package:damma_project/features/add_post/presentation/widgets/post_state_dialog.dart';
import 'package:damma_project/features/add_post/presentation/widgets/post_validator.dart';
import 'package:damma_project/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeftPartOfRow extends StatelessWidget {
  LeftPartOfRow(
      {super.key, required this.isButtonActive, required this.postContent});

  final bool isButtonActive;
  final String postContent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 11.0.w),
          child: SvgPicture.asset(
            Assets.svgClock,
            width: 25.w,
            height: 25.h,
          ),
        ),
        AppTextButton(
          backgroundColor: isButtonActive
              ? AppColors.primaryColor
              : AppColors.inactiveButtonColor,
          borderRadius: 20.r,
          buttonWidth: 66.w,
          buttonHeight: 40.h,
          buttonText: S.of(context).post,
          textStyle:
              AppStyles.styleMedium14.copyWith(color: AppColors.whiteColor),
          onPressed: isButtonActive
              ? () {
                  bool isPostAccepted = PostValidator.validate(postContent);
                  PostStateDialog.showBottomPopup(context, isPostAccepted);
                }
              : () {}, // الزر غير مفعل إذا كان المحتوى فارغًا
        ),
      ],
    );
  }
}
