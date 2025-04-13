import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/functions/list_tile_type.dart';
import 'package:damma_project/features/search/models/user_model.dart';
import 'package:flutter/material.dart';

class ReusableListTile extends StatelessWidget {
  final UserModel user;
  final UserItemType type;

  const ReusableListTile({
    super.key,
    required this.user,
    this.type = UserItemType.search,
  });

  @override
  Widget build(BuildContext context) {
    Widget trailingButton;

    switch (type) {
      case UserItemType.friendRequest:
        trailingButton = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {}, icon: Icon(Icons.close, color: Colors.red)),
            IconButton(
                onPressed: () {}, icon: Icon(Icons.check, color: Colors.green)),
          ],
        );
        break;
      case UserItemType.suggestion:
        trailingButton = ElevatedButton(
          onPressed: () {},
          child: Text("إضافة"),
        );
        break;
      case UserItemType.search:
        trailingButton = ElevatedButton(
          onPressed: () {},
          child: Text("عرض"),
        );
        break;
    }

    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: AssetImage(user.imageUrl),
      ),
      title: Text(user.name, style: AppStyles.styleLight24),
      subtitle: Text(user.jobTitle,
          style: AppStyles.styleMedium14.copyWith(color: Colors.grey)),
      trailing: trailingButton,
    );
  }
}
