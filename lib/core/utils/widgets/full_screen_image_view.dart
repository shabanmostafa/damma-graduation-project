import 'package:damma_project/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class FullScreenImageView extends StatelessWidget {
  final String? imageUrl;
  final ImageProvider? imageProvider;

  const FullScreenImageView({super.key, this.imageUrl, this.imageProvider});

  @override
  Widget build(BuildContext context) {
    final ImageProvider image = imageProvider ?? NetworkImage(imageUrl!);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          // iconTheme: const IconThemeData(color: AppColors.blackTextColor),
        ),
        body: Center(
          child: InteractiveViewer(
            maxScale: 5,
            child: Image(
              image: image,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
