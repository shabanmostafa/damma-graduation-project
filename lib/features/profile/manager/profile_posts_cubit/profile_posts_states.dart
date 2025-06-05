// profile_posts_states.dart

import 'package:damma_project/features/profile/data/models/profile_post_model.dart';

abstract class ProfilePostsState {}

class ProfilePostsInitial extends ProfilePostsState {}

class ProfilePostsLoading extends ProfilePostsState {}

class ProfilePostsSuccess extends ProfilePostsState {
  final ProfilePostModel posts;
  ProfilePostsSuccess(this.posts);
}

class ProfilePostsFailure extends ProfilePostsState {
  final String error;
  ProfilePostsFailure(this.error);
}
