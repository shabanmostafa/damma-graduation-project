import 'package:damma_project/features/home/presentation/views/widgets/post_section.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../models/post_model.dart';

class PostsListView extends StatelessWidget {
  const PostsListView({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample list of posts
    List<PostModel> posts = [
      PostModel(
        postOwnerPic: 'assets/images/shaban.jpg',
        postOwnerName: 'Shabaan Mostafa',
        postOwnerfriends: '5,432 متابع',
        postImage: 'assets/images/shaban.jpg',
        postContent:
            'من يسكن البحر ويحبه الناس لونه اصفر مربع حساس ، دي مش عجبااااك اتفراااااج',
        numberOfLikes: '0',
        numberOfComments: '0',
        numberOfShares: '120',
        userProfilePic: 'assets/images/shaban.jpg',
      ),
      PostModel(
        postOwnerPic: 'assets/images/shaban.jpg',
        postOwnerName: 'شعبان مصطفي',
        postOwnerfriends: '5,432 متابع',
        postImage: 'assets/images/shaban.jpg',
        postContent:
            'من يسكن البحر ويحبه الناس لونه اصفر مربع حساس ، دي مش عجبااااك اتفراااااج',
        numberOfLikes: '12',
        numberOfComments: '0',
        numberOfShares: '120',
        userProfilePic: 'assets/images/shaban.jpg',
      ),
    ];

    return Column(
      children: List.generate(
        posts.length,
        (index) => Column(
          children: [
            PostSection(postModel: posts[index]),
            const Divider(),
            verticalSpace(10),
          ],
        ),
      ),
    );
  }
}
