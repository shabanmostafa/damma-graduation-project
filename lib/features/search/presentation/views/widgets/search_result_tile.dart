import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/features/search/data/models/search_model/search_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchResultTile extends StatelessWidget {
  final SearchModel user;

  const SearchResultTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final imageUrl = (user.profileImageUrl != null && user.profileImageUrl!.isNotEmpty)
        ? 'http://dama.runasp.net${user.profileImageUrl}'
        : null;

    return ListTile(
      leading: CircleAvatar(
        radius: 24.r,
        backgroundImage: imageUrl != null
            ? NetworkImage(imageUrl)
            : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
      ),
      title: Text(
        '${user.firstName ?? ''} ${user.lastName ?? ''}',
        style: AppStyles.styleMedium16.copyWith(color: AppColors.blackTextColor),
      ),
      subtitle: Text(
        '${user.mutualFriendsCount ?? 0} أصدقاء مشتركين',
        style: AppStyles.styleMedium14,
      ),
      onTap: () {
        // TODO: Navigate to user's profile or handle interaction
      },
    );
  }
}
