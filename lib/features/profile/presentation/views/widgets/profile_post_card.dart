// import 'package:damma_project/features/profile/manager/profile_posts_cubit/profile_posts_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:damma_project/core/utils/app_colors.dart';
// import 'package:damma_project/core/utils/app_styles.dart';
// import 'package:damma_project/core/utils/spacing.dart';
// import 'package:damma_project/core/utils/widgets/full_screen_image_view.dart';
// import 'package:damma_project/core/utils/models/user_model.dart';
// import 'package:damma_project/features/profile/data/models/profile_post_model.dart';
// import 'package:damma_project/features/profile/presentation/views/widgets/profile_comment_section.dart';

// class PostCard extends StatefulWidget {
//   final Posts post;
//   final UserModel profile;
//   final Function()? onPostUpdated;

//   const PostCard({
//     super.key,
//     required this.post,
//     required this.profile,
//     this.onPostUpdated,
//   });

//   @override
//   State<PostCard> createState() => _PostCardState();
// }

// class _PostCardState extends State<PostCard> {
//   late int likeCount;
//   late int commentCount;
//   bool isLiked = false;
//   late List<Comments> comments;
//   final TextEditingController _commentController = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     likeCount = widget.post.totalReactions ?? 0;
//     commentCount = widget.post.totalComments ?? 0;
//     comments = widget.post.comments ?? [];
//     isLiked = widget.post.reactions?.any((r) => r.userID == widget.profile.id) ?? false;
//   }

//   void toggleLike() {
//     final postsCubit = context.read<ProfilePostsCubit>();

//     setState(() {
//       if (isLiked) {
//         likeCount -= 1;
//         postsCubit.removeReaction(widget.post.postId!);
//       } else {
//         likeCount += 1;
//         postsCubit.addReaction(widget.post.postId!, 'like');
//       }
//       isLiked = !isLiked;
//     });

//     if (widget.onPostUpdated != null) {
//       widget.onPostUpdated!();
//     }
//   }

//   void openCommentSection() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (_) => DraggableScrollableSheet(
//         expand: false,
//         initialChildSize: 0.6,
//         minChildSize: 0.4,
//         maxChildSize: 0.95,
//         builder: (context, scrollController) => Container(
//           decoration: const BoxDecoration(
//             color: AppColors.whiteColor,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//           ),
//           child: Column(
//             children: [
//               Container(
//                 width: 40.w,
//                 height: 5.h,
//                 margin: EdgeInsets.symmetric(vertical: 10.h),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[400],
//                   borderRadius: BorderRadius.circular(10.r),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.w),
//                 child: Text(
//                   'التعليقات',
//                   style: AppStyles.styleBold16,
//                 ),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   controller: scrollController,
//                   itemCount: comments.length,
//                   itemBuilder: (context, index) {
//                     final comment = comments[index];
//                     return ListTile(
//                       leading: CircleAvatar(
//                         backgroundImage: comment.profileImageUrl != null
//                             ? NetworkImage(getFullProfileImageUrl(
//                                 comment.profileImageUrl!))
//                             : const AssetImage(
//                                     'assets/images/default_avatar.png')
//                                 as ImageProvider,
//                       ),
//                       title: Text(
//                         '${comment.firstName ?? ''} ${comment.lastName ?? ''}',
//                         style: AppStyles.styleMedium12,
//                       ),
//                       subtitle: Text(
//                         comment.content ?? '',
//                         style: AppStyles.styleMedium12,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(16.w),
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 20.r,
//                       backgroundImage: widget.profile.profileImageUrl != null
//                           ? NetworkImage(getFullProfileImageUrl(
//                               widget.profile.profileImageUrl!))
//                           : const AssetImage('assets/images/default_avatar.png')
//                               as ImageProvider,
//                     ),
//                     horizontalSpace(8),
//                     Expanded(
//                       child: TextField(
//                         controller: _commentController,
//                         decoration: InputDecoration(
//                           hintText: 'اكتب تعليق...',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20.r),
//                           ),
//                           contentPadding: EdgeInsets.symmetric(
//                               horizontal: 12.w, vertical: 10.h),
//                         ),
//                         onSubmitted: (value) => submitComment(),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void submitComment() {
//     final commentText = _commentController.text.trim();
//     if (commentText.isNotEmpty) {
//       final postsCubit = context.read<ProfilePostsCubit>();
//       postsCubit.addComment(widget.post.postId!, commentText);

