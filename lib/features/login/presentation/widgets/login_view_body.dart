import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/assets.dart';
import '../../../../core/utils/routing/routes.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../generated/l10n.dart';
import 'custom_bottom_button.dart';
import 'custom_login_entry_section.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  LoginViewBodyState createState() => LoginViewBodyState();
}

class LoginViewBodyState extends State<LoginViewBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateButtonState);
    _passwordController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: verticalSpace(60)),
          SliverToBoxAdapter(
              child: CustomAppBar(
            text: S.of(context).login,
            needArrow: false,
          )),
          SliverToBoxAdapter(child: verticalSpace(32)),
          SliverToBoxAdapter(child: SvgPicture.asset(Assets.svgsBlackLogo)),
          SliverToBoxAdapter(child: verticalSpace(40)),
          SliverToBoxAdapter(
            child: CustomLoginEntrySection(
              emailController: _emailController,
              passwordController: _passwordController,
              isButtonEnabled: _isButtonEnabled,
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
                    Navigator.pushNamed(context, Routes.firstStepYourNameView);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
