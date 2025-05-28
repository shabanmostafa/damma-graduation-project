import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/di/service_locator.dart';
import 'package:damma_project/features/requestes%20Sended/data/repos/request_sent_repo.dart';
import 'package:damma_project/features/requestes%20Sended/manager/request_sent_cubit.dart';
import 'package:damma_project/features/requestes%20Sended/presentation/widgets/requestes_sended_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestesSendedView extends StatelessWidget {
  const RequestesSendedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RequestSentCubit(getIt<RequestSentRepo>()) // Use interface type
            ..fetchSentRequests(),
      child: const SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: RequestesSendedViewBody(),
        ),
      ),
    );
  }
}
