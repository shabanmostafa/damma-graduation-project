import 'package:damma_project/features/add_post/presentation/widgets/exit_button.dart';
import 'package:damma_project/features/add_post/presentation/widgets/writer_image.dart';
import 'package:flutter/material.dart';

class RightPartOfRow extends StatelessWidget {
  const RightPartOfRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        ExitButton(),
        WriterImage(),
        SizedBox(width: 10),
      ],
    );
  }
}
