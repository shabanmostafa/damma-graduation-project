// import 'package:damma_project/features/register/presentation/views/fourth_step_phone_view.dart';
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
// import 'custom_buttom_text.dart';
// import 'custom_register_header.dart';

// class SeconedStepDateViewBody extends StatefulWidget {
//   const SeconedStepDateViewBody({super.key});

//   @override
//   State<SeconedStepDateViewBody> createState() =>
//       _SeconedSterpDateViewBodyState();
// }

// class _SeconedSterpDateViewBodyState extends State<SeconedStepDateViewBody> {
//   final TextEditingController _dateController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool _isButtonEnabled = false;

//   @override
//   void initState() {
//     super.initState();
//     _dateController.addListener(_updateButtonState);
//   }

//   void _updateButtonState() {
//     setState(() {
//       _isButtonEnabled = _dateController.text.isNotEmpty;
//     });
//   }

//   String? seonedStepValidte(String? value) {
//     if (value == null || value.isEmpty) {
//       return S.of(context).fieldIsRequired;
//     }
//     return null;
//   }

//   @override
//   void dispose() {
//     _dateController.dispose();
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
//               pageTitle: S.of(context).whatIsYourType,
//             ),
//           ),
//           SliverToBoxAdapter(child: verticalSpace(32)),
//           SliverToBoxAdapter(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   AppTextFormField(
//                     hintText: S.of(context).whatIsYourType,
//                     prefixIcon: Assets.svgsCalendarMonth,
//                     controller: _dateController,
//                     validator: seonedStepValidte,
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
//                           const FourthStepPhoneView(),
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

import 'package:damma_project/features/register/presentation/views/widgets/sixth_step_password_view_body.dart';
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
import 'custom_buttom_text.dart';
import 'custom_register_header.dart';

class SeconedStepDateView extends StatelessWidget {
  const SeconedStepDateView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(child: SeconedStepDateViewBody()),
    );
  }
}

class SeconedStepDateViewBody extends StatefulWidget {
  const SeconedStepDateViewBody({super.key});

  @override
  State<SeconedStepDateViewBody> createState() =>
      _SeconedSterpDateViewBodyState();
}

class _SeconedSterpDateViewBodyState extends State<SeconedStepDateViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final AuthCubit _authCubit;
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authCubit = context.read<AuthCubit>();
    _dateController.addListener(_updateState);

    // Initialize with existing value if available
    if (_authCubit.signUpGender.text.isNotEmpty) {
      _dateController.text = _authCubit.signUpGender.text;
    }
  }

  @override
  void dispose() {
    _dateController.removeListener(_updateState);
    _dateController.dispose();
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
        final isButtonActive = _dateController.text.isNotEmpty;

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
                  pageTitle: S.of(context).whatIsYourType,
                ),
              ),
              SliverToBoxAdapter(child: verticalSpace(32)),
              SliverToBoxAdapter(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppTextFormField(
                        hintText: S.of(context).whatIsYourType,
                        prefixIcon: Assets.svgsProfile,
                        controller: _dateController,
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
                            _authCubit.updateRegistrationData(
                              gender: _dateController.text,
                            );
                            AnimatedNavigation.navigateWithSlide(
                              context,
                              const SixthStepPasswordView(),
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
