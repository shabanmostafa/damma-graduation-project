import 'package:damma_project/features/register/presentation/views/widgets/fifth_step_email_view_body.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class FifthStepEmailView extends StatelessWidget {
  const FifthStepEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(child: FifthStepEmailViewBody()),
    );
  }
}
