import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatelessWidget {
  final String? imagePath;
  final void Function(String path) onImageSelected;

  const ProfileImagePicker({
    super.key,
    required this.imagePath,
    required this.onImageSelected,
  });

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      onImageSelected(picked.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickImage(context),
      child: CircleAvatar(
        radius: 45,
        backgroundColor: Colors.grey.shade300,
        backgroundImage: imagePath != null ? FileImage(File(imagePath!)) : null,
        child: imagePath == null
            ? const Icon(Icons.camera_alt, size: 30, color: Colors.grey)
            : null,
      ),
    );
  }
}
