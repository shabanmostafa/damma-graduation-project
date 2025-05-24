import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/features/login/presentation/views/widgets/login_view_body.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(child: LoginViewBody()),
    );
  }
}
