import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/features/add_post/presentation/views/add_post_view.dart';
import 'package:damma_project/features/home/manager/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../generated/l10n.dart';

class WhatThinkingBox extends StatelessWidget {
  const WhatThinkingBox({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<HomeCubit>().state is HomeSuccess
        ? (context.read<HomeCubit>().state as HomeSuccess).user
        : null;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (user == null) return;

          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 500),
              pageBuilder: (_, __, ___) => AddPostView(user: user),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.hintTextColor.withOpacity(.25),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            S.of(context).whatDoYouThink,
            style: AppStyles.styleLight12.copyWith(
              color: AppColors.blackTextColor,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }
}
