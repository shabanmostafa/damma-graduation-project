import 'package:damma_project/features/profile/data/models/profile_post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/spacing.dart';

class ProfileCommentSection extends StatefulWidget {
  final List<Comments> comments;
  final Function(String) onCommentAdded;

  const ProfileCommentSection({
    super.key,
    required this.comments,
    required this.onCommentAdded,
  });

  @override
  State<ProfileCommentSection> createState() => _ProfileCommentSectionState();
}

class _ProfileCommentSectionState extends State<ProfileCommentSection> {
  final TextEditingController _commentController = TextEditingController();

  void submitComment() {
    String commentText = _commentController.text.trim();
    if (commentText.isNotEmpty) {
      widget.onCommentAdded(commentText);
      _commentController.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          verticalSpace(10),
          Text(
            'التعليقات',
            style: AppStyles.styleBold16,
          ),
          verticalSpace(10),
          Expanded(
            child: ListView.builder(
              itemCount: widget.comments.length,
              itemBuilder: (context, index) {
                final comment = widget.comments[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: comment.profileImageUrl != null
                        ? NetworkImage(
                            getFullProfileImageUrl(comment.profileImageUrl!)!)
                        : const AssetImage('assets/images/default_avatar.png')
                            as ImageProvider,
                  ),
                  title: Text(
                    '${comment.firstName ?? ''} ${comment.lastName ?? ''}',
                    style: AppStyles.styleMedium12,
                  ),
                  subtitle: Text(
                    comment.content ?? '',
                    style: AppStyles.styleMedium12,
                  ),
                );
              },
            ),
          ),
          TextField(
            controller: _commentController,
            decoration: InputDecoration(
              hintText: 'اكتب تعليق...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            ),
            onSubmitted: (value) => submitComment(),
          ),
          verticalSpace(10),
        ],
      ),
    );
  }

  String? getFullProfileImageUrl(String? path) {
    if (path == null || path.isEmpty || path.endsWith('/')) return null;
    if (path.startsWith('http')) return path;
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return 'http://dama.runasp.net$normalizedPath';
  }
}
