import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/assets.dart' show Assets;
import 'package:damma_project/core/utils/spacing.dart';
import 'package:damma_project/core/utils/widgets/app_text_form_field.dart';
import 'package:damma_project/core/utils/widgets/custom_app_bar.dart';
import 'package:damma_project/core/utils/widgets/custom_snack_bar.dart';
import 'package:damma_project/features/register/logic/cubit/verify_cubit.dart';
import 'package:damma_project/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/routing/routes.dart';
import '../../../../../core/utils/widgets/app_text_button.dart';


class VerifyAccountViewBody extends StatelessWidget {
  VerifyAccountViewBody({super.key});

  final emailController = TextEditingController();
  final verificationCodeController = TextEditingController();
  final GlobalKey<FormState> verifyFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyCubit, VerifyState>(
      listener: (context, state) {
        if (state is VerifySuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: CustomSnackBar(
                icon: Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 24,
                ),
                topSvgColor: Color.fromARGB(255, 19, 128, 64),
                bottomSvgColor: Color.fromARGB(255, 19, 128, 64),
                containerColor: AppColors.primaryColor,
                title: 'رائع!',
                errorText: 'تم تأكيد الحساب بنجاح',
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          );

          Navigator.pushReplacementNamed(context, Routes.loginView);
        } else if (state is VerifyFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomSnackBar(
                icon: const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                topSvgColor: const Color(0xff801336),
                bottomSvgColor: const Color(0xff801336),
                containerColor: const Color(0xffc72c41),
                title: 'خطأ!',
                errorText: state.error,
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: verticalSpace(60)),
              const SliverToBoxAdapter(
                child: CustomAppBar(
                  text: "تاكيد الحساب",
                  needArrow: true,
                ),
              ),
              SliverToBoxAdapter(child: verticalSpace(32)),
              SliverToBoxAdapter(child: SvgPicture.asset(Assets.svgsBlackLogo)),
              SliverToBoxAdapter(child: verticalSpace(40)),
              SliverToBoxAdapter(
                child: Form(
                  key: verifyFormKey,
                  child: Column(
                    children: [
                      AppTextFormField(
                        prefixIcon: Assets.svgsUser,
                        controller: emailController,
                        hintText: S.of(context).email,
                        isPassword: false,
                        validator: (value) => value?.isEmpty ?? true
                            ? 'البريد الالكتروني مطلوب'
                            : null,
                      ),
                      verticalSpace(15),
                      AppTextFormField(
                        prefixIcon: Assets.svgsLock,
                        controller: verificationCodeController,
                        hintText: 'كود التحقق',
                        isPassword: true,
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'كود التحقق مطلوب' : null,
                      ),
                      verticalSpace(32),
                      state is VerifyLoading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                AppColors.primaryColor,
                              ),
                            )
                          : AppTextButton(
                              buttonText: 'تأكيد الحساب',
                              textStyle: AppStyles.styleMedium18
                                  .copyWith(color: AppColors.whiteColor),
                              onPressed: () {
                                if (verifyFormKey.currentState?.validate() ??
                                    false) {
                                  context.read<VerifyCubit>().verify(
                                        emailController.text,
                                        verificationCodeController.text,
                                      );
                                }
                              },
                            ),
                      verticalSpace(16),
                      GestureDetector(
                        onTap: () {
                          if (emailController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: CustomSnackBar(
                                  icon: Icon(
                                    Icons.error_outline,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  topSvgColor: Color(0xff801336),
                                  bottomSvgColor: Color(0xff801336),
                                  containerColor: Color(0xffc72c41),
                                  title: 'خطأ!',
                                  errorText:
                                      'يرجى إدخال البريد الإلكتروني أولاً',
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                            );
                            return;
                          }

                          {
                            context
                                .read<VerifyCubit>()
                                .resendVerificationCode(emailController.text);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: CustomSnackBar(
                                  icon: Icon(
                                    Icons.error_outline,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  topSvgColor: Color.fromARGB(255, 19, 128, 64),
                                  bottomSvgColor:
                                      Color.fromARGB(255, 19, 128, 64),
                                  containerColor: AppColors.primaryColor,
                                  title: '',
                                  errorText: 'تم اعادة ارسال كود التحقق',
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                            );
                          }
                        },
                        child: Text(
                          "إعادة إرسال كود التحقق؟",
                          style: AppStyles.styleMedium14.copyWith(
                            color: AppColors.primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: verticalSpace(20)),
            ],
          ),
        );
      },
    );
  }
}
