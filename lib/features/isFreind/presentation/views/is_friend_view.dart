import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/di/service_locator.dart';
import 'package:damma_project/features/isFreind/presentation/widgets/is_friend_view_body.dart';
import 'package:damma_project/features/profile/data/repo/profile_repo_imp.dart';
import 'package:damma_project/features/profile/manager/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IsFriendView extends StatelessWidget {
  final int userId;

  const IsFriendView({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileCubit(getIt<ProfileRepoImpl>())..getProfile(userId),
      child: const Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(child: IsFriendViewBody()),
      ),
    );
  }
}
