import 'package:damma_project/core/utils/routing/routes.dart';
import 'package:damma_project/core/utils/widgets/app_text_button.dart';
import 'package:damma_project/core/utils/widgets/app_text_form_field.dart';
import 'package:damma_project/core/utils/widgets/custom_app_bar.dart';
import 'package:damma_project/core/utils/widgets/full_screen_image_view.dart';
import 'package:damma_project/core/utils/widgets/green_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/assets.dart';
import 'package:damma_project/core/utils/spacing.dart';
import 'package:damma_project/features/profile/manager/cubit/profile_cubit.dart';
import 'package:damma_project/features/profile/manager/cubit/profile_states.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const String baseUrl = 'http://dama.runasp.net';

class UpdateProfileViewBody extends StatelessWidget {
  const UpdateProfileViewBody({super.key});

  String? getFullImageUrl(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) return null;

    if (imageUrl.startsWith('http')) {
      return imageUrl;
    } else if (imageUrl.startsWith('/')) {
      return '$baseUrl$imageUrl';
    } else if (imageUrl.startsWith('file://')) {
      return null;
    } else {
      return '$baseUrl/$imageUrl';
    }
  }

  void _showUpdateFirstNameBottomSheet(
      BuildContext context, String currentFirstName) {
    final firstNameController = TextEditingController(text: currentFirstName);

    showModalBottomSheet(
      backgroundColor: AppColors.whiteColor,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 24.h,
            bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom + 16.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextFormField(
                hintText: 'الاسم الأول',
                isPassword: false,
                controller: firstNameController,
                iconColor: AppColors.blackTextColor,
                prefixIcon: Assets.svgsUser,
              ),
              verticalSpace(20.h),
              AppTextButton(
                buttonHeight: 48.h,
                horizontalPadding: 24.w,
                verticalPadding: 12.h,
                buttonText: 'تغيير',
                textStyle: AppStyles.styleMedium16,
                onPressed: () {
                  final cubit = BlocProvider.of<ProfileCubit>(context);
                  cubit.updateFirstName(firstNameController.text);
                  Navigator.pop(bottomSheetContext);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showUpdateLastNameBottomSheet(
      BuildContext context, String currentLastName) {
    final lastNameController = TextEditingController(text: currentLastName);

    showModalBottomSheet(
      backgroundColor: AppColors.whiteColor,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 24.h,
            bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom + 16.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextFormField(
                hintText: 'الاسم الأخير',
                isPassword: false,
                controller: lastNameController,
                iconColor: AppColors.blackTextColor,
                prefixIcon: Assets.svgsUser,
              ),
              verticalSpace(20.h),
              AppTextButton(
                buttonHeight: 48.h,
                horizontalPadding: 24.w,
                verticalPadding: 12.h,
                buttonText: 'تغيير',
                textStyle: AppStyles.styleMedium16,
                onPressed: () {
                  final cubit = BlocProvider.of<ProfileCubit>(context);
                  cubit.updateLastName(lastNameController.text);
                  Navigator.pop(bottomSheetContext);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showResetPasswordBottomSheet(BuildContext context) {
    final newPasswordController = TextEditingController();
    final verificationCodeController = TextEditingController();

    showModalBottomSheet(
      backgroundColor: AppColors.whiteColor,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 24.h,
            bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom + 16.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextFormField(
                hintText: 'كلمة المرور الجديدة',
                isPassword: true,
                controller: newPasswordController,
                iconColor: AppColors.blackTextColor,
                prefixIcon: Assets.svgsLock,
              ),
              verticalSpace(20.h),
              AppTextFormField(
                hintText: 'رمز التحقق',
                isPassword: false,
                controller: verificationCodeController,
                iconColor: AppColors.blackTextColor,
                prefixIcon: Assets.svgsLock,
              ),
              verticalSpace(20.h),
              AppTextButton(
                buttonHeight: 48.h,
                horizontalPadding: 24.w,
                verticalPadding: 12.h,
                buttonText: 'تغيير',
                textStyle: AppStyles.styleMedium16,
                onPressed: () async {
                  final cubit = context.read<ProfileCubit>();
                  final success = await cubit.resetPassword(
                    newPasswordController.text.trim(),
                    verificationCodeController.text.trim(),
                  );
                  if (success) {
                    Navigator.pop(bottomSheetContext);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('تم تغيير كلمة المرور بنجاح')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('فشل في تغيير كلمة المرور')),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ));
        } else if (state is ProfileSuccess) {
          final user = state.profile;

          final profileImageUrl = getFullImageUrl(user.profileImageUrl);
          final coverImageUrl = getFullImageUrl(user.coverImageUrl);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const CustomAppBar(
                          text: 'تعديل الصفحة الشخصية',
                          needArrow: true,
                        ),
                        verticalSpace(10),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Cover Image
                            Stack(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 220.h,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (coverImageUrl != null) {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (_) => FullScreenImageView(
                                              imageUrl: coverImageUrl),
                                        ));
                                      } else {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (_) =>
                                              const FullScreenImageView(
                                            imageProvider: AssetImage(
                                                'assets/images/cover_placeholder.jpg'),
                                          ),
                                        ));
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        image: DecorationImage(
                                          image: coverImageUrl != null
                                              ? NetworkImage(coverImageUrl)
                                              : const AssetImage(
                                                      'assets/images/cover_placeholder.jpg')
                                                  as ImageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 12,
                                  right: 12,
                                  child: GestureDetector(
                                    onTap: () async {
                                      final picker = ImagePicker();
                                      final pickedFile = await picker.pickImage(
                                          source: ImageSource.gallery);
                                      if (pickedFile != null) {
                                        final cubit =
                                            context.read<ProfileCubit>();
                                        await cubit
                                            .updateCoverImage(pickedFile.path);
                                      }
                                    },
                                    child: CircleAvatar(
                                      radius: 20.r,
                                      backgroundColor:
                                          Colors.black.withOpacity(0.4),
                                      child: const Icon(Icons.camera_alt,
                                          color: Colors.white, size: 20),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Profile Image
                            Positioned(
                              bottom: -40.h,
                              left: (MediaQuery.of(context).size.width / 2) -
                                  60.r,
                              child: Stack(
                                alignment: Alignment.center,
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                    top: -6,
                                    child: CircleAvatar(
                                      radius: 65.r,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (profileImageUrl != null) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => FullScreenImageView(
                                                imageUrl: profileImageUrl),
                                          ),
                                        );
                                      } else {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const FullScreenImageView(
                                                    imageProvider: AssetImage(
                                                        'assets/images/profile_placeholder.png')),
                                          ),
                                        );
                                      }
                                    },
                                    child: CircleAvatar(
                                      radius: 60.r,
                                      backgroundImage: profileImageUrl != null
                                          ? NetworkImage(profileImageUrl)
                                          : const AssetImage(
                                                  'assets/images/profile_placeholder.png')
                                              as ImageProvider,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 8,
                                    right: 4,
                                    child: GestureDetector(
                                      onTap: () async {
                                        final picker = ImagePicker();
                                        final pickedFile =
                                            await picker.pickImage(
                                                source: ImageSource.gallery);
                                        if (pickedFile != null) {
                                          final cubit =
                                              context.read<ProfileCubit>();
                                          await cubit.updateProfileImage(
                                              pickedFile.path);
                                        }
                                      },
                                      child: CircleAvatar(
                                        radius: 16.r,
                                        backgroundColor:
                                            Colors.black.withOpacity(0.4),
                                        child: const Icon(Icons.camera_alt,
                                            color: Colors.white, size: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 70.h), // Space for profile image
                        GestureDetector(
                          onTap: () => _showUpdateFirstNameBottomSheet(
                              context, user.firstName ?? ''),
                          child: AbsorbPointer(
                            child: AppTextFormField(
                              prefixIcon: Assets.svgsUser,
                              hintText: user.firstName ?? '',
                              hintStyle: AppStyles.styleMedium14,
                              iconColor: AppColors.blackTextColor,
                              isPassword: false,
                              isEnabled: false,
                            ),
                          ),
                        ),
                        verticalSpace(20.h),
                        GestureDetector(
                          onTap: () => _showUpdateLastNameBottomSheet(
                              context, user.lastName ?? ''),
                          child: AbsorbPointer(
                            child: AppTextFormField(
                              prefixIcon: Assets.svgsUser,
                              hintText: user.lastName ?? '',
                              hintStyle: AppStyles.styleMedium14,
                              iconColor: AppColors.blackTextColor,
                              isPassword: false,
                              isEnabled: false,
                            ),
                          ),
                        ),
                        verticalSpace(20.h),
                        GestureDetector(
                          onTap: () async {
                            final cubit = context.read<ProfileCubit>();
                            final result = await cubit.getVerificationCode();
                            if (result) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'تم إرسال رمز التحقق إلى بريدك الإلكتروني')),
                              );

                              _showResetPasswordBottomSheet(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('فشل في إرسال رمز التحقق')),
                              );
                            }
                          },
                          child: AbsorbPointer(
                            child: AppTextFormField(
                              prefixIcon: Assets.svgsLock,
                              hintText: 'إعادة تعيين كلمة المرور',
                              hintStyle: AppStyles.styleMedium14,
                              iconColor: AppColors.blackTextColor,
                              isPassword: false,
                              isEnabled: false,
                            ),
                          ),
                        ),
                        verticalSpace(30.h),
                      ],
                    ),
                  ),
                ),

                // Fixed Bottom Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AppTextButton(
                        buttonText: 'تسجيل الخروج',
                        textStyle: AppStyles.styleMedium16,
                        onPressed: () async {
                          final cubit = context.read<ProfileCubit>();
                          await cubit.logout();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.loginView,
                            (Route<dynamic> route) => false,
                          );
                          showCustomSnackBar(context, 'تم تسجيل الخروج بنجاح');
                        },
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: AppTextButton(
                        backgroundColor: AppColors.red500Color,
                        buttonText: 'حذف الحساب',
                        textStyle: AppStyles.styleMedium16,
                        onPressed: () async {
                          final cubit = context.read<ProfileCubit>();
                          await cubit.deleteAccount();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.welcomeView,
                            (Route<dynamic> route) => false,
                          );
                          showCustomSnackBar(context, 'تم حذف الحساب بنجاح');
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),
              ],
            ),
          );
        } else if (state is ProfileFailure) {
          return Center(child: Text('خطأ: ${state.error}'));
        }

        return const SizedBox.shrink();
      },
    );
  }
}
