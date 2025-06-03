// import 'package:damma_project/core/utils/app_colors.dart';
// import 'package:damma_project/core/utils/app_styles.dart';
// import 'package:damma_project/core/utils/functions/list_tile_type.dart';
// import 'package:damma_project/core/utils/widgets/custom_app_bar.dart';
// import 'package:damma_project/features/my_friends/manager/my_friends_cubit.dart';
// import 'package:damma_project/features/my_friends/manager/my_friends_states.dart';
// import 'package:damma_project/features/my_friends/presentation/widgets/my_freind_list_tile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class MyFriendsViewBody extends StatelessWidget {
//   const MyFriendsViewBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<MyFriendsCubit, MyFriendsState>(
//       listener: (context, state) {
//         if (state is FriendDeletedSuccessfully) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text(
//                 "تم حذف الصديق بنجاح",
//                 style: TextStyle(color: AppColors.whiteColor),
//               ),
//               backgroundColor: AppColors.primaryColor,
//               duration: Duration(seconds: 2),
//             ),
//           );
//         } else if (state is MyFriendsFailure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 state.error,
//                 style: const TextStyle(color: AppColors.whiteColor),
//               ),
//               backgroundColor: AppColors.red500Color,
//               duration: const Duration(seconds: 2),
//             ),
//           );
//         }
//       },
//       builder: (context, state) {
//         if (state is MyFriendsLoading) {
//           return const Center(
//             child: CircularProgressIndicator(color: AppColors.primaryColor),
//           );
//         } else if (state is MyFriendsSuccess) {
//           final friends = state.friends.isNotEmpty ? state.friends[0].data : [];
//           if (friends == null || friends.isEmpty) {
//             return Column(
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: CustomAppBar(
//                     needArrow: true,
//                     text: 'الأصدقاء',
//                   ),
//                 ),
//                 Expanded(
//                   child: Center(
//                     child: Text(
//                       "لا يوجد أصدقاء",
//                       style: AppStyles.styleMedium16,
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           }

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: CustomAppBar(
//                   needArrow: true,
//                   text: 'الأصدقاء',
//                 ),
//               ),
//               const Divider(color: AppColors.hintTextColor, thickness: .25),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   '${state.friends.first.totalCount ?? friends.length} صديق',
//                   style: AppStyles.styleMedium16.copyWith(
//                     color: AppColors.blackTextColor,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: RefreshIndicator(
//                   onRefresh: () =>
//                       context.read<MyFriendsCubit>().fetchFriends(),
//                   child: ListView.separated(
//                     separatorBuilder: (_, __) => Padding(
//                       padding: EdgeInsets.only(right: 55.0.w, left: 15.0.w),
//                       child: const Divider(),
//                     ),
//                     itemCount: friends.length,
//                     itemBuilder: (context, index) {
//                       final friend = friends[index];
//                       return MyFriendListTile(
//                         friend: friend,
//                         type: UserItemType.friend,
//                         onDelete: () {
//                           if (friend.friendId != null) {
//                             context
//                                 .read<MyFriendsCubit>()
//                                 .deleteFriend(friend.friendId!);
//                           } else {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text(
//                                   "تعذر العثور على معرف الصديق",
//                                   style: TextStyle(color: AppColors.whiteColor),
//                                 ),
//                                 backgroundColor: AppColors.red500Color,
//                                 duration: Duration(seconds: 2),
//                               ),
//                             );
//                           }
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           );
//         } else {
//           return Column(
//             children: [
//               const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: CustomAppBar(
//                   needArrow: true,
//                   text: 'الأصدقاء',
//                 ),
//               ),
//               Expanded(
//                 child: Center(
//                   child: Text(
//                     "حدث خطأ ما!",
//                     style: AppStyles.styleMedium16,
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }
//       },
//     );
//   }
// }

import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/functions/list_tile_type.dart';
import 'package:damma_project/core/utils/widgets/custom_app_bar.dart';
import 'package:damma_project/features/my_friends/manager/my_friends_cubit.dart';
import 'package:damma_project/features/my_friends/manager/my_friends_states.dart';
import 'package:damma_project/features/my_friends/presentation/widgets/my_freind_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyFriendsViewBody extends StatelessWidget {
  const MyFriendsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyFriendsCubit, MyFriendsState>(
      listener: (context, state) {
        if (state is FriendDeletedSuccessfully) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "تم حذف الصديق بنجاح",
                style: TextStyle(color: AppColors.whiteColor),
              ),
              backgroundColor: AppColors.primaryColor,
              duration: Duration(seconds: 2),
            ),
          );
        } else if (state is MyFriendsFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
                style: const TextStyle(color: AppColors.whiteColor),
              ),
              backgroundColor: AppColors.red500Color,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is MyFriendsLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        } else if (state is MyFriendsSuccess) {
          final friends = state.friends.isNotEmpty ? state.friends[0].data : [];

          if (friends == null || friends.isEmpty) {
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomAppBar(
                    needArrow: true,
                    text: 'الأصدقاء',
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "ليس لديك أصدقاء",
                      style: AppStyles.styleMedium16.copyWith(
                        color: AppColors.blackTextColor,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomAppBar(
                  needArrow: true,
                  text: 'الأصدقاء',
                ),
              ),
              const Divider(color: AppColors.hintTextColor, thickness: .25),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${state.friends.first.totalCount ?? friends.length} صديق',
                  style: AppStyles.styleMedium16.copyWith(
                    color: AppColors.blackTextColor,
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () =>
                      context.read<MyFriendsCubit>().fetchFriends(),
                  child: ListView.separated(
                    separatorBuilder: (_, __) => Padding(
                      padding: EdgeInsets.only(right: 55.0.w, left: 15.0.w),
                      child: const Divider(),
                    ),
                    itemCount: friends.length,
                    itemBuilder: (context, index) {
                      final friend = friends[index];
                      return MyFriendListTile(
                        friend: friend,
                        type: UserItemType.friend,
                        onDelete: () {
                          if (friend.friendId != null) {
                            context
                                .read<MyFriendsCubit>()
                                .deleteFriend(friend.friendId!);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "تعذر العثور على معرف الصديق",
                                  style: TextStyle(color: AppColors.whiteColor),
                                ),
                                backgroundColor: AppColors.red500Color,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomAppBar(
                  needArrow: true,
                  text: 'الأصدقاء',
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "حدث خطأ ما!",
                    style: AppStyles.styleMedium16,
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
