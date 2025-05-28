import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/di/service_locator.dart';
import 'package:damma_project/features/requstes_recieved/data/repos/requests_received_repo.dart';
import 'package:damma_project/features/requstes_recieved/manager/requests_received_cubit.dart';
import 'package:damma_project/features/requstes_recieved/presentation/widgets/requests_received_view_body.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestsReceivedView extends StatelessWidget {
  const RequestsReceivedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RequestsReceivedCubit(getIt<RequestsReceivedRepo>())
        ..fetchReceivedRequests(),
      child: const SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: RequestsReceivedViewBody(),
        ),
      ),
    );
  }
}
