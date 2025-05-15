import 'package:flutter/material.dart';

import '../widgets/verify_account_view_body.dart';


class VerifyAccountView extends StatelessWidget {
  const VerifyAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: VerifyAccountViewBody()),
    );
  }
}
