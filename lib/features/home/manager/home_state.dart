part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final UserModel user;
  HomeSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class HomeFailure extends HomeState {
  final String message;
  HomeFailure(this.message);

  @override
  List<Object?> get props => [message];
}
