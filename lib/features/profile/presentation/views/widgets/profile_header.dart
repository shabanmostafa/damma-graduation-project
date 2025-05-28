// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import '../../../../../core/utils/app_colors.dart';
// import '../../../../../core/utils/assets.dart';

// const String baseUrl = 'http://dama.runasp.net/';

// class ProfileHeader extends StatelessWidget {
//   final String? profileImageUrl; // relative path from user model
//   final String? coverImageUrl; // relative path from user model

//   const ProfileHeader({super.key, this.profileImageUrl, this.coverImageUrl});

//   @override
//   Widget build(BuildContext context) {
//     final fullProfileImageUrl =
//         (profileImageUrl != null && profileImageUrl!.isNotEmpty)
//             ? '$baseUrl$profileImageUrl'
//             : null;

//     final fullCoverImageUrl =
//         (coverImageUrl != null && coverImageUrl!.isNotEmpty)
//             ? '$baseUrl$coverImageUrl'
//             : null;

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
//                     ? Image.network(fullCoverImageUrl, fit: BoxFit.cover)
//                     : Image.asset(
//                         'assets/images/default_cover_image.png',
//                         fit: BoxFit.fill,
//                       ),
//               ),
//             ),
//             Positioned(
//               top: 8,
//               right: 8,
//               child: CircleAvatar(
//                 backgroundColor: AppColors.hintTextColor,
//                 radius: 16.r,
//                 child: SvgPicture.asset(Assets.svgsCamera),
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
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (_) => const FullScreenImageView(
//                           imageProvider:
//                               AssetImage('assets/images/shaban.jpg')),
//                     ));
//                   }
//                 },
//                 child: CircleAvatar(
//                   radius: 60.r,
//                   backgroundImage: fullProfileImageUrl != null
//                       ? NetworkImage(fullProfileImageUrl)
//                       : const AssetImage('assets/images/shaban.jpg')
//                           as ImageProvider,
//                 ),
//               ),
//               Positioned(
//                 bottom: 8,
//                 right: 4,
//                 child: CircleAvatar(
//                   backgroundColor: AppColors.hintTextColor,
//                   radius: 16.r,
//                   child: SvgPicture.asset(Assets.svgsCamera),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class FullScreenImageView extends StatelessWidget {
//   final String? imageUrl;
//   final ImageProvider? imageProvider;

//   const FullScreenImageView({super.key, this.imageUrl, this.imageProvider});

//   @override
//   Widget build(BuildContext context) {
//     final ImageProvider image = imageProvider ?? NetworkImage(imageUrl!);

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppColors.whiteColor,
//         appBar: AppBar(
//           backgroundColor: AppColors.primaryColor,
//           elevation: 0,
//           iconTheme: const IconThemeData(color: Colors.white),
//         ),
//         body: Center(
//           child: InteractiveViewer(
//             maxScale: 5,
//             child: Image(
//               image: image,
//               fit: BoxFit.contain,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/assets.dart';

const String baseUrl = 'http://dama.runasp.net/';

class ProfileHeader extends StatelessWidget {
  final String? profileImageUrl; // relative path from user model
  final String? coverImageUrl; // relative path from user model

  const ProfileHeader({super.key, this.profileImageUrl, this.coverImageUrl});

  @override
  Widget build(BuildContext context) {
    final fullProfileImageUrl = (profileImageUrl != null &&
            profileImageUrl!.isNotEmpty &&
            profileImageUrl!.trim() != '/uploads/users/')
        ? '$baseUrl${profileImageUrl!.startsWith('/') ? profileImageUrl!.substring(1) : profileImageUrl}'
        : null;

    final fullCoverImageUrl = (coverImageUrl != null &&
            coverImageUrl!.isNotEmpty)
        ? '$baseUrl${coverImageUrl!.startsWith('/') ? coverImageUrl!.substring(1) : coverImageUrl}'
        : null;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Stack(
          children: [
            SizedBox(
              width: 375.w,
              height: 150.h,
              child: GestureDetector(
                onTap: () {
                  if (fullCoverImageUrl != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          FullScreenImageView(imageUrl: fullCoverImageUrl),
                    ));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const FullScreenImageView(
                          imageProvider: AssetImage(
                              'assets/images/default_cover_image.png')),
                    ));
                  }
                },
                child: fullCoverImageUrl != null
                    ? Image.network(
                        fullCoverImageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Image.asset(
                          'assets/images/default_cover_image.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        'assets/images/default_cover_image.png',
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: CircleAvatar(
                backgroundColor: AppColors.hintTextColor,
                radius: 16.r,
                child: SvgPicture.asset(Assets.svgsCamera),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: -30.h,
          left: (375.w / 2) - 60.r,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -6,
                child: CircleAvatar(
                  radius: 65.r,
                  backgroundColor: AppColors.whiteColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (fullProfileImageUrl != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          FullScreenImageView(imageUrl: fullProfileImageUrl),
                    ));
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const FullScreenImageView(
                          imageProvider: AssetImage(
                            'assets/images/default_profile_image.png',
                          ),
                        ),
                      ),
                    );
                  }
                },
                child: CircleAvatar(
                  radius: 60.r,
                  backgroundImage: fullProfileImageUrl != null
                      ? NetworkImage(fullProfileImageUrl)
                      : const AssetImage(
                          'assets/images/default_profile_image.png',
                        ) as ImageProvider,
                  onBackgroundImageError: (_, __) {},
                ),
              ),
              Positioned(
                bottom: 8,
                right: 4,
                child: CircleAvatar(
                  backgroundColor: AppColors.hintTextColor,
                  radius: 16.r,
                  child: SvgPicture.asset(Assets.svgsCamera),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FullScreenImageView extends StatelessWidget {
  final String? imageUrl;
  final ImageProvider? imageProvider;

  const FullScreenImageView({super.key, this.imageUrl, this.imageProvider});

  @override
  Widget build(BuildContext context) {
    final ImageProvider image = imageProvider ?? NetworkImage(imageUrl!);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Center(
          child: InteractiveViewer(
            maxScale: 5,
            child: Image(
              image: image,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Text(
                "فشل تحميل الصورة",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
