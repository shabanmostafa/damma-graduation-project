import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/routing/routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/utils/widgets/app_text_button.dart';
import '../../../../../core/utils/widgets/app_text_form_field.dart';
import '../../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../../core/utils/widgets/custom_snack_bar.dart';
import '../../../../../generated/l10n.dart';
import '../../../logic/cubits/auth_cubit.dart';
import '../../../logic/cubits/auth_state.dart';
import 'custom_buttom_text.dart';
import 'custom_register_header.dart';

class SixthStepPasswordView extends StatelessWidget {
  const SixthStepPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(child: SixthStepPasswordViewBody()),
    );
  }
}

class SixthStepPasswordViewBody extends StatefulWidget {
  const SixthStepPasswordViewBody({super.key});

  @override
  State<SixthStepPasswordViewBody> createState() =>
      _SixthStepPasswordViewState();
}

class _SixthStepPasswordViewState extends State<SixthStepPasswordViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = context.read<AuthCubit>();
    _authCubit.signUpPassword.addListener(_updateState);
    _authCubit.confirmPassword.addListener(_updateState);
  }

  @override
  void dispose() {
    _authCubit.signUpPassword.removeListener(_updateState);
    _authCubit.confirmPassword.removeListener(_updateState);
    super.dispose();
  }

  void _updateState() {
    if (mounted) setState(() {});
  }

  String? passwordValidate(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).fieldIsRequired;
    }
    String passwordPattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
    RegExp regExp = RegExp(passwordPattern);
    if (!regExp.hasMatch(value)) {
      return S.of(context).passwordValidation;
    }
    return null;
  }

  String? confirmPasswordValidate(String? value, String password) {
    if (value == null || value.isEmpty) {
      return S.of(context).PasswordConfirmatiomFieldRequired;
    }
    if (value != password) {
      return S.of(context).passwordNotTheSame;
    }
    return null;
  }

  String? emailValidate(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).fieldIsRequired;
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return S.of(context).enterValidEmail;
    }
    return null;
  }

  String? phoneValidate(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).fieldIsRequired;
    }
    final phoneRegex = RegExp(r'^\d{10,15}$');
    if (!phoneRegex.hasMatch(value)) {
      return S.of(context).enterValidPhoneNumber;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterDataUpdated) setState(() {});
        if (state is SignUpSuccess) {
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
                errorText: 'تم إنشاء حسابك بنجاح',
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          );
          Navigator.pushReplacementNamed(context, Routes.loginView);
          _authCubit.clearRegistrationData();
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
                title: 'خطأ',
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
        final isButtonActive = _authCubit.signUpPassword.text.isNotEmpty &&
            _authCubit.confirmPassword.text.isNotEmpty &&
            _authCubit.signUpEmail.text.isNotEmpty &&
            _authCubit.signUpPhoneNumber.text.isNotEmpty;

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
                  pageTitle: S.of(context).conntinueRegisterSteps,
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
                      verticalSpace(25),
                      AppTextFormField(
                        hintText: S.of(context).email,
                        prefixIcon: Assets.svgsMail,
                        controller: _authCubit.signUpEmail,
                        validator: emailValidate,
                      ),
                      verticalSpace(25),
                      AppTextFormField(
                        hintText: S.of(context).createPassword,
                        prefixIcon: Assets.svgsLock,
                        controller: _authCubit.signUpPassword,
                        isPassword: true,
                        validator: passwordValidate,
                      ),
                      verticalSpace(25),
                      AppTextFormField(
                        hintText: S.of(context).passwordConfirmation,
                        isPassword: true,
                        prefixIcon: Assets.svgsLock,
                        controller: _authCubit.confirmPassword,
                        validator: (value) => confirmPasswordValidate(
                            value, _authCubit.signUpPassword.text),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: verticalSpace(65)),
              SliverToBoxAdapter(
                child: state is SignUpLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ))
                    : AppTextButton(
                        buttonText: S.of(context).createAccount,
                        textStyle: AppStyles.styleMedium18,
                        backgroundColor: isButtonActive
                            ? AppColors.primaryColor
                            : AppColors.inactiveButtonColor,
                        onPressed: isButtonActive
                            ? () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  _authCubit.register();
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
