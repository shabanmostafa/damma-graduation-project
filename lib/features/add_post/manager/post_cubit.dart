// features/add_post/manager/post_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:damma_project/features/add_post/data/repo/post_repo_imp.dart';
import 'package:equatable/equatable.dart';
import '../data/models/add_post_model.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepoImpl postRepo;

  PostCubit(this.postRepo) : super(PostInitial());

  Future<void> addPost(AddPostModel post) async {
    emit(PostLoading());
    try {
      final response = await postRepo.addPost(post);
      emit(PostSuccess(response));
    } catch (e) {
      emit(PostFailure(e.toString()));
    }
  }
}