//       setState(() {
//         commentCount += 1;
//         comments.add(Comments(
//           content: commentText,
//           userID: widget.profile.id,
//           firstName: widget.profile.firstName,
//           lastName: widget.profile.lastName,
//           profileImageUrl: widget.profile.profileImageUrl,
//         ));
//         _commentController.clear();
//       });

//       if (widget.onPostUpdated != null) {
//         widget.onPostUpdated!();
//       }
//     }
//   }

//   String getFullProfileImageUrl(String path) {
//     if (path.startsWith('http')) return path;
//     return 'http://dama.runasp.net${path.startsWith('/') ? '' : '/'}$path';
//   }

//   String? getFullImageUrl(String? path) {
//     if (path == null || path.isEmpty || path.endsWith('/')) return null;
//     if (path.startsWith('http')) return path;
//     return 'http://dama.runasp.net${path.startsWith('/') ? '' : '/'}$path';
//   }

//   @override
//   Widget build(BuildContext context) {
//     final profileImage = getFullImageUrl(widget.profile.profileImageUrl);
//     final postImage = getFullImageUrl(widget.post.mediaUrl);

//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           buildUserHeader(profileImage),
//           if (widget.post.postTitle?.isNotEmpty ?? false)
//             buildPostTitle(widget.post.postTitle!),
//           if (widget.post.postBody?.isNotEmpty ?? false)
//             buildPostBody(widget.post.postBody!),
//           verticalSpace(8),
//           if (postImage != null && postImage.isNotEmpty)
//             buildPostImage(postImage),
//           verticalSpace(12),
//           buildPostStats(),
//           buildPostActions(),
//           buildCommentInput(profileImage),
//           const Divider(color: AppColors.primaryColor),
//         ],
//       ),
//     );
//   }

//   Widget buildUserHeader(String? profileImageUrl) {
//     return Row(
//       children: [
//         GestureDetector(
//           onTap: () {
//             Navigator.of(context).push(MaterialPageRoute(
//               builder: (_) => FullScreenImageView(
//                 imageUrl: profileImageUrl,
//                 imageProvider: profileImageUrl == null
//                     ? const AssetImage(
//                         'assets/images/default_profile_image.png')
//                     : null,
//               ),
//             ));
//           },
//           child: CircleAvatar(
//             radius: 25.r,
//             backgroundColor: AppColors.primaryColor.withOpacity(0.1),
//             child: profileImageUrl != null
//                 ? ClipOval(
//                     child: Image.network(
//                       profileImageUrl,
//                       width: 50.w,
//                       height: 50.h,
//                       fit: BoxFit.cover,
//                       errorBuilder: (_, __, ___) => buildDefaultAvatar(),
//                       loadingBuilder: (_, child, loadingProgress) =>
//                           loadingProgress == null
//                               ? child
//                               : const Center(
//                                   child: CircularProgressIndicator(
//                                     strokeWidth: 1.5,
//                                     color: AppColors.primaryColor,
//                                   ),
//                                 ),
//                     ),
//                   )
//                 : buildDefaultAvatar(),
//           ),
//         ),
//         horizontalSpace(15),
//         Expanded(
//           child: Text(
//             '${widget.profile.firstName ?? ''} ${widget.profile.lastName ?? ''}',
//             style: AppStyles.styleBold16,
//           ),
//         ),
//         const Icon(Icons.more_horiz),
//       ],
//     );
//   }

//   Widget buildPostTitle(String title) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
//       child: Row(
//         children: [
//           Icon(Icons.short_text_rounded,
//               color: AppColors.primaryColor, size: 20.sp),
//           horizontalSpace(6),
//           Expanded(
//             child: Text(
//               title,
//               maxLines: 3,
//               overflow: TextOverflow.ellipsis,
//               textAlign: TextAlign.right,
//               style: AppStyles.styleBold16.copyWith(
//                 color: AppColors.primaryColor,
//                 height: 1.5,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildPostBody(String body) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Text(
//         body,
//         style:
//             AppStyles.styleMedium12.copyWith(color: AppColors.blackTextColor),
//       ),
//     );
//   }

