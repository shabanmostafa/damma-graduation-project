import 'core/utils/routing/app_router.dart';
import 'damma.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(
    Damma(
      appRouter: AppRouter(),
    ),
  );
}
