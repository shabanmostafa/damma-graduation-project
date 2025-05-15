// part of 'login_cubit.dart';

// sealed class LoginState extends Equatable {
//   const LoginState();

//   @override
//   List<Object> get props => [];
// }

// final class LoginInitial extends LoginState {}

// class LoginLoading extends LoginState {}

// class LoginSuccess extends LoginState {
//   final LoginResponse response;
//   LoginSuccess(this.response);
// }

// class LoginFailure extends LoginState {
//   final String message;
//   LoginFailure(this.message);
// }

part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponse response;
  const LoginSuccess(this.response);
}

class LoginFailure extends LoginState {
  final String message;
  const LoginFailure(this.message);
}
