// import 'package:damma_project/features/my_friends/data/models/my_friends_model/my_friends_model.dart';
// import 'package:damma_project/features/my_friends/data/repo/my_friends_repo.dart';
// import 'package:damma_project/features/my_friends/manager/my_friends_states.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class MyFriendsCubit extends Cubit<MyFriendsState> {
//   final MyFriendsRepo _repo;
//   List<MyFriendsModel> friendsList = [];

//   MyFriendsCubit(this._repo) : super(MyFriendsInitial());

//   Future<void> fetchFriends() async {
//     emit(MyFriendsLoading());
//     final result = await _repo.getFriendsList();

//     result.fold(
//       (failure) => emit(MyFriendsFailure(failure)),
//       (friends) {
//         friendsList = friends;
//         emit(MyFriendsSuccess(friends));
//       },
//     );
//   }

//   Future<void> deleteFriend(int friendId) async {
//     final currentState = state;
//     if (currentState is MyFriendsSuccess) {
//       try {
//         emit(MyFriendsLoading());
//         final result = await _repo.deleteFriend(friendId);

//         result.fold(
//           (failure) {
//             emit(MyFriendsFailure(failure));
//             emit(currentState); // Revert to previous state
//           },
//           (_) {
//             // Remove the friend from the list
//             friendsList = friendsList.map((model) {
//               return MyFriendsModel(
//                 data: model.data
//                     ?.where((friend) => friend.friendId != friendId)
//                     .toList(),
//               );
//             }).toList();

//             emit(MyFriendsSuccess(friendsList));

//             // Show success message through state if needed
//             emit(FriendDeletedSuccessfully(friendId));
//             emit(MyFriendsSuccess(friendsList)); // Return to success state
//           },
//         );
//       } catch (e) {
//         emit(MyFriendsFailure(e.toString()));
//         emit(currentState); // Revert to previous state
//       }
//     }
//   }
// }

import 'package:damma_project/features/my_friends/data/models/my_friends_model/my_friends_model.dart';
import 'package:damma_project/features/my_friends/data/repo/my_friends_repo.dart';
import 'package:damma_project/features/my_friends/manager/my_friends_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyFriendsCubit extends Cubit<MyFriendsState> {
  final MyFriendsRepo _repo;
  List<MyFriendsModel> friendsList = [];

  MyFriendsCubit(this._repo) : super(MyFriendsInitial());

  Future<void> fetchFriends() async {
    emit(MyFriendsLoading());
    final result = await _repo.getFriendsList();

    result.fold(
      (failure) => emit(MyFriendsFailure(failure)),
      (friends) {
        friendsList = friends;
        emit(MyFriendsSuccess(friends));
      },
    );
  }

  Future<void> deleteFriend(int friendId) async {
    final currentState = state;
    if (currentState is MyFriendsSuccess) {
      try {
        emit(MyFriendsLoading());
        final result = await _repo.deleteFriend(friendId);

        result.fold(
          (failure) {
            emit(MyFriendsFailure(failure));
            emit(currentState); // Revert to previous state
          },
          (_) {
            // Remove the friend from the list
            friendsList = friendsList.map((model) {
              return MyFriendsModel(
                data: model.data
                    ?.where((friend) => friend.friendId != friendId)
                    .toList(),
              );
            }).toList();

            emit(MyFriendsSuccess(friendsList));

            // Show success message through state if needed
            emit(FriendDeletedSuccessfully(friendId));
            emit(MyFriendsSuccess(friendsList)); // Return to success state
          },
        );
      } catch (e) {
        emit(MyFriendsFailure(e.toString()));
        emit(currentState); // Revert to previous state
      }
    }
  }
}
