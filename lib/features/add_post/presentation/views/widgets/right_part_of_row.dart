import 'package:damma_project/core/utils/models/user_model.dart';
import 'package:damma_project/features/add_post/presentation/views/widgets/exit_button.dart';
import 'package:damma_project/features/add_post/presentation/views/widgets/writer_image.dart';
import 'package:flutter/material.dart';

class RightPartOfRow extends StatelessWidget {
  final UserModel user;
  const RightPartOfRow({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ExitButton(),
        WriterImage(imagePath: user.profileImageUrl),
        const SizedBox(width: 10),
      ],
    );
  }
}
