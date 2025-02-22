import 'package:damma_project/features/home/presentation/widgets/damma_appbar.dart';
import 'package:damma_project/features/home/presentation/widgets/posts_list_view.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        DammaAppBar(),
        Expanded(child: PostsListView()),
      ],
    );
  }
}
