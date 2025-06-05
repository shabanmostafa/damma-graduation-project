// features/add_post/manager/post_state.dart

part of 'post_cubit.dart';

sealed class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

final class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostSuccess extends PostState {
  final String message;
  const PostSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class PostFailure extends PostState {
  final String error;
  const PostFailure(this.error);

  @override
  List<Object> get props => [error];
}
