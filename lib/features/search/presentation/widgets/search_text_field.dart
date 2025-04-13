import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/features/search/cubit/search_cubit.dart';
import 'package:damma_project/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_styles.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;

  const SearchTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppColors.primaryColor,
      controller: controller,
      onChanged: (query) => context.read<SearchCubit>().search(query),
      style: AppStyles.styleMedium16.copyWith(color: AppColors.blackTextColor),
      decoration: InputDecoration(
        hintText: S.of(context).Search,
        hintStyle: AppStyles.styleMedium16.copyWith(color: Colors.grey),
        filled: true,
        fillColor: AppColors.textFieldfillColor,
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
