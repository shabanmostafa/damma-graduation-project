import 'package:damma_project/core/utils/widgets/full_screen_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/assets.dart';

const String baseUrl = 'http://dama.runasp.net';

class FriendsHeader extends StatelessWidget {
  final String? profileImageUrl; // relative path from user model
  final String? coverImageUrl; // relative path from user model

  const FriendsHeader({super.key, this.profileImageUrl, this.coverImageUrl});

  @override
  Widget build(BuildContext context) {
    final fullProfileImageUrl =
        (profileImageUrl != null && profileImageUrl!.isNotEmpty)
            ? '$baseUrl$profileImageUrl'
            : null;

    final fullCoverImageUrl =
        (coverImageUrl != null && coverImageUrl!.isNotEmpty)
            ? '$baseUrl$coverImageUrl'
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
                          imageProvider:
                              AssetImage('assets/images/onBoarding3.png')),
                    ));
                  }
                },
                child: fullCoverImageUrl != null
                    ? Image.network(fullCoverImageUrl, fit: BoxFit.cover)
                    : Image.asset(
                        'assets/images/onBoarding3.png',
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
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const FullScreenImageView(
                          imageProvider:
                              AssetImage('assets/images/shaban.jpg')),
                    ));
                  }
                },
                child: CircleAvatar(
                  radius: 60.r,
                  backgroundImage: fullProfileImageUrl != null
                      ? NetworkImage(fullProfileImageUrl)
                      : const AssetImage('assets/images/shaban.jpg')
                          as ImageProvider,
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
