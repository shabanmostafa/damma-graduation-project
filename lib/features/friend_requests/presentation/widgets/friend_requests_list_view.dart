import 'package:damma_project/features/home/presentation/widgets/custom_circleAvatar.dart';
import 'package:damma_project/features/welcome/presentation/views/widgets/buttons_section.dart';
import 'package:flutter/material.dart';

class FriendRequestsListView extends StatelessWidget {
  const FriendRequestsListView({super.key, required this.friendRequests});
  final List friendRequests;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: false,
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: friendRequests.length,
        separatorBuilder: (context, index) => Divider(color: Colors.grey[300]),
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CustomCircleAvatar(),
            title: Text(
              friendRequests[index]["name"]!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              friendRequests[index]["job"]!,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const ButtonsSection(),
          );
        },
      ),
    );
  }
}
