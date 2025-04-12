import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/features/add_post/presentation/widgets/add_post_view_body.dart';
import 'package:flutter/material.dart';

class AddPostView extends StatelessWidget {
  const AddPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(child: AddPostViewBody()),
    );
  }
}
