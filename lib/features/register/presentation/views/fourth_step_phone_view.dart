import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

import '../widgets/fourth_step_phone_view_body.dart';

class FourthStepPhoneView extends StatelessWidget {
  const FourthStepPhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(child: FourthStepPhoneViewBody()),
    );
  }
}
