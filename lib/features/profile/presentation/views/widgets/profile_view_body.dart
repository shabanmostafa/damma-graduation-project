import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/features/profile/manager/cubit/profile_cubit.dart';
import 'package:damma_project/features/profile/manager/cubit/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/widgets/custom_app_bar.dart';
import 'profile_header.dart';
import 'profile_info.dart';
import 'profile_activity.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileCubit>().getProfile();

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ));
        } else if (state is ProfileFailure) {
          return Center(child: Text('فشل التحميل: ${state.error}'));
        } else if (state is ProfileSuccess) {
          final profile = state.profile;
          return SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomAppBar(needArrow: true, text: "الصفحة الشخصية"),
                ),
                ProfileHeader(
                  profileImageUrl: profile.profileImageUrl,
                  coverImageUrl: profile.coverImageUrl,
                ),

                ProfileInfo(profile),
                const ProfileActivity(),
                //const ProfilePosts(),
              ],
            ),
          );
        }
        return const SizedBox.shrink(); // Initial state
      },
    );
  }
}
