import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/features/search/data/repo/search_repo_imp.dart';
import 'package:damma_project/features/search/manager/cubit/search_cubit.dart';
import 'package:damma_project/features/search/manager/cubit/search_state.dart';
import 'package:damma_project/features/search/presentation/views/widgets/search_result_tile.dart';
import 'package:damma_project/features/search/presentation/views/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:damma_project/generated/l10n.dart';
import 'package:damma_project/core/utils/di/service_locator.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return BlocProvider(
      create: (_) => SearchCubit(getIt<SearchRepoImpl>()),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            SearchTextField(controller: controller),
            SizedBox(height: 20.h),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  } else if (state is SearchSuccess) {
                    if (state.results.isEmpty) {
                      return Center(
                        child: Text(
                          S.of(context).NoResultFounded.replaceAll("{{query}}", controller.text),
                          style: AppStyles.styleMedium16,
                        ),
                      );
                    }
                    return ListView.separated(
                      itemCount: state.results.length,
                      separatorBuilder: (_, __) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: const Divider(),
                      ),
                      itemBuilder: (context, index) {
                        return SearchResultTile(user: state.results[index]);
                      },
                    );
                  } else if (state is SearchFailure) {
                    return Center(
                      child: Text(state.error, style: AppStyles.styleMedium16),
                    );
                  }
                  return Center(
                    child: Text(S.of(context).letsStart, style: AppStyles.styleMedium16),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
