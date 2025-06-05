import 'package:damma_project/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MediaButton extends StatelessWidget {
  final String icon;
  final VoidCallback onPressed;
  final bool isActive;

  const MediaButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isActive ? onPressed : null,
      icon: SvgPicture.asset(
        icon,
        color: isActive ? AppColors.primaryColor : Colors.grey,
      ),
    );
  }
}
