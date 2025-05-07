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
// import '../views/seconed_step_date_view.dart';
// import 'custom_buttom_text.dart';
// import 'custom_register_header.dart';

// class FirstSterpYourNameViewBody extends StatefulWidget {
//   const FirstSterpYourNameViewBody({super.key});

//   @override
//   State<FirstSterpYourNameViewBody> createState() =>
//       _FirstSterpYourNameViewBodyState();
// }

// class _FirstSterpYourNameViewBodyState
//     extends State<FirstSterpYourNameViewBody> {
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _seconedNameController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool _isButtonEnabled = false;

//   @override
//   void initState() {
//     super.initState();
//     _firstNameController.addListener(_updateButtonState);
//     //_seconedNameController.addListener(_updateButtonState);
//   }

//   void _updateButtonState() {
//     setState(() {
//       _isButtonEnabled = _firstNameController.text.isNotEmpty;
//       // _isButtonEnabled = _firstNameController.text.isNotEmpty &&
//       //     _seconedNameController.text.isNotEmpty;
//     });
//   }

//   String? firstStepValidte(String? value) {
//     if (value == null || value.isEmpty) {
//       return S.of(context).fieldIsRequired;
//     }
//     return null;
//   }

//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     //_seconedNameController.dispose();
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
//               pageTitle: S.of(context).whatIsYourName,
//             ),
//           ),
//           SliverToBoxAdapter(child: verticalSpace(32)),
//           SliverToBoxAdapter(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   AppTextFormField(
//                     hintText: S.of(context).firstName,
//                     prefixIcon: Assets.svgsUser,
//                     controller: _firstNameController,
//                     validator: firstStepValidte,
//                   ),
//                   // verticalSpace(25),
//                   // AppTextFormField(
//                   //   hintText: S.of(context).seconedName,
//                   //   prefixIcon: Assets.svgsUser,
//                   //   controller: _seconedNameController,
//                   //   validator: firstStepValidte,
//                   // ),
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
//                           const SeconedStepDateView(),
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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/utils/widgets/animated_navigation.dart';
import '../../../../../core/utils/widgets/app_text_button.dart';
import '../../../../../core/utils/widgets/app_text_form_field.dart';
import '../../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../../generated/l10n.dart';
import '../../../logic/cubits/auth_cubit.dart';
import '../../../logic/cubits/auth_state.dart';
import '../seconed_step_date_view.dart';
import 'custom_buttom_text.dart';
import 'custom_register_header.dart';

class FirstStepYourNameView extends StatelessWidget {
  const FirstStepYourNameView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(child: FirstSterpYourNameViewBody()),
    );
  }
}

class FirstSterpYourNameViewBody extends StatefulWidget {
  const FirstSterpYourNameViewBody({super.key});

  @override
  State<FirstSterpYourNameViewBody> createState() =>
      _FirstSterpYourNameViewBodyState();
}

class _FirstSterpYourNameViewBodyState
    extends State<FirstSterpYourNameViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = context.read<AuthCubit>();
    _authCubit.signUpName.addListener(_updateState);
  }

  @override
  void dispose() {
    _authCubit.signUpName.removeListener(_updateState);
    super.dispose();
  }

  void _updateState() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterDataUpdated) setState(() {});
      },
      builder: (context, state) {
        final isButtonActive = _authCubit.signUpName.text.isNotEmpty;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: verticalSpace(60)),
              SliverToBoxAdapter(
                child: CustomAppBar(text: S.of(context).createAccount),
              ),
              SliverToBoxAdapter(child: verticalSpace(41)),
              SliverToBoxAdapter(
                child: CustomRegisterHeader(
                  pageTitle: S.of(context).whatIsYourName,
                ),
              ),
              SliverToBoxAdapter(child: verticalSpace(32)),
              SliverToBoxAdapter(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppTextFormField(
                        hintText: S.of(context).firstName,
                        prefixIcon: Assets.svgsUser,
                        controller: _authCubit.signUpName,
                        validator: (value) => value?.isEmpty ?? true
                            ? S.of(context).fieldIsRequired
                            : null,
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
                              const SeconedStepDateView(),
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
