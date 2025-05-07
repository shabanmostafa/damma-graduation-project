import 'package:damma_project/features/register/presentation/views/widgets/seconed_step_date_view_body.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

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
