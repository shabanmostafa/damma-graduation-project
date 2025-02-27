import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../widgets/first_sterp_your_name_view_body.dart';

class FirstStepYourNameView extends StatelessWidget {
  const FirstStepYourNameView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(child: FirstSterpYourNameViewBody()),
    );
  }
}
