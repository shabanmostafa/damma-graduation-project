import 'package:damma_project/features/friend_requests/manager/cubit/friend_state.dart';
import 'package:damma_project/features/search/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendCubit extends Cubit<FriendState> {
  FriendCubit() : super(FriendInitial());

  Future<void> fetchFriendRequests() async {
    emit(FriendLoading());
    try {
      await Future.delayed(Duration(seconds: 1));

      final requests = <UserModel>[
        UserModel(
          name: "Mona ahmed mohamed",
          jobTitle: "Writer",
          imageUrl: "assets/images/shaban.jpg",
        ),
        UserModel(
          name:
              "Youssef aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          jobTitle: "UI Designer",
          imageUrl: "assets/images/shaban.jpg",
        ),
        UserModel(
          name: "Mona ahmed mohamed",
          jobTitle: "Writer",
          imageUrl: "assets/images/shaban.jpg",
        ),
        UserModel(
          name:
              "Youssef aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          jobTitle: "UI Designer",
          imageUrl: "assets/images/shaban.jpg",
        ),
      ];

      if (requests.isEmpty) {
        final suggestions = [
          UserModel(
            name: "Mona ahmed mohamed",
            jobTitle: "Writer",
            imageUrl: "assets/images/shaban.jpg",
          ),
          UserModel(
            name:
                "Youssef aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
            jobTitle: "UI Designer",
            imageUrl: "assets/images/shaban.jpg",
          ),
          UserModel(
            name: "Mona ahmed mohamed",
            jobTitle: "Writer",
            imageUrl: "assets/images/shaban.jpg",
          ),
          UserModel(
            name:
                "Youssef aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
            jobTitle: "UI Designer",
            imageUrl: "assets/images/shaban.jpg",
          ),
        ];

        emit(FriendSuccess(requests: requests, suggestions: suggestions));
      } else {
        emit(FriendSuccess(requests: requests));
      }
    } catch (e) {
      emit(FriendFailure("Something went wrong"));
    }
  }
}
