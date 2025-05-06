import 'package:damma_project/features/home/models/post_model.dart';
import 'package:damma_project/features/profile/presentation/widgets/profile_posts.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/widgets/custom_app_bar.dart';
import 'profile_header.dart';
import 'profile_info.dart';
import 'profile_activity.dart';

class ProfileViewBody extends StatelessWidget {
  ProfileViewBody({super.key});
  final List<PostModel> posts = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CustomAppBar(
              needArrow: true,
              text: 'شعبان مصطفي',
            ),
          ),
          const ProfileHeader(),
          const ProfileInfo(),
          const ProfileActivity(),
          ProfilePosts(posts: posts),
        ],
      ),
    );
  }
}
