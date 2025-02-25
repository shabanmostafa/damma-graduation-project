import 'package:damma_project/features/friend_requests/presentation/widgets/friend_request_view_body.dart';
import 'package:flutter/material.dart';

class FriendRequestsView extends StatelessWidget {
  const FriendRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FriendRequestViewBody(),
      ),
    );
  }
}
