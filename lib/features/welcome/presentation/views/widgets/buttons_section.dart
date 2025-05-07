import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/routing/routes.dart';
import 'package:damma_project/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/widgets/app_text_button.dart';

class ButtonsSection extends StatelessWidget {
  const ButtonsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Positioned(
        top: 642.h,
        left: 15.w,
        right: 15.w,
        child: Column(
          children: [
            AppTextButton(
              buttonText: S.of(context).login,
              textStyle: AppStyles.styleMedium16,
              onPressed: () {
                Navigator.pushNamed(context, Routes.loginView);
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            AppTextButton(
              backgroundColor: AppColors.whiteColor,
              buttonText: S.of(context).createAccount,
              textStyle:
                  AppStyles.styleLight16.copyWith(fontWeight: FontWeight.w500),
              onPressed: () {
                Navigator.pushNamed(context, Routes.firstStepYourNameView);
              },
            ),
          ],
        ),
      ),
    );
  }
}
