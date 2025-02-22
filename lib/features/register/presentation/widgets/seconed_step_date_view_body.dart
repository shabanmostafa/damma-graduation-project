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
import '../views/third_step_gender_view.dart';
import 'custom_buttom_text.dart';
import 'custom_register_header.dart';

class SeconedStepDateViewBody extends StatefulWidget {
  const SeconedStepDateViewBody({super.key});

  @override
  State<SeconedStepDateViewBody> createState() =>
      _SeconedSterpDateViewBodyState();
}

class _SeconedSterpDateViewBodyState extends State<SeconedStepDateViewBody> {
  final TextEditingController _dateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _dateController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _dateController.text.isNotEmpty;
    });
  }

  String? seonedStepValidte(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).fieldIsRequired;
    }
    return null;
  }

  @override
  void dispose() {
    _dateController.dispose();
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
              pageTitle: S.of(context).whatIsYourBirthOfDate,
            ),
          ),
          SliverToBoxAdapter(child: verticalSpace(32)),
          SliverToBoxAdapter(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextFormField(
                    hintText: S.of(context).BirthOfDate,
                    prefixIcon: Assets.svgsCalendarMonth,
                    controller: _dateController,
                    validator: seonedStepValidte,
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
                          const ThirdStepGenderView(),
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
