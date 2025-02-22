import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_colors.dart';

class AppTextButton extends StatelessWidget {
  final double? borderRadius;
  // Optional border radius for the button.
  final Color? backgroundColor;
  // Optional background color for the button.
  final double? horizontalPadding;
  // Optional horizontal padding for the button.
  final double? verticalPadding;
  // Optional vertical padding for the button.
  final double? buttonWidth;
  // Optional width for the button.
  final double? buttonHeight;
  // Optional height for the button.
  final String buttonText;
  // Required text to be displayed on the button.
  final TextStyle textStyle;
  // Required text style for the button text.
  final VoidCallback onPressed;
  // Required callback function to be executed when the button is pressed.
  const AppTextButton({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.buttonHeight,
    this.buttonWidth,
    required this.buttonText,
    required this.textStyle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54.h,
      child: TextButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderRadius ?? 13.0.r,
              ),
            ),
          ),
          backgroundColor: WidgetStatePropertyAll(
            backgroundColor ?? AppColors.primaryColor,
          ),
        ),
        onPressed: onPressed,
        child: Center(
          child: Text(
            buttonText,
            style: textStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
