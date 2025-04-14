import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/functions/list_tile_type.dart';
import 'package:damma_project/core/utils/widgets/app_text_button.dart';
import 'package:damma_project/features/search/data/models/user_model.dart';
import 'package:damma_project/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableListTile extends StatelessWidget {
  final UserModel user;
  final UserItemType type;

  const ReusableListTile({
    super.key,
    required this.user,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    Widget? trailingButton;

    switch (type) {
      case UserItemType.friendRequest:
        trailingButton = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextButton(
              backgroundColor: AppColors.primaryColor,
              borderRadius: 10.r,
              buttonWidth: 66.w,
              buttonHeight: 40.h,
              buttonText: S.of(context).Accept,
              textStyle:
                  AppStyles.styleMedium14.copyWith(color: AppColors.whiteColor),
              onPressed: () {},
            ),
            SizedBox(width: 8.w),
            AppTextButton(
              backgroundColor: AppColors.inactiveButtonColor,
              borderRadius: 10.r,
              buttonWidth: 66.w,
              buttonHeight: 40.h,
              buttonText: S.of(context).Reject,
              textStyle: AppStyles.styleMedium14
                  .copyWith(color: AppColors.hintTextColor),
              onPressed: () {},
            ),
          ],
        );
        break;
      case UserItemType.suggestion:
        trailingButton = AppTextButton(
          backgroundColor: AppColors.primaryColor,
          borderRadius: 10.r,
          buttonWidth: 110.w,
          buttonHeight: 40.h,
          buttonText: S.of(context).AddFriend,
          textStyle:
              AppStyles.styleMedium14.copyWith(color: AppColors.whiteColor),
          onPressed: () {},
        );
        break;
      case UserItemType.search:
        trailingButton = null;
        break;
    }

    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: AssetImage(user.imageUrl),
      ),
      title: Text(user.name,
          style: AppStyles.styleMedium16
              .copyWith(color: AppColors.blackTextColor)),
      subtitle: Text(user.jobTitle,
          style: AppStyles.styleMedium12
              .copyWith(color: AppColors.blackTextColor)),
      trailing: trailingButton,
    );
  }
}
