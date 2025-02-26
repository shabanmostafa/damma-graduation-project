import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/widgets/app_text_button.dart';
import 'package:damma_project/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({
    super.key,
    required this.pages,
    required this.currentPage,
    required this.onNext,
    required this.pageController,
  });

  final List pages;
  final int currentPage;
  final VoidCallback onNext;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.55,
            child: Image.asset(
              pages[currentPage]["image"],
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25.h, right: 18.w, left: 18.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).welcomInDamma, style: AppStyles.styleBold36),
                Text(S.of(context).socialMediaApp,
                    style: AppStyles.styleLight24),
              ],
            ),
          ),
          // SmoothPageIndicator before the button
          Padding(
            padding: EdgeInsets.only(top: 40.h),
            child: Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: pages.length,
                effect: const ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor:
                      AppColors.primaryColor, // Change to match your theme
                  dotColor: Colors.grey,
                ),
              ),
            ),
          ),
          const Spacer(), // Pushes the button to the bottom
          Padding(
            padding: EdgeInsets.only(bottom: 31.h, left: 15.w, right: 15.w),
            child: AppTextButton(
              buttonText: S.of(context).next,
              textStyle:
                  AppStyles.styleMedium16.copyWith(fontWeight: FontWeight.w500),
              onPressed: onNext,
            ),
          ),
        ],
      ),
    );
  }
}
