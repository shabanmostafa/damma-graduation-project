import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/utils/widgets/animated_navigation.dart';
import '../../../../core/utils/widgets/app_text_button.dart';
import '../../../../core/utils/widgets/app_text_form_field.dart';
import '../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../generated/l10n.dart';
import '../views/six_step_password_view.dart';
import 'custom_buttom_text.dart';
import 'custom_register_header.dart';

class FifthStepEmailViewBody extends StatefulWidget {
  const FifthStepEmailViewBody({super.key});

  @override
  State<FifthStepEmailViewBody> createState() => _FifthStepEmailViewBodyState();
}

class _FifthStepEmailViewBodyState extends State<FifthStepEmailViewBody> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _emailController.text.isNotEmpty;
    });
  }

  String? fifthStepValidte(String? value) {
    // Check if the value is null or empty
    if (value == null || value.isEmpty) {
      return S.of(context).fieldIsRequired;
    }

    // Regular expression for basic email validation
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(emailPattern);

    // Check if the value matches the email pattern
    if (!regExp.hasMatch(value)) {
      return S.of(context).pleaseEnterCorrectEmail;
    }

    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
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
              pageTitle: S.of(context).whatIsYourEmail,
            ),
          ),
          SliverToBoxAdapter(child: verticalSpace(32)),
          SliverToBoxAdapter(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextFormField(
                    hintText: S.of(context).email,
                    prefixIcon: Assets.svgsMail,
                    controller: _emailController,
                    validator: fifthStepValidte,
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
                        AnimatedNavigation.navigateWithSlide(
                          context,
                          const SixStepPasswordView(),
                        );
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
