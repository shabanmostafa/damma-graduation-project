import 'package:damma_project/features/profile/data/repo/profile_repo_imp.dart';
import 'package:damma_project/features/settings/presentation/widgets/settings_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/di/service_locator.dart';
import '../../../profile/manager/cubit/profile_cubit.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.userId});
    final int userId;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(getIt<ProfileRepoImpl>())..getProfile(userId),
      child: const SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: SettingsViewBody(),
        ),
      ),
    );
  }
}
