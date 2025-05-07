import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/functions/list_tile_type.dart';
import 'package:damma_project/core/utils/widgets/custom_app_bar.dart';
import 'package:damma_project/core/utils/widgets/reusable_list_tile.dart';
import 'package:damma_project/features/search/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FriendsPageViewBody extends StatelessWidget {
  const FriendsPageViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomAppBar(
            needArrow: true,
            text: 'الأصدقاء',
          ),
        ),
        const Divider(
          color: AppColors.hintTextColor,
          thickness: .25,
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            '879 صديق',
            style: AppStyles.styleMedium16.copyWith(
              color: AppColors.blackTextColor,
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (_, __) => Padding(
              padding: EdgeInsets.only(right: 55.0.w, left: 15.0.w),
              child: const Divider(),
            ),
            itemBuilder: (context, index) {
              return ReusableListTile(
                type: UserItemType.friend,
                user: UserModel(
                  name: 'name',
                  jobTitle: 'jobTitle',
                  imageUrl: 'assets/images/shaban.jpg',
                ),
              );
            },
            itemCount: 50,
          ),
        ),
      ],
    );
  }
}
