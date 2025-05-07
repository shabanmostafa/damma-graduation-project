import 'package:damma_project/features/friend_requests/manager/cubit/friend_cubit.dart';
import 'package:damma_project/features/friend_requests/manager/cubit/friend_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:damma_project/core/utils/app_styles.dart';
import 'package:damma_project/core/utils/app_colors.dart';
import 'package:damma_project/core/utils/functions/list_tile_type.dart';
import 'package:damma_project/core/utils/widgets/reusable_list_tile.dart';
import 'package:damma_project/generated/l10n.dart';

class FriendList extends StatelessWidget {
  const FriendList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendCubit, FriendState>(
      builder: (context, state) {
        if (state is FriendLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        } else if (state is FriendSuccess) {
          if (state.requests.isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    S.of(context).FriendSuggetions,
                    style: AppStyles.styleBold16,
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: state.suggestions.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      return ReusableListTile(
                        user: state.suggestions[index],
                        type: UserItemType.suggestion,
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return ListView.separated(
              itemCount: state.requests.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                return ReusableListTile(
                  user: state.requests[index],
                  type: UserItemType.friendRequest,
                );
              },
            );
          }
        } else if (state is FriendFailure) {
          return Center(
            child: Text(
              state.error,
              style: AppStyles.styleMedium16,
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
