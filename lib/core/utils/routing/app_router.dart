import 'package:damma_project/features/add_post/views/add_post_view.dart';
import 'package:damma_project/features/home/presentation/views/home_view.dart';
import 'package:damma_project/features/login/presentation/views/login_view.dart';
import 'package:damma_project/features/register/presentation/views/fifth_step_email_view.dart';
import 'package:damma_project/features/register/presentation/views/first_step_your_name_view.dart';
import 'package:damma_project/features/register/presentation/views/fourth_step_phone_view.dart';
import 'package:damma_project/features/register/presentation/views/seconed_step_date_view.dart';
import 'package:damma_project/features/register/presentation/views/six_step_password_view.dart';
import 'package:damma_project/features/register/presentation/views/third_step_gender_view.dart';
import 'package:damma_project/features/welcome/presentation/views/welcome_view.dart';

import '../../../features/onBoarding/presentation/views/on_boarding_view.dart';
import 'package:flutter/material.dart';

import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoardingView:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingView(),
        );
      case Routes.loginView:
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
        );
      case Routes.welcomeView:
        return MaterialPageRoute(
          builder: (context) => const WelcomeView(),
        );
      case Routes.firstStepYourNameView:
        return MaterialPageRoute(
          builder: (context) => const FirstStepYourNameView(),
        );
      case Routes.seconedStepDateView:
        return MaterialPageRoute(
          builder: (context) => const SeconedStepDateView(),
        );
      case Routes.thirdStepGenderView:
        return MaterialPageRoute(
          builder: (context) => const ThirdStepGenderView(),
        );
      case Routes.fourthStepPhoneView:
        return MaterialPageRoute(
          builder: (context) => const FourthStepPhoneView(),
        );
      case Routes.fifthStepEmailView:
        return MaterialPageRoute(
          builder: (context) => const FifthStepEmailView(),
        );
      case Routes.sixStepPasswordView:
        return MaterialPageRoute(
          builder: (context) => const SixStepPasswordView(),
        );
      case Routes.homeView:
        return MaterialPageRoute(
          builder: (context) => const HomeView(),
        );
      case Routes.addPostView:
        return MaterialPageRoute(
          builder: (context) => const AddPostView(),
        );

      default:
        return null;
      // MaterialPageRoute(
      //   builder: (context) => Scaffold(
      //     body: Center(
      //       child: Text(
      //         "No route defined for ${settings.name}",
      //       ),
      //     ),
      //   ),
      // );
    }
  }
}
