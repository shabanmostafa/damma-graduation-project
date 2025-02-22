import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../widgets/sixth_step_password_view_body.dart';

class SixStepPasswordView extends StatelessWidget {
  const SixStepPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SixthStepPasswordViewBody(),
    );
  }
}
