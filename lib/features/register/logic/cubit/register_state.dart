// part of 'register_cubit.dart';

// @immutable
// sealed class RegisterState {}

// final class RegisterInitial extends RegisterState {}

// final class RegisterLoading extends RegisterState {}

// final class RegisterSuccess extends RegisterState {
//   final RegisterModel response;
//   RegisterSuccess(this.response);

//   @override
//   List<Object?> get props => [response];
// }

// final class RegisterFailure extends RegisterState {
//   final String message;
//   RegisterFailure(this.message);

//   @override
//   List<Object?> get props => [message];
// }

part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String message;
  RegisterSuccess(this.message);
}

class RegisterFailure extends RegisterState {
  final String error;
  RegisterFailure(this.error);
}
