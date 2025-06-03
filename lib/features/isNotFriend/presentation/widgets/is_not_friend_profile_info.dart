import 'package:damma_project/core/utils/models/user_model.dart';
import 'package:damma_project/features/isNotFriend/manager/friend_cubit.dart';
import 'package:damma_project/features/isNotFriend/manager/friend_state.dart';
import 'package:damma_project/features/profile/manager/cubit/profile_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/utils/widgets/app_text_button.dart';

class IsNotFriendProfileInfo extends StatelessWidget {
  final UserModel profile;

  const IsNotFriendProfileInfo(this.profile, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FriendCubit, FriendState>(
      listener: (context, state) {
        if (state is FriendRequestSentSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم إرسال طلب الصداقة بنجاح')),
          );
          // Refresh profile data (Recommendation 2)
          context.read<ProfileCubit>().getProfile(profile.id!);
        } else if (state is FriendFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  state.error), // Will now show "تم ارسال طلب الصداقة مسبقا"
              backgroundColor: AppColors.red500Color,
            ),
          );
        }
      },
      builder: (context, state) {
        final isRequestSent = state is FriendRequestSentSuccess;
        final isLoading = state is FriendLoading;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${profile.firstName ?? ''} ${profile.lastName ?? ''}',
                        style: AppStyles.styleBold18),
                    SizedBox(height: 4.h),
                    Text(profile.dateOfBirth ?? '',
                        style: AppStyles.styleMedium14
                            .copyWith(color: AppColors.blackTextColor)),
                  ],
                ),
              ),
              verticalSpace(5),
              SizedBox(height: 20.h),

              AppTextButton(
                onPressed: () {
                  if (!isLoading && !isRequestSent && profile.id != null) {
                    context.read<FriendCubit>().sendFriendRequest(profile.id!);
                  }
                },
                  backgroundColor: AppColors.primaryColor,
                  borderRadius: 10.r,
                  buttonWidth: 343.w,
                  buttonHeight: 40.h,
                  buttonText: isRequestSent ? 'تم ارسال طلب الصداقة' : 'اضافة صديق',
                  textStyle: AppStyles.styleMedium14
                      .copyWith(color: AppColors.whiteColor),


              ),
              SizedBox(height: 20.h),
              Divider(
                  color: AppColors.inactiveButtonColor, thickness: 8, height: 10.h),
            ],
          ),
        );
      },
    );
  }
}

