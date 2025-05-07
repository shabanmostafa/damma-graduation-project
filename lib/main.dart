import 'package:damma_project/core/utils/di/service_locator.dart';
import 'package:damma_project/features/register/logic/cubits/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/utils/routing/app_router.dart';
import 'damma.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/register/data/repos/auth_repo_impl.dart';
import 'global_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  Bloc.observer = GlobalBlocObserver();
  await ScreenUtil.ensureScreenSize();
  runApp(
    BlocProvider(
      create: (context) => AuthCubit(getIt.get<AuthRepoImpl>()),
      child: Damma(
        appRouter: AppRouter(),
      ),
    ),
  );
}
