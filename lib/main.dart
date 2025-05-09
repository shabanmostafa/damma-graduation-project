import 'package:damma_project/core/utils/api/api_consumer.dart';
import 'package:damma_project/core/utils/api/dio_consumer.dart';
import 'package:damma_project/core/utils/api/endpoints.dart';
import 'package:damma_project/core/utils/di/service_locator.dart';
import 'package:damma_project/core/utils/secure/secure_storage_service.dart';
import 'package:damma_project/features/login/data/repo/login_repo_imp.dart';
import 'package:damma_project/features/login/manager/login_cubit/login_cubit.dart';
import 'package:damma_project/features/register/logic/cubits/auth_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/utils/routing/app_router.dart';
import 'damma.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/register/data/repos/auth_repo_impl.dart';
import 'global_bloc_observer.dart';

void main() async {
  final dio = Dio()..options.baseUrl = Endpoints.baseUrl;
  final secureStorageService = SecureStorageService();
  final apiConsumer = DioConsumer(dio: dio, secureStorageService: secureStorageService);
  final loginRepo = LoginRepoImpl(apiConsumer as ApiConsumer);

  WidgetsFlutterBinding.ensureInitialized();
  setup();
  Bloc.observer = GlobalBlocObserver();
  await ScreenUtil.ensureScreenSize();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(getIt.get<AuthRepoImpl>()),
        ),
        BlocProvider(
          create: (context) => LoginCubit(loginRepo),
        ),
      ],
      child: Damma(
        appRouter: AppRouter(),
      ),
    ),
  );
}
