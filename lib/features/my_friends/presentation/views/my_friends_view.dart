import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/features/my_friends/presentation/widgets/my_friends_view_body.dart';
import 'package:flutter/material.dart';

class MyFriendsView extends StatelessWidget {
  const MyFriendsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(child: MyFriendsViewBody()),
    );
  }
}
