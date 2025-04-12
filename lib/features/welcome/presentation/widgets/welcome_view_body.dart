import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/widgets/app_text_button.dart';
import 'package:damma_project/features/welcome/presentation/widgets/welcom_text_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/routing/routes.dart';
import '../../../../generated/l10n.dart';

class WelcomeViewBody extends StatelessWidget {
  const WelcomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/welcome_background.png',
            fit: BoxFit.cover,
          ),
        ),
        const WelcomeTextSection(),
        Positioned(
          bottom: 115.h,
          left: 0,
          right: 0,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0.w),
              child: AppTextButton(
                buttonText: S.of(context).login,
                textStyle: AppStyles.styleMedium16,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.loginView);
                },
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 41.h,
          left: 0,
          right: 0,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0.w),
              child: AppTextButton(
                backgroundColor: AppColors.whiteColor,
                buttonText: S.of(context).createAccount,
                textStyle: AppStyles.styleMedium16
                    .copyWith(color: AppColors.blackTextColor),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.firstStepYourNameView);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
