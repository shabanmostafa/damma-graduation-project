import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/features/isFreind/presentation/widgets/is_friend_profile_activity.dart';
import 'package:damma_project/features/isFreind/presentation/widgets/is_friend_profile_header.dart';
import 'package:damma_project/features/isFreind/presentation/widgets/is_friend_profile_info.dart';
import 'package:damma_project/features/isNotFriend/presentation/widgets/is_not_friend_profile_activity.dart';
import 'package:damma_project/features/isNotFriend/presentation/widgets/is_not_friend_profile_info.dart';
import 'package:damma_project/features/profile/manager/cubit/profile_cubit.dart';
import 'package:damma_project/features/profile/manager/cubit/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/widgets/custom_app_bar.dart';

class IsNotFriendViewBody extends StatelessWidget {
  const IsNotFriendViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
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
                      text:
                          '${profile.firstName ?? ''} ${profile.lastName ?? ''}'),
                ),
                IsFriendProfileHeader(
                  profileImageUrl: profile.profileImageUrl,
                  coverImageUrl: profile.coverImageUrl,
                ),
                IsNotFriendProfileInfo(profile),
                const IsNotFriendProfileActivity(),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
