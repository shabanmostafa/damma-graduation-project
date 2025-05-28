// import 'package:damma_project/features/isNotFriend/data/repo/friend_repo.dart';
// import 'package:damma_project/features/isNotFriend/manager/friend_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class FriendCubit extends Cubit<FriendState> {
//   final FriendRepo friendRepo;

//   FriendCubit(this.friendRepo) : super(FriendInitial());

//   // friend_cubit.dart
//   Future<void> sendFriendRequest(int receiverId) async {
//     emit(FriendLoading()); // Start loading
//     final result = await friendRepo.sendFriendRequest(receiverId);
//     result.fold(
//       (error) => emit(FriendFailure(error)), // On error
//       (_) => emit(FriendRequestSentSuccess()),
//     );
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:damma_project/features/isNotFriend/data/repo/friend_repo.dart';
import 'package:damma_project/features/isNotFriend/manager/friend_state.dart';

class FriendCubit extends Cubit<FriendState> {
  final FriendRepo friendRepo;

  FriendCubit(this.friendRepo) : super(FriendInitial());

  Future<void> sendFriendRequest(int receiverId) async {
    emit(FriendLoading());
    final result = await friendRepo.sendFriendRequest(receiverId);
    result.fold(
      (error) => emit(FriendFailure(error)),
      (_) => emit(FriendRequestSentSuccess()),
    );
  }
}
