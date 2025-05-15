part of 'verify_cubit.dart';

@immutable
abstract class VerifyState {}

class VerifyInitial extends VerifyState {}

class VerifyLoading extends VerifyState {}

class VerifySuccess extends VerifyState {
  final String message;

  VerifySuccess(this.message);
}

class VerifyFailure extends VerifyState {
  final String error;

  VerifyFailure(this.error);
}

class VerifyResendSuccess extends VerifyState {
  final String message;

  VerifyResendSuccess(this.message);
}
