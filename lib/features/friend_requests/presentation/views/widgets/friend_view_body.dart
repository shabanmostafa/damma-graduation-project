import 'package:damma_project/features/friend_requests/manager/cubit/friend_cubit.dart';
import 'package:damma_project/features/friend_requests/presentation/views/widgets/friend_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendViewBody extends StatelessWidget {
  const FriendViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FriendCubit()..fetchFriendRequests(),
      child: const FriendContent(),
    );
  }
}
