import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/assets.dart';
import '../../../../core/utils/routing/routes.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          Assets.svgsBlackLogo,
          height: 55.h,
          width: 118.w,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Routes.welcomeView);
          },
          child: SvgPicture.asset(Assets.svgsBell),
        )
      ],
    );
  }
}
