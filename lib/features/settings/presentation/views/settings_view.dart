import 'package:damma_project/features/settings/presentation/widgets/settings_view_body.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SettingsViewBody(),
      ),
    );
  }
}
