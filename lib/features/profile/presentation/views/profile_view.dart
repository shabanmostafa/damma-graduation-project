// profile_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/di/service_locator.dart';
import 'package:damma_project/features/profile/data/repo/profile_repo_imp.dart';
import 'package:damma_project/features/profile/manager/cubit/profile_cubit.dart';
import 'package:damma_project/features/profile/manager/profile_posts_cubit/profile_posts_cubit.dart';
import 'package:damma_project/features/profile/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  final int userId;

  const ProfileView({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              ProfileCubit(getIt<ProfileRepoImpl>())..getProfile(userId),
        ),
        BlocProvider(
          create: (_) => ProfilePostsCubit(getIt<ProfileRepoImpl>())
            ..getProfilePosts(userId),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(child: ProfileViewBody(userId: userId)),
      ),
    );
  }
}
