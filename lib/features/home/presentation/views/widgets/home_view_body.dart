import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/features/home/presentation/views/widgets/what_thinking_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/utils/models/user_model.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../manager/home_cubit.dart';
import '../../../manager/news_feed_cubit.dart';
import 'home_appbar.dart';
import 'news_feed_listview.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  Future<void> _saveUserToPreferences(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', user.id as int);
    await prefs.setString('firstName', user.firstName ?? '');
    await prefs.setString('lastName', user.lastName ?? '');
    await prefs.setString('profileImageUrl', user.profileImageUrl ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeSuccess) {
          _saveUserToPreferences(state.user);

          return RefreshIndicator(
            displacement: 10,
            color: AppColors.primaryColor,
            onRefresh: () async {
              await context.read<NewsFeedCubit>().fetchNewsFeed();
            },
            child: ListView(
              padding: EdgeInsets.only(top: 20.0.h),
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
                NewsFeedListView(
                  userModel: state.user,
                ),
              ],
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
