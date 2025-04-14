import 'package:damma_project/core/utils/functions/list_tile_type.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          SearchTextField(controller: controller),
          SizedBox(height: 20.h),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchInitial) {
                  return Center(
                      child: Text("لا توجد نتائج", style: AppStyles.styleMedium16));
                } else if (state is SearchError) {
                  return Center(child: Text(state.message));
                } else if (state is SearchLoaded) {
                  if (state.results.isEmpty) {
                    return Center(
                        child: Text("لا توجد نتائج", style: AppStyles.styleMedium16));
                  }
                  return ListView.separated(
                    itemCount: state.results.length,
                    separatorBuilder: (_, __) =>
                        Divider(color: Colors.grey.shade300),
                    itemBuilder: (context, index) {
                      return ReusableListTile(
                          user: state.results[index], type: UserItemType.search);
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
