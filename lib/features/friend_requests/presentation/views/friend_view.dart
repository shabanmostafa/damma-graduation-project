import 'package:damma_project/features/friend_requests/presentation/views/widgets/friend_view_body.dart';
import 'package:flutter/material.dart';

class FriendView extends StatelessWidget {
  const FriendView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
      child: FriendViewBody(),
    ));
  }
}
