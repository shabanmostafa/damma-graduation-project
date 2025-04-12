import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/features/home/presentation/widgets/comment_section.dart';
import 'package:flutter/material.dart';

class CommentSectionView extends StatelessWidget {
  final List<String> comments;
  final Function(String) onCommentAdded;

  const CommentSectionView({
    super.key,
    required this.comments,
    required this.onCommentAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: CommentSection(
        comments: comments,
        onCommentAdded: onCommentAdded,
      ),
    );
  }
}
