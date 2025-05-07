import 'package:flutter/material.dart';
import '../../../../../core/utils/widgets/custom_app_bar.dart';
import 'profile_header.dart';
import 'profile_info.dart';
import 'profile_activity.dart';
import 'profile_posts.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CustomAppBar(
              needArrow: true,
              text: 'شعبان مصطفي',
            ),
          ),
          ProfileHeader(),
          ProfileInfo(),
          ProfileActivity(),
          ProfilePosts(),
        ],
      ),
    );
  }
}
