import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/assets.dart';
import 'package:damma_project/features/add_post/presentation/widgets/privacy_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_styles.dart';

class PrivacyInfo extends StatefulWidget {
  const PrivacyInfo({super.key});

  @override
  State<PrivacyInfo> createState() => _PrivacyInfoState();
}

class _PrivacyInfoState extends State<PrivacyInfo> {
  String selectedVisibilityOption = "أي شخص";
  String selectedCommentsOption = "أي شخص";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 60.w,
          child: Text(
            selectedVisibilityOption,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: AppStyles.styleMedium14.copyWith(
              color: AppColors.blackTextColor,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            PrivacyBottomSheet.showBottomSheet(
              context,
              selectedVisibilityOption,
              selectedCommentsOption,
              (newVisibility) {
                setState(() {
                  selectedVisibilityOption = newVisibility;
                });
              },
              (newCommentsOption) {
                setState(() {
                  selectedCommentsOption = newCommentsOption;
                });
              },
            );
          },
          icon: SvgPicture.asset(Assets.svgArrowDown),
        ),
      ],
    );
  }
}
