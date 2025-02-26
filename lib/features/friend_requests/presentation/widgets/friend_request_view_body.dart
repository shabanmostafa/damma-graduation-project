import 'package:flutter/material.dart';

class FriendRequestViewBody extends StatelessWidget {
  FriendRequestViewBody({super.key});
  final List<Map<String, String>> friendRequests = [
    {
      "name": "أسامة العتل",
      "job": "Software Developer",
      "image": "assets/1.jpg"
    },
    {
      "name": "شعبان مصطفي شعبان",
      "job": "Partners Relationship Supervisor | Business Develop",
      "image": "assets/1.jpg"
    },
    {
      "name": "سيف الدين حاتم",
      "job": "Software Developer",
      "image": "assets/3.jpg"
    },
    {
      "name": "احمد حلمي محمد",
      "job": "Software Developer",
      "image": "assets/4.jpg"
    },
    {"name": "حمدي محمد", "job": "Software Developer", "image": "assets/2.jpg"},
    {
      "name": "عبدالرحمن عبدالفتاح",
      "job": "Software Developer",
      "image": "assets/4.jpg"
    },
    {"name": "عاطف شلبي", "job": "Software Developer", "image": "assets/1.jpg"},
    {
      "name": "محمود عبد الله",
      "job": "Software Developer",
      "image": "assets/4.jpg"
    },
    {
      "name": "محمود عبد الله",
      "job": "Software Developer",
      "image": "assets/4.jpg"
    },
    {
      "name": "محمود عبد الله",
      "job": "Software Developer",
      "image": "assets/4.jpg"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("FriendRequestViewBody"));
    // Column(
    //   children: [
    //     FriendRequestsAppbar(
    //       numberOfRequests: friendRequests.length,
    //     ),
    //     FriendRequestsListView(friendRequests: friendRequests),
    //   ],
    // );
  }
}
