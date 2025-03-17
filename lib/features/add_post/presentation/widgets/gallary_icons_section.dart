import 'package:damma_project/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GallaryIconsSection extends StatelessWidget {
  const GallaryIconsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(Assets.svgVedio),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(Assets.svgGallary),
        ),
      ],
    );
  }
}
