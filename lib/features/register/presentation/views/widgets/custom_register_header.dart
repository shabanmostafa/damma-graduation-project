import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_styles.dart';

class CustomRegisterHeader extends StatelessWidget {
  const CustomRegisterHeader({
    super.key,
    required this.pageTitle,
  });

  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          pageTitle,
          style: AppStyles.styleBold32.copyWith(fontSize: 24.sp),
        ),
      ],
    );
  }
}
