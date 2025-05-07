import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/spacing.dart';
import 'package:flutter/material.dart';

import '../app_colors.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    super.key,
    this.text,
    this.icon,
    this.onPressed,
    this.needArrow = true,
  });

  final bool needArrow;
  final String? text;
  final Widget? icon;
  final void Function()? onPressed;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (widget.needArrow)
          IconButton(
            onPressed: widget.onPressed ?? () => Navigator.pop(context),
            icon: widget.icon ??
                const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.blackTextColor,
                ),
          )
        else
          horizontalSpace(48), // Placeholder to maintain alignment

        Expanded(
          child: Text(
            widget.text ?? '',
            style: AppStyles.styleMedium16.copyWith(
              color: AppColors.blackTextColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        horizontalSpace(48), // Placeholder for symmetry
      ],
    );
  }
}
