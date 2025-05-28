import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_colors.dart';

// class AppTextButton extends StatelessWidget {
//   final double? borderRadius;
//   // Optional border radius for the button.
//   final Color? backgroundColor;
//   // Optional background color for the button.
//   final double? horizontalPadding;
//   // Optional horizontal padding for the button.
//   final double? verticalPadding;
//   // Optional vertical padding for the button.
//   final double? buttonWidth;
//   // Optional width for the button.
//   final double? buttonHeight;
//   // Optional height for the button.
//   final String buttonText;
//   // Required text to be displayed on the button.
//   final TextStyle textStyle;
//   // Required text style for the button text.
//   final VoidCallback onPressed;
//   // Required callback function to be executed when the button is pressed.
//   const AppTextButton({
//     super.key,
//     this.borderRadius,
//     this.backgroundColor,
//     this.horizontalPadding,
//     this.verticalPadding,
//     this.buttonHeight,
//     this.buttonWidth,
//     required this.buttonText,
//     required this.textStyle,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: buttonWidth ?? double.infinity,
//       height: buttonHeight ?? 54.h,
//       child: TextButton(
//         style: ButtonStyle(
//           shape: WidgetStateProperty.all<RoundedRectangleBorder>(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(
//                 borderRadius ?? 13.0.r,
//               ),
//             ),
//           ),
//           backgroundColor: WidgetStatePropertyAll(
//             backgroundColor ?? AppColors.primaryColor,
//           ),
//         ),
//         onPressed: onPressed,
//         child: Center(
//           child: Text(
//             buttonText,
//             style: textStyle,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_colors.dart';

class AppTextButton extends StatelessWidget {
  final double? borderRadius;
  final Color? backgroundColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? buttonWidth;
  final double? buttonHeight;
  final String buttonText;
  final TextStyle textStyle;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? loadingIndicatorColor;
  final double? loadingIndicatorSize;

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
    this.isLoading = false,
    this.loadingIndicatorColor,
    this.loadingIndicatorSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth ?? double.infinity,
      height: buttonHeight ?? 54.h,
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
          overlayColor: WidgetStateProperty.resolveWith<Color>(
            (states) => states.contains(WidgetState.pressed)
                ? (backgroundColor ?? AppColors.primaryColor).withOpacity(0.8)
                : Colors.transparent,
          ),
          padding: WidgetStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(
              horizontal: horizontalPadding ?? 0,
              vertical: verticalPadding ?? 0,
            ),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: loadingIndicatorSize ?? 24.r,
                  height: loadingIndicatorSize ?? 24.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: loadingIndicatorColor ?? AppColors.whiteColor,
                  ),
                )
              : Text(
                  buttonText,
                  style: textStyle,
                  overflow: TextOverflow.ellipsis,
                ),
        ),
      ),
    );
  }
}
