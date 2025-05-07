import 'package:damma_project/features/register/presentation/views/widgets/third_step_gender_view_body.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class ThirdStepGenderView extends StatelessWidget {
  const ThirdStepGenderView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(child: ThirdStepGenderViewBody()),
    );
  }
}
