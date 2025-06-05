import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/features/profile/manager/cubit/profile_cubit.dart';
import 'package:damma_project/features/profile/manager/cubit/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/routing/routes.dart';
import '../../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../home/presentation/views/home_view.dart';
import 'profile_header.dart';
import 'profile_info.dart';
import 'profile_activity.dart';

class ProfileViewBody extends StatelessWidget {
  final int userId;

  const ProfileViewBody({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    // Remove calling getProfile() here because it was called in ProfileView

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        } else if (state is ProfileFailure) {
          return Center(child: Text('فشل التحميل: ${state.error}'));
        } else if (state is ProfileSuccess) {
          final profile = state.profile;
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomAppBar(
                    needArrow: true,
                    text: "الصفحة الشخصية",
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeView(userId: userId),
                        ),
                      );
                    },
                  ),
                ),
                ProfileHeader(
                  myProfile: true,
                  profileImageUrl: profile.profileImageUrl,
                  coverImageUrl: profile.coverImageUrl,
                ),
                ProfileInfo(
                  profile,
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.upateProfileView,
                        arguments: userId);
                  },
                  btnText: 'تعديل',
                  isFriend: false,
                ),
                const ProfileActivity(
                  myProfile: true,
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
