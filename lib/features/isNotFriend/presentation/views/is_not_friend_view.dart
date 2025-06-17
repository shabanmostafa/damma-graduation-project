import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/di/service_locator.dart';
import 'package:damma_project/features/isNotFriend/data/repo/friend_repo.dart';
import 'package:damma_project/features/isNotFriend/data/repo/friend_repo_impl.dart';
import 'package:damma_project/features/isNotFriend/manager/friend_cubit.dart';
import 'package:damma_project/features/isNotFriend/presentation/widgets/is_not_friend_view_body.dart';
import 'package:damma_project/features/profile/data/repo/profile_repo_imp.dart';
import 'package:damma_project/features/profile/manager/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../profile/manager/profile_posts_cubit/profile_posts_cubit.dart';

class IsNotFriendView extends StatelessWidget {
  final int userId;

  const IsNotFriendView({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProfileCubit(getIt<ProfileRepoImpl>())..getProfile(userId),
        ),
        BlocProvider(
          create: (context) => ProfilePostsCubit(getIt<ProfileRepoImpl>())..getProfilePosts(userId),
        ),
        BlocProvider(
          create: (context) => FriendCubit(getIt<FriendRepoImpl>()),
        ),
      ],
      child: const Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(child: IsNotFriendViewBody()),
      ),
    );
  }
}
