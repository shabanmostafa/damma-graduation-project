import 'package:damma_project/core/utils/di/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/utils/routing/app_router.dart';
import 'damma.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'global_bloc_observer.dart';

void main() async {
  // final secureStorageService = SecureStorageService();
  // final dio = Dio()..options.baseUrl = Endpoints.baseUrl;
  // final apiConsumer = DioConsumer(
  //   dio: dio,
  //   secureStorageService: secureStorageService,
  // );

  // final loginRepo = LoginRepoImpl(apiConsumer);
  // final registerRepo = RegisterRepoImpl(apiConsumer);
  // final verifyRpo = VerifyRepoImpl(apiConsumer);

  WidgetsFlutterBinding.ensureInitialized();
  setup();
  Bloc.observer = GlobalBlocObserver();
  await ScreenUtil.ensureScreenSize();
  runApp(
    Damma(
      appRouter: AppRouter(),
    ),
  );
}
