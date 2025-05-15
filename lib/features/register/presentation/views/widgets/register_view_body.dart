import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/routing/routes.dart';
import 'package:damma_project/core/utils/spacing.dart';
import 'package:damma_project/core/utils/widgets/app_text_button.dart';
import 'package:damma_project/core/utils/widgets/custom_snack_bar.dart';
import 'package:damma_project/features/register/logic/cubit/register_cubit.dart';
import 'package:damma_project/features/register/presentation/functions/handle_registeration.dart';
import 'package:damma_project/features/register/presentation/views/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/widgets/app_text_form_field.dart';
import '../../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../../generated/l10n.dart';
import '../../functions/convert_arabic_to_english_number.dart';
import '../../functions/validators.dart';



class RegisterViewBody extends StatelessWidget {
  RegisterViewBody({
    super.key,
    required this.profileImagePath,
    required this.coverImagePath,
    required this.onProfileImagePicked,
    required this.onCoverImagePicked,
  });

  final String? profileImagePath;
  final String? coverImagePath;
  final void Function(String path) onProfileImagePicked;
  final void Function(String path) onCoverImagePicked;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final phoneController = TextEditingController();

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  Future<void> _pickImage(void Function(String path) onImageSelected) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      onImageSelected(picked.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
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
                errorText: 'الرجاء تأكيد الحساب',
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          );

          Navigator.pushReplacementNamed(context, Routes.verifyAccountView);
        } else if (state is RegisterFailure) {
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: verticalSpace(40)),
              SliverToBoxAdapter(
                child: CustomAppBar(
                  text: S.of(context).createAccount,
                ),
              ),
              SliverToBoxAdapter(child: verticalSpace(20)),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => _pickImage(onProfileImagePicked),
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: profileImagePath != null
                            ? FileImage(File(profileImagePath!))
                            : null,
                        child: profileImagePath == null
                            ? const Icon(Icons.camera_alt,
                                size: 30, color: Colors.grey)
                            : null,
                      ),
                    ),
                    verticalSpace(20),
                    GestureDetector(
                      onTap: () => _pickImage(onCoverImagePicked),
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          image: coverImagePath != null
                              ? DecorationImage(
                                  image: FileImage(File(coverImagePath!)),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: coverImagePath == null
                            ? const Center(
                                child: Icon(Icons.image,
                                    size: 40, color: Colors.grey),
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(child: verticalSpace(30)),
              SliverToBoxAdapter(
                child: Form(
                  key: registerFormKey,
                  child: Column(
                    children: [
                      AppTextFormField(
                        hintText: S.of(context).firstName,
                        prefixIcon: Assets.svgsUser,
                        controller: firstNameController,
                        validator: (value) =>
                            Validators.validateName(value, 'الاسم الأول'),
                      ),
                      verticalSpace(25),
                      AppTextFormField(
                        hintText: S.of(context).seconedName,
                        prefixIcon: Assets.svgsUser,
                        controller: lastNameController,
                        validator: (value) =>
                            Validators.validateName(value, 'الاسم الأخير'),
                      ),
                      verticalSpace(25),
                      AppTextFormField(
                        hintText: S.of(context).email,
                        prefixIcon: Assets.svgsMail,
                        controller: emailController,
                        validator: Validators.validateEmail,
                      ),
                      verticalSpace(25),
                      AppTextFormField(
                        hintText: S.of(context).createPassword,
                        prefixIcon: Assets.svgsLock,
                        controller: passwordController,
                        isPassword: true,
                        validator: Validators.validatePassword,
                      ),
                      verticalSpace(25),
                      AppTextFormField(
                        hintText: S.of(context).passwordConfirmation,
                        isPassword: true,
                        prefixIcon: Assets.svgsLock,
                        controller: confirmPasswordController,
                        validator: (value) {
                          if (value != passwordController.text) {
                            return 'كلمات المرور غير متطابقة';
                          }
                          return null;
                        },
                      ),
                      verticalSpace(25),
                      AppDatePickerField(
                        controller: dateOfBirthController,
                        hintText: S.of(context).BirthOfDate,
                        svgIconPath: Assets.svgsCalendarMonth,
                        validator: Validators.validateDateOfBirth,
                      ),
                      verticalSpace(25),
                      AppTextFormField(
                        controller: phoneController,
                        hintText: S.of(context).enterValidPhoneNumber,
                        prefixIcon: Assets.svgsMobile,
                        validator: Validators.validateMobile,
                      ),
                      verticalSpace(32),
                      state is RegisterLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            )
                          : AppTextButton(
                              buttonText: S.of(context).createAccount,
                              textStyle: AppStyles.styleMedium18,
                              backgroundColor: AppColors.primaryColor,
                              onPressed: () =>
                                  RegistrationHandler.handleRegistration(
                                context: context,
                                formKey: registerFormKey,
                                firstNameController: firstNameController,
                                lastNameController: lastNameController,
                                emailController: emailController,
                                passwordController: passwordController,
                                dateOfBirthController: TextEditingController(
                                  text: convertArabicToEnglishNumbers(
                                      dateOfBirthController.text),
                                ),
                                phoneNumber: phoneController.text,
                                profileImagePath: profileImagePath,
                                coverImagePath: coverImagePath,
                              ),
                            ),
                      const SizedBox(height: 20),
                    ],
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
