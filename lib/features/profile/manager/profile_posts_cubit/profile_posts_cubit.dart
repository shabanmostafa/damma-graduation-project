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

// profile_posts_cubit.dart

  Future<bool> addComment(int postId, String content) async {
    try {
      await _repo.addComment(postId, content);
      return true;
    } catch (e) {
      // Optional: print or log error
      return false;
    }
  }

  Future<void> addReaction(int postId, String reactionType) async {
    final result = await _repo.addReaction(postId, reactionType);
    result.fold(
      (failure) => null, // Handle error if needed
      (_) => null, // Success - UI will handle the update
    );
  }

  Future<void> removeReaction(int postId) async {
    final result = await _repo.removeReaction(postId);
    result.fold(
      (failure) => null, // Handle error if needed
      (_) => null, // Success - UI will handle the update
    );
  }
}
