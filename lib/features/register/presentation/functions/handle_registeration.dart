import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/register_cubit.dart';

class RegistrationHandler {
  static void handleRegistration({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController firstNameController,
    required TextEditingController lastNameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController dateOfBirthController,
    required String? phoneNumber,
    required String? profileImagePath,
    required String? coverImagePath,
  }) {
    if (formKey.currentState?.validate() ?? false) {
      context.read<RegisterCubit>().register(
            firstName: firstNameController.text.trim(),
            lastName: lastNameController.text.trim(),
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            dateOfBirth: dateOfBirthController.text.trim(),
            phoneNumber: phoneNumber,
            profileImagePath: profileImagePath,
            coverImagePath: coverImagePath,
          );
    }
  }
}