//   Widget buildPostImage(String imageUrl) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (_) => FullScreenImageView(imageUrl: imageUrl),
//         ));
//       },
//       child: Container(
//         width: double.infinity,
//         constraints: BoxConstraints(maxHeight: 400.h),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(8.r),
//           child: Image.network(
//             imageUrl,
//             fit: BoxFit.cover,
//             errorBuilder: (_, __, ___) => Icon(Icons.broken_image, size: 50.sp),
//             loadingBuilder: (_, child, loadingProgress) =>
//                 loadingProgress == null
//                     ? child
//                     : const Center(
//                         child: CircularProgressIndicator(
//                         color: AppColors.primaryColor,
//                       )),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildPostStats() {
//     return Row(
//       children: [
//         Icon(Icons.favorite, color: AppColors.red500Color, size: 18.sp),
//         horizontalSpace(5),
//         Text('$likeCount اعجاب', style: AppStyles.styleMedium12),
//         const Spacer(),
//         Text('$commentCount تعليق', style: AppStyles.styleMedium12),
//         horizontalSpace(10),
//         Text('0 اعادة نشر', style: AppStyles.styleMedium12),
//       ],
//     );
//   }

//   Widget buildPostActions() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         buildActionButton(
//           icon: isLiked ? Icons.favorite : Icons.favorite_border,
//           label: 'اعجاب',
//           onPressed: toggleLike,
//           color: isLiked ? AppColors.red500Color : null,
//         ),
//         buildActionButton(
//           icon: Icons.comment_outlined,
//           label: 'تعليق',
//           onPressed: openCommentSection,
//         ),
//         buildActionButton(
//           icon: Icons.share,
//           label: 'مشاركة',
//           onPressed: () {}, // Add sharing logic later
//         ),
//       ],
//     );
//   }

//   Widget buildCommentInput(String? profileImageUrl) {
//     return Row(
//       children: [
//         CircleAvatar(
//           radius: 20.r,
//           backgroundColor: AppColors.primaryColor.withOpacity(0.1),
//           child: profileImageUrl != null
//               ? ClipOval(
//                   child: Image.network(
//                     profileImageUrl,
//                     width: 40.w,
//                     height: 40.h,
//                     fit: BoxFit.cover,
//                     errorBuilder: (_, __, ___) => buildSmallDefaultAvatar(),
//                   ),
//                 )
//               : buildSmallDefaultAvatar(),
//         ),
//         horizontalSpace(8),
//         Expanded(
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey),
//               borderRadius: BorderRadius.circular(20.r),
//             ),
//             child: Text(
//               'اكتب تعليق...',
//               style: AppStyles.styleMedium12,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildDefaultAvatar() =>
//       Icon(Icons.person, size: 25.r, color: AppColors.primaryColor);

//   Widget buildSmallDefaultAvatar() =>
//       Icon(Icons.person, size: 20.r, color: AppColors.primaryColor);

//   Widget buildActionButton({
//     required IconData icon,
//     required String label,
//     VoidCallback? onPressed,
//     Color? color,
//   }) {
//     return TextButton.icon(
//       onPressed: onPressed,
//       icon: Icon(icon, color: color ?? AppColors.blackTextColor, size: 20.sp),
//       label: Text(label,
//           style: AppStyles.styleMedium12
//               .copyWith(color: color ?? AppColors.blackTextColor)),
//     );
//   }
// }

import 'package:damma_project/features/profile/manager/profile_posts_cubit/profile_posts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/spacing.dart';
import 'package:damma_project/core/utils/widgets/full_screen_image_view.dart';
import 'package:damma_project/core/utils/models/user_model.dart';
import 'package:damma_project/features/profile/data/models/profile_post_model.dart';

class PostCard extends StatefulWidget {
  final Posts post;
  final UserModel profile;
  final Function()? onPostUpdated;

