import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/functions/list_tile_type.dart';
import 'package:damma_project/core/utils/widgets/app_text_button.dart';
import 'package:damma_project/features/my_friends/data/models/my_friends_model/datum.dart';
import 'package:damma_project/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyFriendListTile extends StatelessWidget {
  final Datum friend;
  final UserItemType type;
  final VoidCallback? onDelete;

  const MyFriendListTile({
    super.key,
    required this.friend,
    required this.type,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    Widget? trailingButton;

    switch (type) {
      case UserItemType.friendRequest:
        trailingButton = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextButton(
              backgroundColor: AppColors.primaryColor,
              borderRadius: 10.r,
              buttonWidth: 66.w,
              buttonHeight: 40.h,
              buttonText: S.of(context).Accept,
              textStyle: AppStyles.styleMedium14.copyWith(
                color: AppColors.whiteColor,
              ),
              onPressed: () {},
            ),
            SizedBox(width: 8.w),
            AppTextButton(
              backgroundColor: AppColors.inactiveButtonColor,
              borderRadius: 10.r,
              buttonWidth: 66.w,
              buttonHeight: 40.h,
              buttonText: S.of(context).Reject,
              textStyle: AppStyles.styleMedium14.copyWith(
                color: AppColors.hintTextColor,
              ),
              onPressed: () {},
            ),
          ],
        );
        break;
      case UserItemType.friend:
        trailingButton = AppTextButton(
          backgroundColor: AppColors.red500Color,
          borderRadius: 10.r,
          buttonWidth: 110.w,
          buttonHeight: 40.h,
          buttonText: "حذف الصديق",
          textStyle: AppStyles.styleMedium14.copyWith(
            color: AppColors.whiteColor,
          ),
          onPressed: onDelete ?? () {},
        );
        break;
      case UserItemType.suggestion:
        trailingButton = AppTextButton(
          backgroundColor: AppColors.primaryColor,
          borderRadius: 10.r,
          buttonWidth: 110.w,
          buttonHeight: 40.h,
          buttonText: S.of(context).AddFriend,
          textStyle: AppStyles.styleMedium14.copyWith(
            color: AppColors.whiteColor,
          ),
          onPressed: () {},
        );
        break;
      case UserItemType.search:
        trailingButton = null;
        break;
    }

    final fullName =
        '${friend.firstName?.trim() ?? ''} ${friend.lastName?.trim() ?? ''}'
            .trim();

    return GestureDetector(
      onTap: () {},
      child: ListTile(
        leading: _buildProfileImage(friend.profileImageUrl),
        title: Text(
          fullName,
          style: AppStyles.styleMedium16.copyWith(
            color: AppColors.blackTextColor,
          ),
        ),
        trailing: trailingButton,
      ),
    );
  }

  Widget _buildProfileImage(String? path) {
    final imageUrl = _getProfileImageUrl(path);

    return CircleAvatar(
      radius: 24.r,
      backgroundColor: AppColors.primaryColor.withOpacity(0.1),
      child: imageUrl != null
          ? ClipOval(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: 48.r,
                height: 48.r,
                errorBuilder: (context, error, stackTrace) {
                  return _buildDefaultAvatar();
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                      color: AppColors.primaryColor,
                    ),
                  );
                },
              ),
            )
          : _buildDefaultAvatar(),
    );
  }

  Widget _buildDefaultAvatar() {
    return Icon(
      Icons.person,
      size: 24.r,
      color: AppColors.primaryColor,
    );
  }

  String? _getProfileImageUrl(String? path) {
    if (path == null || path.isEmpty) return null;
    if (path.endsWith('/')) return null;
    if (path.startsWith('http')) return path;
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    final validImageExtensions = ['.jpg', '.jpeg', '.png', '.gif'];
    final hasValidExtension =
        validImageExtensions.any((ext) => path.toLowerCase().endsWith(ext));
    if (!hasValidExtension) return null;
    return 'http://dama.runasp.net$normalizedPath';
  }
}
