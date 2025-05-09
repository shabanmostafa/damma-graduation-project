import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

import '../widgets/seconed_step_date_view_body.dart';

class SeconedStepDateView extends StatelessWidget {
  const SeconedStepDateView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(child: SeconedStepDateViewBody()),
    );
  }
}
