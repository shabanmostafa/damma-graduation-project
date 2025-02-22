import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.grey[300],
      backgroundImage:
          const AssetImage("assets/images/welcome.png"), // صورة المستخدم
    );
  }
}
