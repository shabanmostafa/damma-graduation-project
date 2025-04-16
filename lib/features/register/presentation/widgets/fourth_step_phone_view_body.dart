// import 'package:damma_project/core/utils/assets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../../core/utils/app_colors.dart';
// import '../../../../core/utils/app_styles.dart';
// import '../../../../core/utils/spacing.dart';
// import '../../../../core/utils/widgets/animated_navigation.dart';
// import '../../../../core/utils/widgets/app_text_button.dart';
// import '../../../../core/utils/widgets/app_text_form_field.dart';
// import '../../../../core/utils/widgets/custom_app_bar.dart';
// import '../../../../generated/l10n.dart';
// import '../views/fifth_step_email_view.dart';
// import 'custom_buttom_text.dart';
// import 'custom_register_header.dart';

// class FourthStepPhoneViewBody extends StatefulWidget {
//   const FourthStepPhoneViewBody({super.key});

//   @override
//   State<FourthStepPhoneViewBody> createState() =>
//       _FouurthStepPhoneViewBodyState();
// }

// class _FouurthStepPhoneViewBodyState extends State<FourthStepPhoneViewBody> {
//   final TextEditingController _phoneController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool _isButtonEnabled = false;

//   @override
//   void initState() {
//     super.initState();
//     _phoneController.addListener(_updateButtonState);
//   }

//   void _updateButtonState() {
//     setState(() {
//       _isButtonEnabled = _phoneController.text.isNotEmpty;
//     });
//   }

//   String? fourthStepValidate(String? value) {
//     // Check if the value is null or empty
//     if (value == null || value.isEmpty) {
//       return S.of(context).fieldIsRequired; // Field is required
//     }

//     String phonePattern =
//         r'^(?:\+?\d{1,3}[-\s]?)?(\(?\d{3}\)?[-\s]?)?[\d\s-]{7,15}$';
//     RegExp regExp = RegExp(phonePattern);

//     // Check if the value matches the phone number pattern
//     if (!regExp.hasMatch(value)) {
//       return S
//           .of(context)
//           .pleaseEnterCorrectPhone; // Please enter a valid phone number
//     }

//     return null;
//   }

//   @override
//   void dispose() {
//     _phoneController.dispose();
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
//               pageTitle: S.of(context).whatIsYourPhone,
//             ),
//           ),
//           SliverToBoxAdapter(child: verticalSpace(32)),
//           SliverToBoxAdapter(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   AppTextFormField(
//                     hintText: S.of(context).phone,
//                     prefixIcon: Assets.svgsMobile,
//                     controller: _phoneController,
//                     validator: fourthStepValidate,
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
//                           const FifthStepEmailView(),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/utils/widgets/animated_navigation.dart';
import '../../../../core/utils/widgets/app_text_button.dart';
import '../../../../core/utils/widgets/app_text_form_field.dart';
import '../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../generated/l10n.dart';
import '../../logic/cubits/auth_cubit.dart';
import '../../logic/cubits/auth_state.dart';
import '../views/fifth_step_email_view.dart';
import 'custom_buttom_text.dart';
import 'custom_register_header.dart';

class FourthStepPhoneView extends StatelessWidget {
  const FourthStepPhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(child: FourthStepPhoneViewBody()),
    );
  }
}

class FourthStepPhoneViewBody extends StatefulWidget {
  const FourthStepPhoneViewBody({super.key});

  @override
  State<FourthStepPhoneViewBody> createState() =>
      _FourthStepPhoneViewBodyState();
}

class _FourthStepPhoneViewBodyState extends State<FourthStepPhoneViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = context.read<AuthCubit>();
    _authCubit.signUpPhoneNumber.addListener(_updateState);
  }

  @override
  void dispose() {
    _authCubit.signUpPhoneNumber.removeListener(_updateState);
    super.dispose();
  }

  void _updateState() {
    if (mounted) setState(() {});
  }

  String? phoneValidate(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).fieldIsRequired;
    }

    String phonePattern =
        r'^(?:\+?\d{1,3}[-\s]?)?(\(?\d{3}\)?[-\s]?)?[\d\s-]{7,15}$';
    RegExp regExp = RegExp(phonePattern);

    if (!regExp.hasMatch(value)) {
      return S.of(context).pleaseEnterCorrectPhone;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterDataUpdated) setState(() {});
      },
      builder: (context, state) {
        final isButtonActive = _authCubit.signUpPhoneNumber.text.isNotEmpty;

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
                  pageTitle: S.of(context).whatIsYourPhone,
                ),
              ),
              SliverToBoxAdapter(child: verticalSpace(32)),
              SliverToBoxAdapter(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppTextFormField(
                        hintText: S.of(context).phone,
                        prefixIcon: Assets.svgsMobile,
                        controller: _authCubit.signUpPhoneNumber,
                        validator: phoneValidate,
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: verticalSpace(65)),
              SliverToBoxAdapter(
                child: AppTextButton(
                  buttonText: S.of(context).next,
                  textStyle: AppStyles.styleMedium18,
                  backgroundColor: isButtonActive
                      ? AppColors.primaryColor
                      : AppColors.inactiveButtonColor,
                  onPressed: isButtonActive
                      ? () {
                          if (_formKey.currentState?.validate() ?? false) {
                            AnimatedNavigation.navigateWithSlide(
                              context,
                              const FifthStepEmailView(),
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
