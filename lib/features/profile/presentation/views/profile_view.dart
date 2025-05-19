import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/di/service_locator.dart';
import 'package:damma_project/features/profile/data/repo/profile_repo_imp.dart';
import 'package:damma_project/features/profile/manager/cubit/profile_cubit.dart';
import 'package:damma_project/features/profile/presentation/views/widgets/profile_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(getIt<ProfileRepoImpl>())..getProfile(),
      child: const SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: ProfileViewBody(),
        ),
      ),
    );
  }
}
