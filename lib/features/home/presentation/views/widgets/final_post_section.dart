import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/models/user_model.dart';
import 'package:damma_project/core/utils/spacing.dart';
import 'package:damma_project/core/utils/widgets/full_screen_image_view.dart';
import 'package:damma_project/features/home/data/models/news_feed_model/comment.dart';
import 'package:damma_project/features/home/data/models/news_feed_model/news_feed_model.dart';
import 'package:damma_project/features/home/manager/news_feed_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinalPostSection extends StatefulWidget {
  final NewsFeedModel newsFeedModel;
  final UserModel? userModel;

  final Function()? onPostUpdated;

  const FinalPostSection(
      {super.key,
      required this.newsFeedModel,
      this.onPostUpdated,
      this.userModel});

  @override
  State<FinalPostSection> createState() => _FinalPostSectionState();
}

class _FinalPostSectionState extends State<FinalPostSection> {
  late int likeCount;
  late int commentCount;
  bool isLiked = false;
  late List<Comment> comment;
  final TextEditingController _commentController = TextEditingController();
  final GlobalKey<AnimatedListState> _animatedListKey =
      GlobalKey<AnimatedListState>();

  bool _isSubmittingComment = false;

  @override
  void initState() {
    super.initState();
    likeCount = widget.newsFeedModel.totalReactions ?? 0;
    commentCount = widget.newsFeedModel.totalComments ?? 0;
    comment = widget.newsFeedModel.comments ?? [];
    isLiked = _checkIfLiked();
  }

  bool _checkIfLiked() {
    // Implement your reaction checking logic here
    // Example:
    // return widget.newsFeedModel.reactions?.any((r) => r.userId == currentUserId) ?? false;
    return false;
  }

  void toggleLike() {
    final newsFeedCubit = context.read<NewsFeedCubit>();

    setState(() {
      if (isLiked) {
        likeCount -= 1;
        newsFeedCubit.removeReaction(widget.newsFeedModel.postId!);
      } else {
        likeCount += 1;
        newsFeedCubit.addReaction(widget.newsFeedModel.postId!, 'like');
      }
      isLiked = !isLiked;
    });

    if (widget.onPostUpdated != null) {
      widget.onPostUpdated!();
    }
  }

