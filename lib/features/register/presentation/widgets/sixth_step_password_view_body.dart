import 'package:damma_project/core/utils/assets.dart';
import 'package:damma_project/core/utils/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/utils/widgets/app_text_button.dart';
import '../../../../core/utils/widgets/app_text_form_field.dart';
import '../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../generated/l10n.dart';
import 'custom_buttom_text.dart';
import 'custom_register_header.dart';

class SixthStepPasswordViewBody extends StatefulWidget {
  const SixthStepPasswordViewBody({super.key});

  @override
  State<SixthStepPasswordViewBody> createState() =>
      _SixthStepPasswordViewState();
}

class _SixthStepPasswordViewState extends State<SixthStepPasswordViewBody> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmationPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_updateButtonState);
    _confirmationPasswordController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _passwordController.text.isNotEmpty &&
          _confirmationPasswordController.text.isNotEmpty;
    });
  }

// Password Validator
  String? passwordValidate(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).fieldIsRequired;
    }
    String passwordPattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
    RegExp regExp = RegExp(passwordPattern);
    if (!regExp.hasMatch(value)) {
      return S.of(context).passwordValidation;
    }
    return null;
  }

  // Confirm Password Validator
  String? confirmPasswordValidate(String? value, String password) {
    if (value == null || value.isEmpty) {
      return S.of(context).PasswordConfirmatiomFieldRequired;
    }
    if (value != password) {
      return S.of(context).passwordNotTheSame;
    }
    return null;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmationPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: verticalSpace(60)),
          SliverToBoxAdapter(
            child: CustomAppBar(
              text: S.of(context).createAccount,
            ),
          ),
          SliverToBoxAdapter(child: verticalSpace(41)),
          SliverToBoxAdapter(
            child: CustomRegisterHeader(
              pageTitle: S.of(context).createPassword,
            ),
          ),
          SliverToBoxAdapter(child: verticalSpace(32)),
          SliverToBoxAdapter(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextFormField(
                    hintText: S.of(context).createPassword,
                    prefixIcon: Assets.svgsLock,
                    controller: _passwordController,
                    isPassword: true,
                    validator: passwordValidate,
                  ),
                  verticalSpace(25),
                  AppTextFormField(
                    hintText: S.of(context).passwordConfirmation,
                    isPassword: true,
                    prefixIcon: Assets.svgsLock,
                    controller: _confirmationPasswordController,
                    validator: (value) => confirmPasswordValidate(
                        value, _passwordController.text),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: verticalSpace(65)),
          SliverToBoxAdapter(
            child: AppTextButton(
              buttonText: S.of(context).next,
              textStyle: AppStyles.styleMedium18,
              backgroundColor: _isButtonEnabled
                  ? AppColors.primaryColor
                  : AppColors.inactiveButtonColor,
              onPressed: _isButtonEnabled
                  ? () {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.pushNamed(context, Routes.homeView);
                      }
                    }
                  : () {},
            ),
          ),
          const SliverFillRemaining(
              hasScrollBody: false, child: CustomBottomText()),
        ],
      ),
    );
  }
}
