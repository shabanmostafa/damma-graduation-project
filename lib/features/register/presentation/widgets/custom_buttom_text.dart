import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/features/login/presentation/views/login_view.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_styles.dart';
import '../../../../generated/l10n.dart';

class CustomBottomText extends StatelessWidget {
  const CustomBottomText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
                (route) => false,
              );
            },
            child: Text(
              S.of(context).login,
              style: AppStyles.styleBold16.copyWith(
                fontWeight: FontWeight.normal,
                color: AppColors.blackTextColor,
              ),
            ),
          )),
    );
  }
}
