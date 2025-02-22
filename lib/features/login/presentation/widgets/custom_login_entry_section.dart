import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/utils/widgets/app_text_button.dart';
import '../../../../core/utils/widgets/app_text_form_field.dart';
import '../../../../generated/l10n.dart';

class CustomLoginEntrySection extends StatelessWidget {
  const CustomLoginEntrySection({
    super.key,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required bool isButtonEnabled,
  })  : _emailController = emailController,
        _passwordController = passwordController,
        _isButtonEnabled = isButtonEnabled;

  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final bool _isButtonEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50.h,
          width: double.infinity,
          child: AppTextFormField(
            controller: _emailController,
            hintText: S.of(context).email,
            prefixIcon: Assets.svgsMail,
          ),
        ),
        verticalSpace(24),
        SizedBox(
          height: 50.h,
          width: double.infinity,
          child: AppTextFormField(
            controller: _passwordController,
            hintText: S.of(context).password,
            prefixIcon: Assets.svgsLock,
            isPassword: true,
            suffixIcon: Assets.svgsEye,
          ),
        ),
        verticalSpace(30),
        AppTextButton(
          buttonText: S.of(context).login,
          textStyle: AppStyles.styleMedium16,
          backgroundColor: _isButtonEnabled
              ? AppColors.primaryColor // Blue color when enabled
              : AppColors.inactiveButtonColor, // Grey color when disabled
          onPressed: _isButtonEnabled
              ? () {
                  // Add your login logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(S.of(context).loginLoading)),
                  );
                }
              : () {}, // Disable button when not enabled
        ),
        verticalSpace(30),
        Text(
          S.of(context).forgetPasswoerd,
          style: AppStyles.styleLight16,
        ),
      ],
    );
  }
}
