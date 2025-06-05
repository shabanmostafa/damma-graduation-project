// custom_circle_avatar.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:damma_project/core/utils/app_colors.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String? imagePath;
  final double radius;

  const CustomCircleAvatar({
    super.key,
    this.imagePath,
    this.radius = 20,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = _getProfileImageUrl(imagePath);

    return CircleAvatar(
      radius: radius.r,
      backgroundColor: AppColors.primaryColor.withOpacity(0.1),
      child: imageUrl != null
          ? ClipOval(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: (radius * 2).r,
                height: (radius * 2).r,
                errorBuilder: (_, __, ___) => _buildDefaultAvatar(),
                loadingBuilder: (_, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
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
      size: radius.r,
      color: AppColors.primaryColor,
    );
  }

  String? _getProfileImageUrl(String? path) {
    if (path == null || path.isEmpty || path.endsWith('/')) return null;
    if (path.startsWith('http')) return path;

    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return 'http://dama.runasp.net$normalizedPath';
  }
}
