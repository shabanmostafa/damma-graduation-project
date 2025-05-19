import 'package:damma_project/features/my_friends/data/repo/my_friends_repo.dart';
import 'package:damma_project/features/my_friends/manager/my_friends_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyFriendsCubit extends Cubit<MyFriendsState> {
  final MyFriendsRepo _repo;

  MyFriendsCubit(this._repo) : super(MyFriendsInitial());

  Future<void> fetchFriends() async {
    emit(MyFriendsLoading());
    final result = await _repo.getFriendsList();

    result.fold(
      (failure) => emit(MyFriendsFailure(failure)),
      (friendsList) => emit(MyFriendsSuccess(friendsList)),
    );
  }
}
