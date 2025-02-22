import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/routing/routes.dart';
import 'package:damma_project/core/utils/widgets/app_text_button.dart';
import 'package:damma_project/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({
    super.key,
    required this.pages,
    required this.currentPage,
    required this.onNext,
  });

  final List pages;
  final int currentPage;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Image.asset(
            pages[currentPage]["image"],
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 68.0.h, right: 18.w, left: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('اهلا بك في ضمة', style: AppStyles.styleBold36),
              Text('تطبيق تواصل اجتماعي عربي', style: AppStyles.styleLight24),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 49.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              pages.length,
              (index) => _buildDot(index),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: 68.0.h, bottom: 45.h, right: 15.w, left: 15.w),
          child: AppTextButton(
            buttonText: S.of(context).next,
            textStyle:
                AppStyles.styleMedium16.copyWith(fontWeight: FontWeight.w500),
            onPressed: onNext,
          ),
        ),
      ],
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 8,
      width: currentPage == index ? 30 : 8,
      decoration: BoxDecoration(
        color: currentPage == index
            ? AppColors.primaryColor
            : AppColors.inActiveDotsColor,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
