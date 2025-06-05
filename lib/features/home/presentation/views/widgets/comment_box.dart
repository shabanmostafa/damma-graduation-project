import 'package:damma_project/features/home/manager/home_cubit.dart';
import 'package:damma_project/features/home/presentation/views/widgets/custom_circleAvatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentBox extends StatelessWidget {
  const CommentBox({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<HomeCubit>().state is HomeSuccess
        ? (context.read<HomeCubit>().state as HomeSuccess).user
        : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          CustomCircleAvatar(imagePath: user?.profileImageUrl), // ✅
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                "اكتب تعليق...",
                style: TextStyle(color: Colors.grey[700], fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
