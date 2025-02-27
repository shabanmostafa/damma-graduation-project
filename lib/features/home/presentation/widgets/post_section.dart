// import 'package:damma_project/features/home/models/post_model.dart';
// import 'package:damma_project/features/home/presentation/widgets/post_actions.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../../../../core/utils/app_colors.dart';
// import '../../../../core/utils/app_styles.dart';
// import '../../../../core/utils/assets.dart';
// import '../../../../core/utils/spacing.dart';

// class PostSection extends StatelessWidget {
//   const PostSection({
//     super.key,
//     required this.postModel,
//   });
//   final PostModel postModel;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               SizedBox(
//                 height: 50.h,
//                 width: 50.w,
//                 child: Image.asset(postModel.postOwnerPic),
//               ),
//               horizontalSpace(15),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       postModel.postOwnerName,
//                       style: AppStyles.styleBold16,
//                     ),
//                     Text(
//                       postModel.postOwnerfriends,
//                       style: AppStyles.styleMedium12,
//                     ),
//                   ],
//                 ),
//               ),
//               const Icon(Icons.more_horiz)
//             ],
//           ),
//           verticalSpace(12),
//           Text(
//             postModel.postContent,
//             style: AppStyles.styleMedium12.copyWith(
//               color: AppColors.blackTextColor,
//             ),
//           ),
//           verticalSpace(12),
//           Container(
//             width: double.infinity,
//             constraints:
//                 BoxConstraints(maxHeight: 400.h), // Adjust max height as needed
//             child: Image.asset(
//               postModel.postImage,
//               fit: BoxFit.cover, // Fills the width and crops excess height
//             ),
//           ),
//           verticalSpace(12),
//           Row(
//             children: [
//               SvgPicture.asset(Assets.svgsLike),
//               horizontalSpace(5),
//               Text(
//                 '${postModel.numberOfLikes} اعجاب',
//                 style: AppStyles.styleMedium12,
//               ),
//               const Spacer(),
//               Text(
//                 '${postModel.numberOfComments} تعليق',
//                 style: AppStyles.styleMedium12,
//               ),
//               horizontalSpace(10),
//               Text(
//                 '${postModel.numberOfShares} اعادة نشر',
//                 style: AppStyles.styleMedium12,
//               ),
//             ],
//           ),
//           const Divider(),
//           verticalSpace(8),
//           const PostActions(),
//           verticalSpace(10),
//           Row(
//             children: [
//               const CircleAvatar(
//                 radius: 20,
//                 backgroundImage: AssetImage('assets/images/shaban.jpg'),
//               ),
//               horizontalSpace(8),
//               Expanded(
//                 child: Container(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(20.r),
//                   ),
//                   child: Text('اكتب تعليق...', style: AppStyles.styleMedium12),
//                 ),
//               ),
//             ],
//           ),
//           verticalSpace(10),
//         ],
//       ),
//     );
//   }
// }

import 'package:damma_project/features/home/models/post_model.dart';
import 'package:damma_project/features/home/presentation/widgets/post_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/spacing.dart';

class PostSection extends StatefulWidget {
  const PostSection({
    super.key,
    required this.postModel,
  });

  final PostModel postModel;

  @override
  State<PostSection> createState() => _PostSectionState();
}

class _PostSectionState extends State<PostSection> {
  late int likeCount;
  late bool isLiked;

  @override
  void initState() {
    super.initState();
    likeCount = convertLikesToInt(widget.postModel.numberOfLikes);
    isLiked = false;
  }

  void updateLikeCount() {
    setState(() {
      if (isLiked) {
        likeCount--;
      } else {
        likeCount++;
      }
      isLiked = !isLiked;
    });
  }

  int convertLikesToInt(String likes) {
    likes = likes
        .replaceAll(',', '')
        .trim(); // Remove commas (e.g., "5,432" → "5432")

    if (likes.contains('K')) {
      return (double.parse(likes.replaceAll('K', '')) * 1000).toInt();
    } else if (likes.contains('M')) {
      return (double.parse(likes.replaceAll('M', '')) * 1000000).toInt();
    } else {
      return int.tryParse(likes) ?? 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 50.h,
                width: 50.w,
                child: Image.asset(widget.postModel.postOwnerPic),
              ),
              horizontalSpace(15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.postModel.postOwnerName,
                      style: AppStyles.styleBold16,
                    ),
                    Text(
                      widget.postModel.postOwnerfriends,
                      style: AppStyles.styleMedium12,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_horiz)
            ],
          ),
          verticalSpace(12),
          Text(
            widget.postModel.postContent,
            style: AppStyles.styleMedium12.copyWith(
              color: AppColors.blackTextColor,
            ),
          ),
          verticalSpace(12),
          Container(
            width: double.infinity,
            constraints: BoxConstraints(maxHeight: 400.h),
            child: Image.asset(
              widget.postModel.postImage,
              fit: BoxFit.cover,
            ),
          ),
          verticalSpace(12),
          Row(
            children: [
              SvgPicture.asset(Assets.svgsLike),
              horizontalSpace(5),
              Text(
                '$likeCount اعجاب',
                style: AppStyles.styleMedium12,
              ),
              const Spacer(),
              Text(
                '${widget.postModel.numberOfComments} تعليق',
                style: AppStyles.styleMedium12,
              ),
              horizontalSpace(10),
              Text(
                '${widget.postModel.numberOfShares} اعادة نشر',
                style: AppStyles.styleMedium12,
              ),
            ],
          ),
          const Divider(),
          verticalSpace(8),
          PostActions(onLikePressed: updateLikeCount, isLiked: isLiked),
          verticalSpace(10),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(widget.postModel.userProfilePic),
              ),
              horizontalSpace(8),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text('اكتب تعليق...', style: AppStyles.styleMedium12),
                ),
              ),
            ],
          ),
          verticalSpace(10),
        ],
      ),
    );
  }
}
