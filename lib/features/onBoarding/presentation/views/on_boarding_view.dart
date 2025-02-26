import 'package:damma_project/core/utils/routing/routes.dart';
import 'package:flutter/material.dart';

import '../widgets/on_boarding_view_body.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {'image': 'assets/images/onBoarding1.png'},
    {'image': 'assets/images/onBoarding2.png'},
    {'image': 'assets/images/onBoarding3.png'},
  ];

  void _goToNextPage() {
    if (_currentPage < onboardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushNamed(context, Routes.welcomeView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  return OnBoardingViewBody(
                    pages: onboardingData,
                    currentPage: index,
                    onNext: _goToNextPage,
                    pageController: pageController, // Pass controller here
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
