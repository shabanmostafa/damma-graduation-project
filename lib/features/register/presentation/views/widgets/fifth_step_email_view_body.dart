// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../../core/utils/app_colors.dart';
// import '../../../../core/utils/app_styles.dart';
// import '../../../../core/utils/assets.dart';
// import '../../../../core/utils/spacing.dart';
// import '../../../../core/utils/widgets/animated_navigation.dart';
// import '../../../../core/utils/widgets/app_text_button.dart';
// import '../../../../core/utils/widgets/app_text_form_field.dart';
// import '../../../../core/utils/widgets/custom_app_bar.dart';
// import '../../../../generated/l10n.dart';
// import '../views/six_step_password_view.dart';
// import 'custom_buttom_text.dart';
// import 'custom_register_header.dart';

// class FifthStepEmailViewBody extends StatefulWidget {
//   const FifthStepEmailViewBody({super.key});

//   @override
//   State<FifthStepEmailViewBody> createState() => _FifthStepEmailViewBodyState();
// }

// class _FifthStepEmailViewBodyState extends State<FifthStepEmailViewBody> {
//   final TextEditingController _emailController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool _isButtonEnabled = false;

//   @override
//   void initState() {
//     super.initState();
//     _emailController.addListener(_updateButtonState);
//   }

//   void _updateButtonState() {
//     setState(() {
//       _isButtonEnabled = _emailController.text.isNotEmpty;
//     });
//   }

//   String? fifthStepValidte(String? value) {
//     // Check if the value is null or empty
//     if (value == null || value.isEmpty) {
//       return S.of(context).fieldIsRequired;
//     }

//     // Regular expression for basic email validation
//     String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
//     RegExp regExp = RegExp(emailPattern);

//     // Check if the value matches the email pattern
//     if (!regExp.hasMatch(value)) {
//       return S.of(context).pleaseEnterCorrectEmail;
//     }

//     return null;
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.0.w),
//       child: CustomScrollView(
//         physics: const NeverScrollableScrollPhysics(),
//         slivers: [
//           SliverToBoxAdapter(child: verticalSpace(60)),
//           SliverToBoxAdapter(
//             child: CustomAppBar(
//               text: S.of(context).createAccount,
//             ),
//           ),
//           SliverToBoxAdapter(child: verticalSpace(41)),
//           SliverToBoxAdapter(
//             child: CustomRegisterHeader(
//               pageTitle: S.of(context).whatIsYourEmail,
//             ),
//           ),
//           SliverToBoxAdapter(child: verticalSpace(32)),
//           SliverToBoxAdapter(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   AppTextFormField(
//                     hintText: S.of(context).email,
//                     prefixIcon: Assets.svgsMail,
//                     controller: _emailController,
//                     validator: fifthStepValidte,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(child: verticalSpace(65)),
//           SliverToBoxAdapter(
//             child: AppTextButton(
//               buttonText: S.of(context).next,
//               textStyle: AppStyles.styleMedium18,
//               backgroundColor: _isButtonEnabled
//                   ? AppColors.primaryColor
//                   : AppColors.inactiveButtonColor,
//               onPressed: _isButtonEnabled
//                   ? () {
//                       if (_formKey.currentState?.validate() ?? false) {
//                         AnimatedNavigation.navigateWithSlide(
//                           context,
//                           const SixStepPasswordView(),
//                         );
//                       }
//                     }
//                   : () {},
//             ),
//           ),
//           const SliverFillRemaining(
//               hasScrollBody: false, child: CustomBottomText()),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../core/utils/app_colors.dart';
// import '../../../../core/utils/app_styles.dart';
// import '../../../../core/utils/assets.dart';
// import '../../../../core/utils/spacing.dart';
// import '../../../../core/utils/widgets/animated_navigation.dart';
// import '../../../../core/utils/widgets/app_text_button.dart';
// import '../../../../core/utils/widgets/app_text_form_field.dart';
// import '../../../../core/utils/widgets/custom_app_bar.dart';
// import '../../../../generated/l10n.dart';
// import '../../logic/cubits/auth_cubit.dart';
// import '../../logic/cubits/auth_state.dart';
// import '../views/six_step_password_view.dart';
// import 'custom_buttom_text.dart';
// import 'custom_register_header.dart';

// class FifthStepEmailView extends StatelessWidget {
//   const FifthStepEmailView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       body: SafeArea(child: FifthStepEmailViewBody()),
//     );
//   }
// }

// class FifthStepEmailViewBody extends StatefulWidget {
//   const FifthStepEmailViewBody({super.key});

//   @override
//   State<FifthStepEmailViewBody> createState() => _FifthStepEmailViewBodyState();
// }

// class _FifthStepEmailViewBodyState extends State<FifthStepEmailViewBody> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   late final AuthCubit _authCubit;

//   @override
//   void initState() {
//     super.initState();
//     _authCubit = context.read<AuthCubit>();
//     _authCubit.signUpEmail.addListener(_updateState);
//   }

//   @override
//   void dispose() {
//     _authCubit.signUpEmail.removeListener(_updateState);
//     super.dispose();
//   }

//   void _updateState() {
//     if (mounted) setState(() {});
//   }

//   String? emailValidate(String? value) {
//     if (value == null || value.isEmpty) {
//       return S.of(context).fieldIsRequired;
//     }

