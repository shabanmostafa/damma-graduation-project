import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/di/service_locator.dart';
import 'package:damma_project/features/profile/data/repo/profile_repo_imp.dart';
import 'package:damma_project/features/settings/presentation/widgets/update_profile_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:damma_project/features/profile/manager/cubit/profile_cubit.dart';

class UpdateProfileView extends StatelessWidget {
  final int userId;

  const UpdateProfileView({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(getIt<ProfileRepoImpl>())..getProfile(userId),
      child: const SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: UpdateProfileViewBody(),
        ),
      ),
    );
  }
}
