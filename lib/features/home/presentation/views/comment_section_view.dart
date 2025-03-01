import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/features/home/presentation/widgets/comment_section.dart';
import 'package:flutter/material.dart';

class CommentSectionView extends StatelessWidget {
  const CommentSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: CommentSection(),
    );
  }
}
