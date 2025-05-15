import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/widgets/app_text_form_field.dart';

class AppDatePickerField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String svgIconPath;
  final String? Function(String?)? validator;

  const AppDatePickerField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.svgIconPath,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      controller: controller,
      hintText: hintText,
      prefixIcon:svgIconPath,
      onTap: () => _selectDate(context),
      validator: validator,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }
}
