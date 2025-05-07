import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WriterImage extends StatelessWidget {
  const WriterImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      height: 40.h,
      child: CircleAvatar(
        radius: 34.5.r,
        backgroundImage: const AssetImage('assets/images/shaban.jpg'),
      ),
    );
  }
}