//     String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
//     RegExp regExp = RegExp(emailPattern);

//     if (!regExp.hasMatch(value)) {
//       return S.of(context).pleaseEnterCorrectEmail;
//     }

//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthCubit, AuthState>(
//       listener: (context, state) {
//         if (state is RegisterDataUpdated) setState(() {});
//       },
//       builder: (context, state) {
//         final isButtonActive = _authCubit.signUpEmail.text.isNotEmpty;

//         return Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.0.w),
//           child: CustomScrollView(
//             physics: const NeverScrollableScrollPhysics(),
//             slivers: [
//               SliverToBoxAdapter(child: verticalSpace(60)),
//               SliverToBoxAdapter(
//                 child: CustomAppBar(
//                   text: S.of(context).createAccount,
//                 ),
//               ),
//               SliverToBoxAdapter(child: verticalSpace(41)),
//               SliverToBoxAdapter(
//                 child: CustomRegisterHeader(
//                   pageTitle: S.of(context).whatIsYourEmail,
//                 ),
//               ),
//               SliverToBoxAdapter(child: verticalSpace(32)),
//               SliverToBoxAdapter(
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       AppTextFormField(
//                         hintText: S.of(context).email,
//                         prefixIcon: Assets.svgsMail,
//                         controller: _authCubit.signUpEmail,
//                         validator: emailValidate,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SliverToBoxAdapter(child: verticalSpace(65)),
//               SliverToBoxAdapter(
//                 child: AppTextButton(
//                   buttonText: S.of(context).next,
//                   textStyle: AppStyles.styleMedium18,
//                   backgroundColor: isButtonActive
//                       ? AppColors.primaryColor
//                       : AppColors.inactiveButtonColor,
//                   onPressed: isButtonActive
//                       ? () {
//                           if (_formKey.currentState?.validate() ?? false) {
//                             AnimatedNavigation.navigateWithSlide(
//                               context,
//                               const SixStepPasswordView(),
//                             );
//                           }
//                         }
//                       : () {},
//                 ),
//               ),
//               const SliverFillRemaining(
//                 hasScrollBody: false,
//                 child: CustomBottomText(),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/utils/widgets/animated_navigation.dart';
import '../../../../../core/utils/widgets/app_text_button.dart';
import '../../../../../core/utils/widgets/app_text_form_field.dart';
import '../../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../../core/utils/widgets/custom_snack_bar.dart';
import '../../../../../generated/l10n.dart';
import '../../../logic/cubits/auth_cubit.dart';
import '../../../logic/cubits/auth_state.dart';
import '../six_step_password_view.dart';
import 'custom_buttom_text.dart';
import 'custom_register_header.dart';

class FifthStepEmailView extends StatelessWidget {
  const FifthStepEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(child: FifthStepEmailViewBody()),
    );
  }
}

class FifthStepEmailViewBody extends StatefulWidget {
  const FifthStepEmailViewBody({super.key});

  @override
  State<FifthStepEmailViewBody> createState() => _FifthStepEmailViewBodyState();
}

class _FifthStepEmailViewBodyState extends State<FifthStepEmailViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = context.read<AuthCubit>();
    _authCubit.signUpEmail.addListener(_updateState);
  }

  @override
  void dispose() {
    _authCubit.signUpEmail.removeListener(_updateState);
    super.dispose();
  }

  void _updateState() {
    if (mounted) setState(() {});
  }

  String? emailValidate(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).fieldIsRequired;
    }

    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(emailPattern);

    if (!regExp.hasMatch(value)) {
      return S.of(context).pleaseEnterCorrectEmail;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterDataUpdated) {
          setState(() {});
        } else if (state is SignUpFailure) {
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
        final isButtonActive = _authCubit.signUpEmail.text.isNotEmpty;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: verticalSpace(60)),
              SliverToBoxAdapter(
                child: CustomAppBar(
                  text: S.of(context).createAccount,
                ),
              ),
              SliverToBoxAdapter(child: verticalSpace(41)),
              SliverToBoxAdapter(
                child: CustomRegisterHeader(
                  pageTitle: S.of(context).whatIsYourEmail,
                ),
              ),
              SliverToBoxAdapter(child: verticalSpace(32)),
              SliverToBoxAdapter(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppTextFormField(
                        hintText: S.of(context).email,
                        prefixIcon: Assets.svgsMail,
                        controller: _authCubit.signUpEmail,
                        validator: emailValidate,
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: verticalSpace(65)),
              SliverToBoxAdapter(
                child: state is SignUpLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          AppColors.primaryColor,
                        ),
                      )
                    : AppTextButton(
                        buttonText: S.of(context).next,
                        textStyle: AppStyles.styleMedium18,
                        backgroundColor: isButtonActive
                            ? AppColors.primaryColor
                            : AppColors.inactiveButtonColor,
                        onPressed: isButtonActive
                            ? () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  AnimatedNavigation.navigateWithSlide(
                                    context,
                                    const SixStepPasswordView(),
                                  );
                                }
                              }
                            : () {},
                      ),
              ),
              const SliverFillRemaining(
                hasScrollBody: false,
                child: CustomBottomText(),
              ),
            ],
          ),
        );
      },
    );
  }
}
