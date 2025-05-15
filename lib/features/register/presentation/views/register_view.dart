import 'package:flutter/material.dart';
import '../widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  final String? phoneNumber;

  const RegisterView({super.key, this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    String? profileImagePath;
    String? coverImagePath;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StatefulBuilder(
          builder: (context, setState) {
            return RegisterViewBody(
              profileImagePath: profileImagePath,
              coverImagePath: coverImagePath,
              onProfileImagePicked: (path) {
                setState(() {
                  profileImagePath = path;
                });
              },
              onCoverImagePicked: (path) {
                setState(() {
                  coverImagePath = path;
                });
              },
            );
          },
        ),
      ),
    );
  }
}
