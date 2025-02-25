import 'package:damma_project/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class FriendRequestsAppbar extends StatelessWidget {
  const FriendRequestsAppbar({super.key, required this.numberOfRequests});
  final int numberOfRequests;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Text(
                    "طلبات الصداقة",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 25),
                  Text(
                    '$numberOfRequests',
                    style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16), // Placeholder to balance the row
          ],
        ),
        const Divider(),
      ],
    );
  }
}
