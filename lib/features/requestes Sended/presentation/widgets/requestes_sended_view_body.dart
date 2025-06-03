import 'package:damma_project/features/requestes%20Sended/manager/request_sent_cubit.dart';
import 'package:damma_project/features/requestes%20Sended/presentation/widgets/requestes_sended_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/widgets/custom_app_bar.dart';

class RequestesSendedViewBody extends StatelessWidget {
  const RequestesSendedViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestSentCubit, RequestSentState>(
      listener: (context, state) {
        if (state is RequestCancelled) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'تم حذف طلب الصداقة',
                style: TextStyle(color: AppColors.whiteColor),
              ),
              backgroundColor: AppColors.primaryColor,
              duration: Duration(seconds: 2),
            ),
          );
          context.read<RequestSentCubit>().fetchSentRequests();
        }
        if (state is RequestSentFailure) {
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
      child: BlocBuilder<RequestSentCubit, RequestSentState>(
        builder: (context, state) {
          if (state is RequestSentLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          } else if (state is RequestSentFailure) {
            return Center(child: Text(state.error));
          } else if (state is RequestSentSuccess) {
            final requests = state.sentRequests.data ?? [];

            if (requests.isEmpty) {
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomAppBar(
                      needArrow: true,
                      text: 'طلبات الصداقة المرسلة',
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'لا توجد طلبات صداقة مرسلة',
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
                    text: 'طلبات الصداقة المرسلة',
                  ),
                ),
                const Divider(color: AppColors.hintTextColor, thickness: .25),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '${state.sentRequests.count ?? requests.length} طلب',
                    style: AppStyles.styleMedium16.copyWith(
                      color: AppColors.blackTextColor,
                    ),
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () =>
                        context.read<RequestSentCubit>().fetchSentRequests(),
                    child: ListView.separated(
                      separatorBuilder: (_, __) => Padding(
                        padding: EdgeInsets.only(right: 55.0.w, left: 15.0.w),
                        child: const Divider(),
                      ),
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                        final request = requests[index];
                        return RequestesSendedListTile(
                          request: request,
                          onCancel: () {
                            context
                                .read<RequestSentCubit>()
                                .cancelRequest(request.id!);
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