  void openCommentSection() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                width: 40.w,
                height: 5.h,
                margin: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'التعليقات',
                  style: AppStyles.styleBold16,
                ),
              ),
              Expanded(
                child: AnimatedList(
                  key: _animatedListKey,
                  controller: scrollController,
                  initialItemCount: comment.length,
                  itemBuilder: (context, index, animation) {
                    final comments = comment[index];
                    return SizeTransition(
                      sizeFactor: animation,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: comments.profileImageUrl != null
                              ? NetworkImage(getFullProfileImageUrl(
                                  comments.profileImageUrl!))
                              : const AssetImage(
                                      'assets/images/default_avatar.png')
                                  as ImageProvider,
                        ),
                        title: Text(
                          '${comments.firstName ?? ''} ${comments.lastName ?? ''}',
                          style: AppStyles.styleMedium12,
                        ),
                        subtitle: Text(
                          comments.content ?? '',
                          style: AppStyles.styleMedium12,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundImage: _getCommenterProfileImage(),
                    ),
                    horizontalSpace(8),
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          hintText: 'اكتب تعليق...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            borderSide: const BorderSide(
                              color: Colors.grey, // اللون لما مش مركز عليه
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            borderSide: const BorderSide(
                              color: AppColors
                                  .primaryColor, // اللون لما مركز عليه (typing)
                              width: 2,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 10.h),
                          suffixIcon: IconButton(
                            icon: _isSubmittingComment
                                ? const CircularProgressIndicator(
                                    color: AppColors.primaryColor,
                                  )
                                : const Icon(
                                    Icons.send,
                                    color: AppColors.primaryColor,
                                  ),
                            onPressed: _isSubmittingComment
                                ? null
                                : () => submitComment(),
                          ),
                        ),
                        onSubmitted: (_) => submitComment(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).then((_) {
      if (widget.onPostUpdated != null) {
        widget.onPostUpdated!();
      }
    });
  }

  Future<void> submitComment() async {
    final commentText = _commentController.text.trim();
    if (commentText.isEmpty) return;

    setState(() => _isSubmittingComment = true);

    final newsFeedCubit = context.read<NewsFeedCubit>();
    final success = await newsFeedCubit.addComment(
        widget.newsFeedModel.postId!, commentText);

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add comment')),
      );
      setState(() => _isSubmittingComment = false);
      return;
    }

    // Success - update both local state and model
    setState(() {
      commentCount++; // Increment local counter
      widget.newsFeedModel.totalComments = commentCount; // Update model

      // Add new comment to beginning of list
      comment.insert(
          0,
          Comment(
            content: commentText,
            userId: widget.userModel?.id, // تأكد إنه مش null
            firstName: widget.userModel?.firstName,
            lastName: widget.userModel?.lastName,
            profileImageUrl: widget.userModel?.profileImageUrl,
          ));

      _commentController.clear();
      _isSubmittingComment = false;
    });

    // Notify parent widget if needed
    if (widget.onPostUpdated != null) {
      widget.onPostUpdated!();
    }
  }

  ImageProvider _getCommenterProfileImage() {
    try {
      // First try to get from userModel if it exists
      final userImageUrl = widget.userModel?.profileImageUrl;
      if (userImageUrl != null && userImageUrl.isNotEmpty) {
        return NetworkImage(getFullProfileImageUrl(userImageUrl));
      }

      // Then fall back to newsFeedModel's profile image
      final feedImageUrl = widget.newsFeedModel.profileImageUrl;
      if (feedImageUrl != null && feedImageUrl.isNotEmpty) {
        return NetworkImage(getFullProfileImageUrl(feedImageUrl));
      }
    } catch (e) {
      debugPrint('Error loading profile image: $e');
    }

    // Default fallback
    return const AssetImage('assets/images/default_avatar.png');
  }

  String getFullProfileImageUrl(String path) {
    if (path.startsWith('http')) return path;
    if (path.startsWith('/')) return 'http://dama.runasp.net$path';
    return 'http://dama.runasp.net/$path';
  }

  String? getFullImageUrl(String? path) {
    if (path == null || path.isEmpty || path.endsWith('/')) return null;
    if (path.startsWith('http')) return path;
    return 'http://dama.runasp.net${path.startsWith('/') ? '' : '/'}$path';
  }

  @override
  Widget build(BuildContext context) {
    final profileImage = getFullImageUrl(widget.newsFeedModel.profileImageUrl);
    final postImage = getFullImageUrl(widget.newsFeedModel.mediaUrl);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildUserHeader(profileImage),
          if (widget.newsFeedModel.postTitle?.isNotEmpty ?? false)
            buildPostTitle(widget.newsFeedModel.postTitle!),
          if (widget.newsFeedModel.postBody?.isNotEmpty ?? false)
            buildPostBody(widget.newsFeedModel.postBody!),
          verticalSpace(8),
          if (postImage != null && postImage.isNotEmpty)
            buildPostImage(postImage),
          verticalSpace(12),
          buildPostStats(),
          buildPostActions(),
          const Divider(
            color: AppColors.primaryColor,
          )
        ],
      ),
    );
  }

  Widget buildUserHeader(String? profileImageUrl) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (profileImageUrl != null) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => FullScreenImageView(
                  imageUrl: profileImageUrl,
                ),
              ));
            }
          },
          child: CircleAvatar(
            radius: 25.r,
            backgroundColor: AppColors.primaryColor.withOpacity(0.1),
            child: profileImageUrl != null
                ? ClipOval(
                    child: Image.network(
                      profileImageUrl,
                      width: 50.w,
                      height: 50.h,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => buildDefaultAvatar(),
                      loadingBuilder: (_, child, loadingProgress) =>
                          loadingProgress == null
                              ? child
                              : const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1.5,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                    ),
                  )
                : buildDefaultAvatar(),
          ),
        ),
        horizontalSpace(15),
        Expanded(
          child: Text(
            '${widget.newsFeedModel.firstName} ${widget.newsFeedModel.lastName}',
            style: AppStyles.styleBold16,
          ),
        ),
      ],
    );
  }

  Widget buildDefaultAvatar() =>
      Icon(Icons.person, size: 25.r, color: AppColors.primaryColor);

  Widget buildPostTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      child: Row(
        children: [
          Icon(Icons.short_text_rounded,
              color: AppColors.primaryColor, size: 20.sp),
          horizontalSpace(6),
          Expanded(
            child: Text(
              title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: AppStyles.styleBold16.copyWith(
                color: AppColors.primaryColor,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPostBody(String body) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Text(
        body,
        style:
            AppStyles.styleMedium12.copyWith(color: AppColors.blackTextColor),
      ),
    );
  }

  Widget buildPostImage(String imageUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => FullScreenImageView(imageUrl: imageUrl),
        ));
      },
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(maxHeight: 400.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Icon(Icons.broken_image, size: 50.sp),
            loadingBuilder: (_, child, loadingProgress) =>
                loadingProgress == null
                    ? child
                    : const Center(
                        child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      )),
          ),
        ),
      ),
    );
  }

  Widget buildPostStats() {
    return Row(
      children: [
        Icon(Icons.favorite, color: AppColors.red500Color, size: 18.sp),
        horizontalSpace(5),
        Text('$likeCount اعجاب', style: AppStyles.styleMedium12),
        const Spacer(),
        Text('$commentCount تعليق', style: AppStyles.styleMedium12),
        horizontalSpace(10),
        Text('0 اعادة نشر', style: AppStyles.styleMedium12),
      ],
    );
  }

  Widget buildPostActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildActionButton(
          icon: isLiked ? Icons.favorite : Icons.favorite_border,
          label: 'اعجاب',
          onPressed: toggleLike,
          color: isLiked ? AppColors.red500Color : null,
        ),
        buildActionButton(
          icon: Icons.comment_outlined,
          label: 'تعليق',
          onPressed: openCommentSection,
        ),
        buildActionButton(
          icon: Icons.share,
          label: 'مشاركة',
          onPressed: () {}, // Add sharing logic later
        ),
      ],
    );
  }

  Widget buildActionButton({
    required IconData icon,
    required String label,
    VoidCallback? onPressed,
    Color? color,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: color ?? AppColors.blackTextColor, size: 20.sp),
      label: Text(label,
          style: AppStyles.styleMedium12
              .copyWith(color: color ?? AppColors.blackTextColor)),
    );
  }
}
