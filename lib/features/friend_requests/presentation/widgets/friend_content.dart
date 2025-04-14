import 'package:damma_project/features/friend_requests/manager/cubit/friend_cubit.dart';
import 'package:damma_project/features/friend_requests/manager/cubit/friend_state.dart';
import 'package:damma_project/features/friend_requests/presentation/widgets/friend_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:damma_project/core/utils/widgets/custom_app_bar.dart';
import 'package:damma_project/generated/l10n.dart';

class FriendContent extends StatelessWidget {
  const FriendContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          BlocBuilder<FriendCubit, FriendState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomAppBar(
                  text: S.of(context).FriendRequests,
                  needArrow: true,
                ),
              );
            },
          ),
          const Expanded(child: FriendList()),
        ],
      ),
    );
  }
}
