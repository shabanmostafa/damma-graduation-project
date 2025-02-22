import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/utils/widgets/animated_navigation.dart';
import '../../../../core/utils/widgets/app_text_button.dart';
import '../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../generated/l10n.dart';
import '../views/fourth_step_phone_view.dart';
import 'custom_buttom_text.dart';
import 'custom_register_header.dart';

class ThirdStepGenderViewBody extends StatefulWidget {
  const ThirdStepGenderViewBody({super.key});

  @override
  State<ThirdStepGenderViewBody> createState() =>
      _ThirdStepGenderViewBodyState();
}

class _ThirdStepGenderViewBodyState extends State<ThirdStepGenderViewBody> {
  String? selectedGender;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0..w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(60),
          CustomAppBar(
            text: S.of(context).createAccount,
          ),
          verticalSpace(41),
          CustomRegisterHeader(
            pageTitle: S.of(context).whatIsYourType,
          ),
          verticalSpace(32),
          GenderOption(
            title: S.of(context).male,
            isSelected: selectedGender == S.of(context).male,
            onTap: () {
              setState(() {
                selectedGender = S.of(context).male; // Update selection
              });
            },
          ),
          verticalSpace(24),
          GenderOption(
            title: S.of(context).female,
            isSelected: selectedGender == S.of(context).female,
            onTap: () {
              setState(() {
                selectedGender = S.of(context).female; // Update selection
              });
            },
          ),
          verticalSpace(35),
          AppTextButton(
              buttonText: S.of(context).next,
              textStyle: AppStyles.styleMedium18,
              backgroundColor: selectedGender != null
                  ? AppColors.primaryColor
                  : AppColors
                      .inactiveButtonColor, // Button color based on selection
              onPressed: selectedGender != null
                  ? () {
                      //print('Selected Gender: $selectedGender');
                      //! Navigate or perform next step action
                      AnimatedNavigation.navigateWithSlide(
                          context, const FourthStepPhoneView());
                    }
                  : () {}), // Disable button if no gender selected
          const Spacer(),
          const CustomBottomText(),
        ],
      ),
    );
  }
}

class GenderOption extends StatelessWidget {
  const GenderOption({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withOpacity(0.2)
              : AppColors.textFieldfillColor,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: isSelected
                ? AppColors.textFieldfillColor
                : AppColors.textFieldfillColor,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected
                    ? AppColors.blackTextColor
                    : AppColors.hintTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color:
                  isSelected ? AppColors.primaryColor : const Color(0xffBFBFBF),
            ),
          ],
        ),
      ),
    );
  }
}
