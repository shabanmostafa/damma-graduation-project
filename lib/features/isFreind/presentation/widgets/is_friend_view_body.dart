import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/routing/routes.dart';

import 'package:damma_project/features/profile/manager/cubit/profile_cubit.dart';
import 'package:damma_project/features/profile/manager/cubit/profile_states.dart';
import 'package:damma_project/features/profile/manager/profile_posts_cubit/profile_posts_cubit.dart';
import 'package:damma_project/features/profile/manager/profile_posts_cubit/profile_posts_states.dart';
import 'package:damma_project/features/profile/presentation/views/widgets/profile_activity.dart';
import 'package:damma_project/features/profile/presentation/views/widgets/profile_header.dart';
import 'package:damma_project/features/profile/presentation/views/widgets/profile_info.dart';
import 'package:damma_project/features/profile/presentation/views/widgets/profile_posts__full_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/widgets/custom_app_bar.dart';

class IsFriendViewBody extends StatelessWidget {
  const IsFriendViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return BlocBuilder<ProfilePostsCubit, ProfilePostsState>(
          builder: (context, postsState) {
            // Handle profile loading/error states
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            } else if (state is ProfileFailure) {
              return Center(child: Text('فشل التحميل: ${(state).error}'));
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
                    ProfileHeader(
                      myProfile: false,
                      profileImageUrl: profile.profileImageUrl,
                      coverImageUrl: profile.coverImageUrl,
                    ),
                    ProfileInfo(
                      isFriend: true,
                      btnText: 'الغاء الصداقة',
                      profile,
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.friendView);
                      },
                    ),
                    const ProfileActivity(myProfile: false),
                    if (postsState is ProfilePostsSuccess)
                      ProfilePostsFullWidget(
                        posts: postsState.posts
                            .posts!,
                        profile: profile,
                      )
                    else
                      const SizedBox.shrink(),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
