import 'package:damma_project/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class TextButtonProfile extends StatelessWidget {
  const TextButtonProfile({
    super.key,
    required this.text,
    this.onPressed,
  });
  final String text;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text,
          style: AppStyles.styleMedium12
              .copyWith(decoration: TextDecoration.underline)),
    );
  }
}
