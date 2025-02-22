import 'package:flutter/material.dart';

class PublisherInfo extends StatelessWidget {
  const PublisherInfo(
      {super.key, required this.userImage, required this.username});
  final String userImage;
  final String username;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: AssetImage(userImage)),
      title:
          Text(username, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: const Text("8,989 متابع"),
      trailing: const Icon(Icons.more_horiz),
    );
  }
}
