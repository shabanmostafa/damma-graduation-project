// profile_posts_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:damma_project/features/profile/data/repo/profile_repo.dart';
import 'package:damma_project/features/profile/manager/profile_posts_cubit/profile_posts_states.dart';

class ProfilePostsCubit extends Cubit<ProfilePostsState> {
  final ProfileRepo _repo;

  ProfilePostsCubit(this._repo) : super(ProfilePostsInitial());

  Future<void> getProfilePosts(int userId) async {
    emit(ProfilePostsLoading());
    final result = await _repo.getProfilePosts(userId);
    result.fold(
      (failure) => emit(ProfilePostsFailure(failure)),
      (posts) => emit(ProfilePostsSuccess(posts)),
    );
  }
}
