import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WriterImage extends StatelessWidget {
  final String? imagePath;

  const WriterImage({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      height: 40.h,
      child: CircleAvatar(
        radius: 34.5.r,
        backgroundImage: imagePath != null
            ? NetworkImage(_getImageUrl(imagePath!))
            : const AssetImage('assets/images/shaban.jpg') as ImageProvider,
      ),
    );
  }

  String _getImageUrl(String path) {
    if (path.startsWith('http')) return path;
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return 'http://dama.runasp.net$normalizedPath';
  }
}
