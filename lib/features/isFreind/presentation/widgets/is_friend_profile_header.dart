// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../../../../core/utils/app_colors.dart';
// import '../../../../../core/utils/assets.dart';
// import '../../../../core/utils/widgets/full_screen_image_view.dart';
//
// const String baseUrl = 'http://dama.runasp.net/';
//
// class IsFriendProfileHeader extends StatelessWidget {
//   final String? profileImageUrl; // relative path from user model
//   final String? coverImageUrl; // relative path from user model
//
//   const IsFriendProfileHeader(
//       {super.key, this.profileImageUrl, this.coverImageUrl});
//
//   @override
//   Widget build(BuildContext context) {
//     final fullProfileImageUrl = (profileImageUrl != null &&
//             profileImageUrl!.isNotEmpty &&
//             profileImageUrl!.trim() != '/uploads/users/')
//         ? '$baseUrl${profileImageUrl!.startsWith('/') ? profileImageUrl!.substring(1) : profileImageUrl}'
//         : null;
//
//     final fullCoverImageUrl = (coverImageUrl != null &&
//             coverImageUrl!.isNotEmpty)
//         ? '$baseUrl${coverImageUrl!.startsWith('/') ? coverImageUrl!.substring(1) : coverImageUrl}'
//         : null;
//
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         Stack(
//           children: [
//             SizedBox(
//               width: 375.w,
//               height: 150.h,
//               child: GestureDetector(
//                 onTap: () {
//                   if (fullCoverImageUrl != null) {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (_) =>
//                           FullScreenImageView(imageUrl: fullCoverImageUrl),
//                     ));
//                   } else {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (_) => const FullScreenImageView(
//                           imageProvider: AssetImage(
//                               'assets/images/default_cover_image.png')),
//                     ));
//                   }
//                 },
//                 child: fullCoverImageUrl != null
//                     ? Image.network(
//                         fullCoverImageUrl,
//                         fit: BoxFit.cover,
//                         errorBuilder: (_, __, ___) => Image.asset(
//                           'assets/images/default_cover_image.png',
//                           fit: BoxFit.cover,
//                         ),
//                       )
//                     : Image.asset(
//                         'assets/images/default_cover_image.png',
//                         fit: BoxFit.fill,
//                       ),
//               ),
//             ),
//           ],
//         ),
//         Positioned(
//           bottom: -30.h,
//           left: (375.w / 2) - 60.r,
//           child: Stack(
//             alignment: Alignment.center,
//             clipBehavior: Clip.none,
//             children: [
//               Positioned(
//                 top: -6,
//                 child: CircleAvatar(
//                   radius: 65.r,
//                   backgroundColor: AppColors.whiteColor,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   if (fullProfileImageUrl != null) {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (_) =>
//                           FullScreenImageView(imageUrl: fullProfileImageUrl),
//                     ));
//                   } else {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (_) => const FullScreenImageView(
//                           imageProvider: AssetImage(
//                             'assets/images/default_profile_image.png',
//                           ),
//                         ),
//                       ),
//                     );
//                   }
//                 },
//                 child: CircleAvatar(
//                   radius: 60.r,
//                   backgroundImage: fullProfileImageUrl != null
//                       ? NetworkImage(fullProfileImageUrl)
//                       : const AssetImage(
//                           'assets/images/default_profile_image.png',
//                         ) as ImageProvider,
//                   onBackgroundImageError: (_, __) {},
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
//
