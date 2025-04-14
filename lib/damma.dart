import 'package:damma_project/features/search/cubit/search_cubit.dart';
import 'package:damma_project/features/search/presentation/views/search_view.dart';
import 'package:damma_project/features/search/presentation/widgets/search_view_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/utils/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/home/presentation/views/home_view.dart';
import 'generated/l10n.dart';

class Damma extends StatelessWidget {
  final AppRouter appRouter;
  const Damma({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => SearchCubit(),
            ),
          ],
          child: child!,
        );
      },
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        locale: const Locale('ar'),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: const HomeView(),
        //OnBoardingView(),
        theme: ThemeData(
            //textTheme: GoogleFonts.gess
            ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
