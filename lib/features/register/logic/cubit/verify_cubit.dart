import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/repos/verify_repo/verify_repo.dart';

part 'verify_state.dart';

class VerifyCubit extends Cubit<VerifyState> {
  final VerifyRepo verifyRepo;

  VerifyCubit(this.verifyRepo) : super(VerifyInitial());

  Future<void> verify(String email, String verificationCode) async {
    emit(VerifyLoading());
    try {
      final message = await verifyRepo.verify(email, verificationCode);
      emit(VerifySuccess(message));
    } catch (e) {
      emit(VerifyFailure(e.toString()));
    }
  }

  Future<void> resendVerificationCode(String email) async {
    emit(VerifyLoading());
    try {
      final message = await verifyRepo.resendVerificationCode(email);
      emit(VerifyResendSuccess(message)); // 👈 New state
    } catch (e) {
      emit(VerifyFailure(e.toString()));
    }
  }
}
