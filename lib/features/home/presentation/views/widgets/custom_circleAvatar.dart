import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 20,
      backgroundImage: AssetImage("assets/images/shaban.jpg"), // صورة المستخدم
    );
  }
}
