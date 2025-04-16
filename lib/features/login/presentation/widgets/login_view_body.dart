import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/routing/routes.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/utils/widgets/app_text_button.dart';
import '../../../../core/utils/widgets/app_text_form_field.dart';
import '../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../core/utils/widgets/custom_snack_bar.dart';
import '../../../../generated/l10n.dart';
import '../../../register/logic/cubits/auth_cubit.dart';
import '../../../register/logic/cubits/auth_state.dart';
import 'custom_bottom_button.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
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
                title: 'Great!',
                errorText: 'Login Successfully',
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.homeView,
            (route) => false,
          );
        } else if (state is SignInFailure) {
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
                title: 'Error!',
                errorText: state.errorMessage,
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          );
        }
      },
      builder: (context, state) {
        final authCubit = context.read<AuthCubit>();

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: verticalSpace(60)),
              SliverToBoxAdapter(
                child: CustomAppBar(
                  text: S.of(context).login,
                  needArrow: false,
                ),
              ),
              SliverToBoxAdapter(child: verticalSpace(32)),
              SliverToBoxAdapter(child: SvgPicture.asset(Assets.svgsBlackLogo)),
              SliverToBoxAdapter(child: verticalSpace(40)),
              SliverToBoxAdapter(
                child: Form(
                  key: authCubit.signInFormKey,
                  child: Column(
                    children: [
                      AppTextFormField(
                        prefixIcon: Assets.svgsUser,
                        controller: authCubit.signInEmail,
                        hintText: S.of(context).email,
                        isPassword: false,
                      ),
                      verticalSpace(15),
                      AppTextFormField(
                        prefixIcon: Assets.svgsLock,
                        controller: authCubit.signInPassword,
                        hintText: S.of(context).password,
                        isPassword: true,
                      ),
                      verticalSpace(32),
                      state is SignInLoading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                AppColors.primaryColor,
                              ),
                            )
                          : AppTextButton(
                              buttonText: S.of(context).login,
                              textStyle: AppStyles.styleMedium18
                                  .copyWith(color: AppColors.whiteColor),
                              onPressed: () {
                                if (authCubit.signInFormKey.currentState
                                        ?.validate() ??
                                    false) {
                                  authCubit.signIn();
                                }
                              },
                            ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: verticalSpace(20)),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: CustomButtomButton(
                      text: S.of(context).createAccount,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.firstStepYourNameView,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
