import 'package:damma_project/core/utils/spacing.dart';
import 'package:damma_project/features/home/presentation/views/widgets/home_appbar.dart';
import 'package:damma_project/features/home/presentation/views/widgets/posts_list_view.dart';
import 'package:damma_project/features/home/presentation/views/widgets/what_thinking_section.dart';
import 'package:damma_project/features/home/manager/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeSuccess) {
          return Padding(
            padding: EdgeInsets.only(top: 20.0.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: HomeAppBar(),
                  ),
                  verticalSpace(25),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: WhatThinkingSection(),
                  ),
                  verticalSpace(40),
                  const PostsListView(),
                ],
              ),
            ),
          );
        } else if (state is HomeFailure) {
          return Center(child: Text('خطأ: ${state.message}'));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
