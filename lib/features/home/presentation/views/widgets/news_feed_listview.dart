// 5. NewsFeedListView
import 'package:damma_project/core/utils/models/user_model.dart';
import 'package:damma_project/features/home/manager/news_feed_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../views/widgets/final_post_section.dart';

class NewsFeedListView extends StatelessWidget {
  final UserModel userModel;

  const NewsFeedListView({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsFeedCubit, NewsFeedState>(
      builder: (context, state) {
        if (state is NewsFeedLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ));
        } else if (state is NewsFeedSuccess) {
          return ListView.separated(
            physics:const NeverScrollableScrollPhysics(),
           shrinkWrap: true,
              itemCount: state.posts.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) => FinalPostSection(
              newsFeedModel: state.posts[index],
              userModel: userModel,
            ),
          );
        } else if (state is NewsFeedFailure) {
          return Center(child: Text("Error: ${state.error}"));
        }
        return const SizedBox.shrink();
      },
    );
  }
}

// class NewsFeedListView extends StatelessWidget {
//   const NewsFeedListView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<NewsFeedCubit, NewsFeedState>(
//       builder: (context, state) {
//         if (state is NewsFeedLoading) {
//           return const Center(
//               child: CircularProgressIndicator(
//             color: AppColors.primaryColor,
//           ));
//         } else if (state is NewsFeedSuccess) {
//           return ListView.separated(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: state.posts.length,
//             separatorBuilder: (_, __) => const SizedBox(height: 20),
//             itemBuilder: (context, index) => FinalPostSection(
//               newsFeedModel: state.posts[index],
//             ),
//           );
//         } else if (state is NewsFeedFailure) {
//           return Center(child: Text("Error: ${state.error}"));
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
