import 'package:damma_project/features/requstes_recieved/manager/requests_received_cubit.dart';
import 'package:damma_project/features/requstes_recieved/presentation/widgets/requests_received_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/widgets/custom_app_bar.dart';

import '../../../home/presentation/views/home_view.dart';

class RequestsReceivedViewBody extends StatelessWidget {
  const RequestsReceivedViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestsReceivedCubit, RequestsReceivedState>(
      listener: (context, state) {
        if (state is RequestAccepted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'تم قبول طلب الصداقة بنجاح',
                style: TextStyle(color: AppColors.whiteColor),
              ),
              backgroundColor: AppColors.primaryColor,
              duration: Duration(seconds: 2),
            ),
          );
          context.read<RequestsReceivedCubit>().fetchReceivedRequests();
        } else if (state is RequestRejected) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'تم رفض طلب الصداقة بنجاح',
                style: TextStyle(color: AppColors.whiteColor),
              ),
              backgroundColor: AppColors.primaryColor,
              duration: Duration(seconds: 2),
            ),
          );
          context.read<RequestsReceivedCubit>().fetchReceivedRequests();
        } else if (state is RequestsReceivedFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
                style: const TextStyle(color: AppColors.whiteColor),
              ),
              backgroundColor: AppColors.red500Color,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: BlocBuilder<RequestsReceivedCubit, RequestsReceivedState>(
        builder: (context, state) {
          if (state is RequestsReceivedLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          } else if (state is RequestsReceivedFailure) {
            return Center(child: Text(state.error));
          } else if (state is RequestsReceivedSuccess) {
            final requests = state.receivedRequests.data ?? [];

            if (requests.isEmpty) {
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomAppBar(
                      needArrow: false,
                      text: 'طلبات الصداقة الواردة',
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'لا توجد طلبات صداقة واردة',
                        style: AppStyles.styleMedium16.copyWith(
                          color: AppColors.blackTextColor,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomAppBar(
                    needArrow: true,
                    text: 'طلبات الصداقة الواردة',
                  ),
                ),
                const Divider(color: AppColors.hintTextColor, thickness: .25),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '${state.receivedRequests.count ?? requests.length} طلب',
                    style: AppStyles.styleMedium16.copyWith(
                      color: AppColors.blackTextColor,
                    ),
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => context
                        .read<RequestsReceivedCubit>()
                        .fetchReceivedRequests(),
                    child: ListView.separated(
                      separatorBuilder: (_, __) => Padding(
                        padding: EdgeInsets.only(right: 55.0.w, left: 15.0.w),
                        child: const Divider(),
                      ),
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                        final request = requests[index];
                        return RequestsReceivedListTile(
                          request: request,
                          onAccept: () {
                            context
                                .read<RequestsReceivedCubit>()
                                .acceptRequest(request.requestId!);
                          },
                          onReject: () {
                            context
                                .read<RequestsReceivedCubit>()
                                .rejectRequest(request.requestId!);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
