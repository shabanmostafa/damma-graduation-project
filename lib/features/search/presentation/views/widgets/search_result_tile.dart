import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/di/service_locator.dart';
import 'package:damma_project/core/utils/routing/routes.dart';
import 'package:damma_project/features/search/data/models/search_model/search_model.dart';
import 'package:damma_project/features/isFreind/data/repos/friendship_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchResultTile extends StatelessWidget {
  final SearchModel user;

  const SearchResultTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildProfileImage(user.profileImageUrl),
      title: Text(
        '${user.firstName ?? ''} ${user.lastName ?? ''}',
        style:
            AppStyles.styleMedium16.copyWith(color: AppColors.blackTextColor),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${user.mutualFriendsCount ?? 0} أصدقاء مشتركين',
        style: AppStyles.styleMedium14.copyWith(color: AppColors.hintTextColor),
      ),
      onTap: () => _handleUserTap(context),
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

    // Handle cases where path might be just a directory
    if (path.endsWith('/')) return null;

    // Check if path already contains full URL
    if (path.startsWith('http')) return path;

    // Handle relative paths
    final normalizedPath = path.startsWith('/') ? path : '/$path';

    // Validate the path looks like an actual image file
    final validImageExtensions = ['.jpg', '.jpeg', '.png', '.gif'];
    final hasValidExtension =
        validImageExtensions.any((ext) => path.toLowerCase().endsWith(ext));

    if (!hasValidExtension) return null;

    return 'http://dama.runasp.net$normalizedPath';
  }

  Future<void> _handleUserTap(BuildContext context) async {
    if (user.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("خطأ: معرف المستخدم غير صالح")),
      );
      return;
    }

    try {
      final friendshipRepo = getIt<FriendshipRepo>();
      final result = await friendshipRepo.checkIsFriend(user.id!);

      result.fold(
        (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("خطأ: $error")),
          );
        },
        (isFriend) {
          Navigator.pushNamed(
            context,
            isFriend ? Routes.isFriendView : Routes.isNotFriendView,
            arguments: user,
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("حدث خطأ غير متوقع: ${e.toString()}"),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
