import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/features/friends_profile/presentation/widgets/friends_profile_view_body.dart';
import 'package:flutter/material.dart';

class FriendsProfileView extends StatelessWidget {
  const FriendsProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: FriendsProfileViewBody(),
    );
  }
}
