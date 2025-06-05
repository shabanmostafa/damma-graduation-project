import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/features/profile/data/models/profile_post_model.dart';
import 'package:damma_project/features/profile/presentation/views/widgets/profile_comment_section.dart';
import 'package:flutter/material.dart';

class ProfileCommentSectionView extends StatelessWidget {
  final List<Comments> comments;
  final Function(String) onCommentAdded;

  const ProfileCommentSectionView({
    super.key,
    required this.comments,
    required this.onCommentAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: ProfileCommentSection(
        comments: comments,
        onCommentAdded: onCommentAdded,
      ),
    );
  }
}
