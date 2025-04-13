import 'package:damma_project/core/utils/widgets/reusable_list_tile.dart';
import 'package:damma_project/features/search/cubit/search_cubit.dart';
import 'package:damma_project/features/search/cubit/search_state.dart';
import 'package:damma_project/features/search/presentation/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_styles.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Padding(
      padding: EdgeInsets.all(16.0.w),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          SearchTextField(controller: controller),
          SizedBox(height: 20.h),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchLoaded) {
                  if (state.results.isEmpty) {
                    return Center(
                        child: Text("لا توجد نتائج",
                            style: AppStyles.styleMedium16));
                  }
                  return ListView.separated(
                    itemCount: state.results.length,
                    separatorBuilder: (_, __) =>
                        Divider(color: Colors.grey.shade300),
                    itemBuilder: (context, index) {
                      return ReusableListTile(user: state.results[index]);
                    },
                  );
                }
                return Center(
                    child: Text("ابدأ بالبحث لعرض النتائج",
                        style: AppStyles.styleMedium16));
              },
            ),
          ),
        ],
      ),
    );
  }
}
