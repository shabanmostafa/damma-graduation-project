import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_colors.dart';
import '../assets.dart';

class AppTextFormField extends StatefulWidget {
  const AppTextFormField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.suffixIcon,
    this.contentPadding,
    this.focusedBorder,
    this.controller,
    this.validator,
    this.labelText,
    this.labelStyle,
    this.enabledBorderSideColor,
    this.focusdBorderColor,
    this.hintStyle,
    this.fillColor,
    this.cursorColor,
    this.inputStyle,
    this.onTap,
    required this.prefixIcon,
  });

  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? labelText;
  final TextStyle? labelStyle;
  final Color? enabledBorderSideColor;
  final Color? focusdBorderColor;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final Color? cursorColor;
  final TextStyle? inputStyle;
  final String hintText;
  final bool isPassword;
  final String? suffixIcon;
  final String prefixIcon;

  final VoidCallback? onTap; // Define onTap field here

  @override
  DynamicTextFieldState createState() => DynamicTextFieldState();
}

class DynamicTextFieldState extends State<AppTextFormField> {
  bool isEnabled = true; // Tracks the enabled state of the TextField
  bool isFocused = false; // Tracks whether the TextField is focused
  bool isPasswordVisible = false; // Tracks the visibility of the password
  bool hasError = false; // Tracks if there's an error in the TextField

  void toggleEnabled() {
    setState(() {
      isEnabled = !isEnabled; // Toggle the enabled state
    });
  }

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible; // Toggle password visibility
    });
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focus) {
        setState(() {
          isFocused = focus; // Update focus state
        });
      },
      child: TextFormField(
        controller: widget.controller,
        validator: (value) {
          final error = widget.validator?.call(value);
          setState(() {
            hasError = error != null; // Update the error state
          });
          return error;
        },
        cursorColor: widget.cursorColor ?? AppColors.blackTextColor,
        enabled: isEnabled, // Use the dynamic state
        obscureText: widget.isPassword && !isPasswordVisible,
        textDirection: TextDirection.rtl,
        style: widget.inputStyle ??
            TextStyle(
              color: isFocused
                  ? AppColors.blackTextColor // Text color when focused
                  : isEnabled
                      ? AppColors.hintTextColor // Text color when enabled
                      : Colors.amber, // Text color when disabled
            ),
        readOnly: widget.onTap != null, // Make read-only if `onTap` is provided
        onTap: widget.onTap, // Trigger the `onTap` callback if provided
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: widget.labelStyle,
          contentPadding: widget.contentPadding ??
              EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
          hintTextDirection: TextDirection.rtl,
          hintText: widget.hintText,
          hintStyle: widget.hintStyle ??
              TextStyle(
                color: isFocused
                    ? AppColors.blackTextColor // Hint color when focused
                    : isEnabled
                        ? AppColors.hintTextColor // Hint color when enabled
                        : AppColors.hintTextColor, // Hint color when disabled
              ),
          fillColor: widget.fillColor ?? AppColors.textFieldfillColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0.r)),
          ),
          focusedBorder: widget.focusedBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0.r)),
                borderSide: BorderSide(
                  color:
                      widget.focusdBorderColor ?? AppColors.textFieldfillColor,
                ),
              ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0.r)),
            borderSide: BorderSide(
              color: widget.focusdBorderColor ?? Colors.red,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0.r)),
            borderSide: BorderSide(
              color:
                  widget.enabledBorderSideColor ?? AppColors.textFieldfillColor,
            ),
          ),
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: togglePasswordVisibility,
                  child: SvgPicture.asset(
                    isPasswordVisible
                        ? Assets.svgsInvisibleEye
                        : Assets.svgsEye,
                    fit: BoxFit.scaleDown,
                    colorFilter: ColorFilter.mode(
                      hasError
                          ? Colors.red
                          : isFocused
                              ? AppColors.primaryColor
                              : isEnabled
                                  ? AppColors.hintTextColor
                                  : Colors.grey,
                      BlendMode.srcIn, // Ensures the color is applied correctly
                    ),
                  ),
                )
              : widget.suffixIcon != null
                  ? SvgPicture.asset(
                      widget.suffixIcon!,
                      fit: BoxFit.scaleDown,
                      colorFilter: ColorFilter.mode(
                        hasError
                            ? Colors.red
                            : isFocused
                                ? AppColors.primaryColor
                                : isEnabled
                                    ? AppColors.hintTextColor
                                    : Colors.grey,
                        BlendMode.srcIn,
                      ),
                    )
                  : null,
          prefixIcon: SvgPicture.asset(
            widget.prefixIcon,
            fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(
              hasError
                  ? Colors.red // Red icon when there's an error
                  : isFocused
                      ? AppColors.primaryColor // Icon color when focused
                      : isEnabled
                          ? AppColors.hintTextColor // Icon color when enabled
                          : Colors.grey, // Icon color when disabled
              BlendMode.srcIn, // Ensures the color is applied correctly
            ),
          ),
        ),
      ),
    );
  }
}
