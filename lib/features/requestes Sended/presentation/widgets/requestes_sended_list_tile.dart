import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/widgets/app_text_button.dart';
import '../../data/models/requested_sended_model/datum.dart';

class RequestesSendedListTile extends StatelessWidget {
  final Datum request;
  final VoidCallback onCancel;

  const RequestesSendedListTile({
    super.key,
    required this.request,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final fullName =
        '${request.firstName?.trim() ?? ''} ${request.lastName?.trim() ?? ''}'
            .trim();

    return ListTile(
      leading: _buildProfileImage(request.profileImageUrl),
      title: Text(
        fullName,
        style: AppStyles.styleMedium16.copyWith(
          color: AppColors.blackTextColor,
        ),
      ),
      trailing: AppTextButton(
        backgroundColor: AppColors.red500Color,
        borderRadius: 10.r,
        buttonWidth: 110.w,
        buttonHeight: 40.h,
        buttonText: "إالغاء",
        textStyle: AppStyles.styleMedium14.copyWith(
          color: AppColors.whiteColor,
        ),
        onPressed: onCancel,
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
}
