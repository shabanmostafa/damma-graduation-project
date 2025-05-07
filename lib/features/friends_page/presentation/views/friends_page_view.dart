import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/features/friends_page/presentation/views/widgets/friends_page_view_body.dart';
import 'package:flutter/material.dart';

class FriendsPageView extends StatelessWidget {
  const FriendsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.screenBackgroundColor,
      body: SafeArea(child: FriendsPageViewBody()),
    );
  }
}
