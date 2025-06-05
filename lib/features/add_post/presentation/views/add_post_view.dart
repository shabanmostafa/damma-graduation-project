// import 'package:damma_project/core/utils/app_colors.dart';
// import 'package:damma_project/core/utils/models/user_model.dart';
// import 'package:damma_project/features/add_post/presentation/views/widgets/add_post_view_body.dart';
// import 'package:flutter/material.dart';

// class AddPostView extends StatelessWidget {
//   final UserModel user;
//   const AddPostView({super.key, required this.user});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       body: SafeArea(child: AddPostViewBody(user: user)),
//     );
//   }
// }

import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/di/service_locator.dart';
import 'package:damma_project/core/utils/models/user_model.dart';
import 'package:damma_project/features/add_post/manager/post_cubit.dart';
import 'package:damma_project/features/add_post/presentation/views/widgets/add_post_view_body.dart';
import 'package:damma_project/features/add_post/presentation/views/widgets/post_state_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPostView extends StatelessWidget {
  final UserModel user;
  const AddPostView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => getIt<PostCubit>(),
          child: BlocListener<PostCubit, PostState>(
            listener: (context, state) {
              if (state is PostSuccess) {
                PostStateDialog.showBottomPopup(context, true);
              } else if (state is PostFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            child: AddPostViewBody(user: user),
          ),
        ),
      ),
    );
  }
}