  const PostCard({
    super.key,
    required this.post,
    required this.profile,
    this.onPostUpdated,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late int likeCount;
  late int commentCount;
  bool isLiked = false;
  late List<Comments> comments;
  final TextEditingController _commentController = TextEditingController();
  bool _isSubmittingComment = false;

  @override
  void initState() {
    super.initState();
    likeCount = widget.post.totalReactions ?? 0;
    commentCount = widget.post.totalComments ?? 0;
    comments = widget.post.comments ?? [];
    isLiked =
        widget.post.reactions?.any((r) => r.userID == widget.profile.id) ??
            false;
  }

  void toggleLike() {
    final postsCubit = context.read<ProfilePostsCubit>();

    setState(() {
      if (isLiked) {
        likeCount -= 1;
        postsCubit.removeReaction(widget.post.postId!);
      } else {
        likeCount += 1;
        postsCubit.addReaction(widget.post.postId!, 'like');
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
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: comment.profileImageUrl != null
                            ? NetworkImage(getFullProfileImageUrl(
                                comment.profileImageUrl!))
                            : const AssetImage(
                                    'assets/images/default_avatar.png')
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
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundImage: widget.profile.profileImageUrl != null
                          ? NetworkImage(getFullProfileImageUrl(
                              widget.profile.profileImageUrl!))
                          : const AssetImage('assets/images/default_avatar.png')
                              as ImageProvider,
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
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 10.h),
                          suffixIcon: IconButton(
                            icon: _isSubmittingComment
                                ? const CircularProgressIndicator()
                                : const Icon(Icons.send),
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

    final postsCubit = context.read<ProfilePostsCubit>();
    final success =
        await postsCubit.addComment(widget.post.postId!, commentText);

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add comment')),
      );
      setState(() => _isSubmittingComment = false);
      return;
    }

    // Success
    setState(() {
      commentCount += 1;
      comments.insert(
          0,
          Comments(
            content: commentText,
            userID: widget.profile.id,
            firstName: widget.profile.firstName,
            lastName: widget.profile.lastName,
            profileImageUrl: widget.profile.profileImageUrl,
          ));
      _commentController.clear();
      _isSubmittingComment = false;
    });
  }

  String getFullProfileImageUrl(String path) {
    if (path.startsWith('http')) return path;
    return 'http://dama.runasp.net${path.startsWith('/') ? '' : '/'}$path';
  }

  String? getFullImageUrl(String? path) {
    if (path == null || path.isEmpty || path.endsWith('/')) return null;
    if (path.startsWith('http')) return path;
    return 'http://dama.runasp.net${path.startsWith('/') ? '' : '/'}$path';
  }

  @override
  Widget build(BuildContext context) {
    final profileImage = getFullImageUrl(widget.profile.profileImageUrl);
    final postImage = getFullImageUrl(widget.post.mediaUrl);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildUserHeader(profileImage),
          if (widget.post.postTitle?.isNotEmpty ?? false)
            buildPostTitle(widget.post.postTitle!),
          if (widget.post.postBody?.isNotEmpty ?? false)
            buildPostBody(widget.post.postBody!),
          verticalSpace(8),
          if (postImage != null && postImage.isNotEmpty)
            buildPostImage(postImage),
          verticalSpace(12),
          buildPostStats(),
          buildPostActions(),
          const Divider(color: AppColors.primaryColor),
        ],
      ),
    );
  }

  Widget buildUserHeader(String? profileImageUrl) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => FullScreenImageView(
                imageUrl: profileImageUrl,
                imageProvider: profileImageUrl == null
                    ? const AssetImage(
                        'assets/images/default_profile_image.png')
                    : null,
              ),
            ));
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
            '${widget.profile.firstName ?? ''} ${widget.profile.lastName ?? ''}',
            style: AppStyles.styleBold16,
          ),
        ),
        const Icon(Icons.more_horiz),
      ],
    );
  }

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

  Widget buildCommentInput(String? profileImageUrl) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20.r,
          backgroundColor: AppColors.primaryColor.withOpacity(0.1),
          child: profileImageUrl != null
              ? ClipOval(
                  child: Image.network(
                    profileImageUrl,
                    width: 40.w,
                    height: 40.h,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => buildSmallDefaultAvatar(),
                  ),
                )
              : buildSmallDefaultAvatar(),
        ),
        horizontalSpace(8),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'اكتب تعليق...',
              style: AppStyles.styleMedium12,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDefaultAvatar() =>
      Icon(Icons.person, size: 25.r, color: AppColors.primaryColor);

  Widget buildSmallDefaultAvatar() =>
      Icon(Icons.person, size: 20.r, color: AppColors.primaryColor);

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
