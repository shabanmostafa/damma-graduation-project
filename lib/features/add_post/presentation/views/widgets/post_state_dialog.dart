import 'package:damma_project/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/assets.dart';
import 'package:damma_project/core/utils/widgets/app_text_button.dart';

class PostStateDialog {
  static void showBottomPopup(BuildContext context, bool isSuccess) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                isSuccess ? Assets.svgsAccept : Assets.svgsReject,
                width: 106.w,
                height: 106.h,
              ),
              SizedBox(height: 18.h),
              Text(
                isSuccess
                    ? S.of(context).postAccepted
                    : S.of(context).postRejected,
                style: AppStyles.styleBold16,
              ),
              SizedBox(height: 8.h),
              Text(
                isSuccess
                    ? S.of(context).postSended
                    : S.of(context).postUnsended,
                style: AppStyles.styleLight16,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 44.h),
              Row(
                mainAxisAlignment: isSuccess
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceEvenly,
                children: [
                  if (!isSuccess)
                    AppTextButton(
                      backgroundColor: AppColors.redDarkColor,
                      borderRadius: 13.r,
                      buttonWidth: MediaQuery.of(context).size.width * 0.4,
                      buttonHeight: 55.h,
                      buttonText: S.of(context).retry,
                      textStyle: AppStyles.styleMedium14
                          .copyWith(color: AppColors.whiteColor),
                      onPressed: () => Navigator.pop(context),
                    ),
                  !isSuccess
                      ? SizedBox(
                          width: 17.w,
                        )
                      : const SizedBox(),
                  if (isSuccess)
                    Expanded(
                      child: AppTextButton(
                        buttonHeight: 55.h,
                        backgroundColor: AppColors.primaryColor,
                        borderRadius: 13.r,
                        buttonText: S.of(context).backToHome,
                        textStyle: AppStyles.styleMedium14
                            .copyWith(color: AppColors.whiteColor),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                    )
                  else
                    AppTextButton(
                      buttonWidth: MediaQuery.of(context).size.width * 0.4,
                      buttonHeight: 55.h,
                      backgroundColor: AppColors.exitButton,
                      borderRadius: 13.r,
                      buttonText: S.of(context).exit,
                      textStyle: AppStyles.styleMedium14
                          .copyWith(color: AppColors.hintTextColor),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
